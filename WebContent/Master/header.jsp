<%@ page import="com.ebook.member.dao.MemberDao"%>
<%@ page import="com.ebook.account.dao.Account"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    String path = request.getContextPath(); 
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%> 
<link href="<%=path %>/Css/header.css" rel="stylesheet" />

<link href="<%=path %>/Css/bootstrap.css" rel="stylesheet" />
<script  type="text/javascript" src="<%=path %>/Js/jquery-1.9.1.js" ></script>
<script src="/Js/bootstrap.js"></script>
<script src="/Js/jquery-ui.js"></script>
<meta name="keywords" content="生物,基础医学,临床医学,药学,电子图书,电子资源,pdf下载,医学资源,医学文献,医生,临床,医学知识,病例,医学考试,论文,实验方法,基因,数据库,疾病,社区,用药" />
<meta name="description" content="imed120.com通过搜集整理网上零星散在生物医药PDF、WORD、PPT等形式电子资源，为广大生物医药专业人士提供生物、基础医学、临床医学、药学等文献资源服务，仅供个人学习参考使用。" />

    <div class="sitetop">
        <% 
         
          String username = (String)session.getAttribute("username"); 
          String uid = (String)session.getAttribute("uid");
          String email = (String)session.getAttribute("email");
          String account = (String) Account.Balance(uid);;
          String state = (String)String.valueOf(session.getAttribute("state"));
          String level = (String)session.getAttribute("level");
		%>
        <div class="loginleft">
            <span id="username">游客</span>,欢迎来到MedPdf网站！
            <label style="display: none" id="tips"></label>
             <span class="accountbox"><span id="accountHead"></span></span>
        </div>
        <div class="loginright">
           
			<ul id="mycenter" class="all">				
				<li>个人中心<b class="tri"></b><ul>
				      <li><a class="active" href="/MyCenter/Myinfo.jsp">个人信息</a></li>
				      <li><a href="/MyCenter/MyResourse.jsp">资源管理</a></li>
				      <li><a href="/MyCenter/MyAccount.jsp">账务中心</a></li>
				      <li><a href="/MyCenter/ChangePassword.jsp">修改密码</a></li>
				  </ul>
				</li>
				
			</ul>
		   <span id="recharge"></span>
           <span id="login"><a href="<%=path %>/Member/login.jsp">登&nbsp;&nbsp;录</a></span>
           
		   <span id="regist"><a href="<%=path %>/Member/register.jsp">免费注册</a></span>
		  
        </div>
    </div>

    <div class="header">
        <div class="logo">
            <a href="/index.jsp">
                <img src="<%=path %>/Images/logo.png" /></a>
        </div>
        <div class="search">
            <div class="searchbox">
                <input id="keys" type="text" class="search_txtbox" value="">
                <input id="search" name="search" class="searchbtn" type="button" onclick="Search();" value="搜索">
            </div>
        </div>

        <div class="clear"></div>
    </div>
   <div class="navibar" id="navibar">
            <ul>
                <li class="home"><a href="/index.jsp"><span></span>首&nbsp;&nbsp;页</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=0">全&nbsp;&nbsp;&nbsp;部</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=1">临床医学</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=2">基础医学</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=3">药&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学</a></li>
               
            </ul>
        </div>
        
 <!-- Modal -->
<div class="modal fade" id="headmodal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false"  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h2 class="modal-title">提示Tips：</h2>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>       
<script type="text/javascript">
        getsession();
		$(function(){	
			$('.all>li').hover(function(e) {
		        $(this).children("ul").stop().slideToggle()
		    });
		}); 
			

       function Search(){
    	  var keys =$("#keys").val();
    	  
    	  if(keys==""){
    	      alert("搜索条件不能为空！");
    	  }
    	  else if(keys.length>36){
    		  alert("搜索条件限制在36个中文字符！")
    		  
    	  }
    	  else{
    		  var url ="/SearchList/searchlist.jsp?search="+encodeURI(keys);
        	  window.location.href =url;
    	  }
       }
       function getsession(){
    	   var username = "<%=username%>";
    	   var uid = "<%=uid%>";
    	   var email="<%=email%>";
    	   var account = "<%=account%>";   	  
    	   var level="<%=level%>";
    	   var state="<%=state%>";
    	   
           if(username!="null"){
        	   $("#accountHead").html("账户余额：<a href='/MyCenter/MyAccount.jsp'>"+account+"资源点</a>");
        	   $("#mycenter").css("display","block");
             $("#username").html("<a href='/MyCenter/Myinfo.jsp'>"+username+"</a>");
             $("#regist").hide();
             $("#recharge").html('<a href="/DoOrder/OrderSelect.jsp">充&nbsp;&nbsp;值</a>');
             $("#login").html('<a href="<%=path%>/LoginOut">注&nbsp;&nbsp;销</a>');
              
           }
           else{
        	   $("#accountHead").html("");
        	   $("#mycenter").css("display","none");
        	   $("#login").html('<a href="/Member/login.jsp">登&nbsp;&nbsp;录</a>');
        	   $("#username").html("游客");
        	   $("#recharge").html("");
        	   $("#regist").show(); 
           }
       }
       function checklogin(){
    	   var username = "<%=username%>";
	   
           if(username=="null"||username==""){        	  
        	   location.href="/Member/login.jsp";
           }
           
       }
       function checklogined(){
     	   var username = "<%=username%>";
     	   var uid = "<%=uid%>";
     	   var email="<%=email%>";
     	   var account = "<%=account%>";
     	   var state="<%=state%>";
     	   var level="<%=level%>";
     	   
            if(uid!="null"){
            	 $("#headmodal").draggable({
                     cursor: "move",
                     handle: '.modal-header',
                 });    	                            
           	  //modal居中  
          	   $("#headmodal .modal-body").html("<p>目前已经登录，请您先<a href='<%=path%>/LoginOut'>“注销”</a>登录状态！</p>");
          	   $("#headmodal").modal("show");
          	 $('#headmodal').on("hidden.bs.modal", function () {
         		//关闭模态框后清除模态框数据
         		shutdown();
         		});
            }
        }

       function shutdown() {     
   		//判断是否为ie
           if (navigator.userAgent.indexOf("MSIE") > 0) {
               //判断是否为ie6
               if (navigator.userAgent.indexOf("MSIE 6.0") > 0) {
                   window.opener = null; window.close();
               }
               else {
                   window.open('', '_top');
                   window.top.close();
               }
           }
           //判断是否为firefox
           else if (navigator.userAgent.indexOf("Firefox") > 0) {
        	   window.location.href = '/index.jsp';
           }
           //其他非firefox等主流浏览器如chrome,safari
           else {
               window.opener = null; 
               window.open('', '_self', '');
               window.close();
           }
   	}
</script>
  
<script src="http://pv.sohu.com/cityjson?ie=utf-8"></script>

<script type="text/javascript">  
var ip = returnCitySN["cip"];	//定义IP
var city = returnCitySN["cname"];	//定义城市
//document.write(city1);
if (city.indexOf("北京") > -1) {
    location.href = "/Error";
}
</script>