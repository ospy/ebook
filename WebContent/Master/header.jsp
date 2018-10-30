
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    String path = request.getContextPath(); 
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%> 
<link href="<%=path %>/Css/header.css" rel="stylesheet" />
<link href="<%=path %>/Css/main.css" rel="stylesheet" />
<link href="<%=path %>/Css/bootstrap.css" rel="stylesheet" />
<script  type="text/javascript" src="<%=path %>/Js/jquery-1.9.1.js" ></script>
<script src="/Js/bootstrap.js"></script>
<script src="/Js/jquery-ui.js"></script>

    <div class="sitetop">
        <% String username = (String)session.getAttribute("username"); 
          String uid = (String)session.getAttribute("uid");
          String email = (String)session.getAttribute("email");
          String account = (String)session.getAttribute("account");
          String state = (String)String.valueOf(session.getAttribute("state"));
          String level = (String)session.getAttribute("level");
		%>
        <div class="loginleft">
            <span id="username"></span>,欢迎来到MedPdf网站！
            <label style="display: none" id="tips"></label>
             <span class="accountbox"><span id="accountHead"></span></span>
        </div>
        <div class="loginright">
           
           <nav> <ul class="loginright_ul nav-list">
               
                <li id="mycenter"><a class="active" href="/MyCenter/Myinfo.jsp">个人中心  <b class="tri"></b></a>
                    <div id="dropdown_menu" class="menu"><ul>
                        <li class="alt"><a href="/MyCenter/MyResourse.jsp">资源管理</a></li>
                        <li class="alt"><a href="/MyCenter/MyAccount.jsp">账务中心</a></li>
                        <li class="alt"><a href="/MyCenter/ChangePassword.jsp">修改密码</a></li>
                    </ul></div>
                </li>
                <li><span id="login"><a href="<%=path %>/Member/login.jsp">登&nbsp;&nbsp;录</a></span></li>
                <li><span id="regist"><a href="<%=path %>/Member/register.jsp">免费注册</a></span></li>
            </ul>
           </nav>
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
<div class="modal fade" id="headmodal" tabindex="-1" role="dialog"  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h2 class="modal-title">邮箱激活</h2>
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


			login();  
			

       function Search(){
    	  var keys =$("#keys").val();
    	  alert(keys.length);
    	  if(keys==""){
    	      alert("搜索条件不能为空！");
    	  }
    	  else if(keys.length>36){
    		  alert("搜索条件限制在36个中文字符！")
    		  
    	  }
    	  else{
    		  var url ="http://localhost:8080/SearchList/searchlist.jsp?search="+encodeURI(keys);
        	  window.location.href =url;
    	  }
       }

       function login(){
    	   var username = "<%=username%>";
    	   var uid = "<%=uid%>";
    	   var email="<%=email%>";
    	   var account = "<%=account%>";
    	   var state="<%=state%>";
    	   var level="<%=level%>";
    	   
    	  
           if(username!="null"){
        	   $("#accountHead").html("账户余额：<a href='#'>"+account+"资源点</a>");
        	   $("#mycenter").css("display","block");
             $("#username").html("<a href='/MyCenter/Myinfo.jsp'>"+username+"</a>");
             $("#login").html('<a href="<%=path%>/LoginOut">注&nbsp;&nbsp;销</a>');
           }
           else{
        	   $("#login").html('<a href="/Member/login.jsp">登&nbsp;&nbsp;录</a>');
        	   $("#username").html("游客");
           }
           //判断邮箱是否激活
           if(state==1){
        	   $("#headmodal").draggable({
                   cursor: "move",
                   handle: '.modal-header',
               });    	                            
         	  //modal居中  
        	   $("#headmodal .modal-body").html("<p>请到注册的个人邮箱:  "+email+"  中激活账户！</p>");
        	   $("#headmodal").modal("show");
    	   }
         //判断个人信息是否完善
           if(state==2){
        	   $("#headmodal").draggable({
                   cursor: "move",
                   handle: '.modal-header',
               });    	                            
         	  //modal居中  
        	   $("#headmodal .modal-body").html("<p>请您<a target='_blank' href='/MyCenter/Myinfo.jsp'>完善个人信息！</a></p>");
        	   $("#headmodal").modal("show");
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