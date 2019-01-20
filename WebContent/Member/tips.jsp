
<%--
 String spath = request.getContextPath(); 
 Member member  = (Member)request.getSession().getAttribute(Constant.SESSION_USER);
 if(member==null){
 	response.sendRedirect(spath+"/Member/login.jsp");
 }
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.ebook.utils.StringUtil"%>
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人信息-用户注册</title>
<link href="<%=path %>/Css/bootstrap.css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="<%=path %>/Css/reg.css" />
<script  type="text/javascript" src="<%=path %>/Js/bootstrap.js" ></script>

</head>
<script type="text/javascript">
	(function($) {

			$.getUrlParam = function(name)
		{
			var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
		if (r!=null) return unescape(r[2]); return null;
			}
		
	}(jQuery));
	//回车登录
	$(document).ready(function () {

		$(document).keyup(function (evnet) {
		if (evnet.keyCode == '13') {
			login();
		}
		});

		});
	
</script>
<body>
 <div class="reg_form">    <!-- Modal -->
	<div  class="reg_content" >
	  <h2>提示Tips：</h2>
	  <br>
      <div class="actmail">
          <h3 id="tipbox"></h3>         
      </div>
	 
	</div>
 </div>
	<%
		String checkResult = (String) request.getSession().getAttribute("checkResult");
	    String actmail = (String) request.getSession().getAttribute("email");
	    String i_uid = (String) request.getSession().getAttribute("uid");
	    String loginid =  (String) request.getSession().getAttribute("loginid");
		if (StringUtil.isBlank(checkResult)) {
			checkResult = " ";
		}
	%>

	<script type="text/javascript">

	var check,actmail,i_uid,loginid,domain;
		
		actmail="<%=actmail%>";
		i_uid="<%=i_uid%>";
		loginid="<%=loginid%>";
		check ="<%=checkResult%>";
	    domain = actmail.substring(actmail.indexOf("@")+1);
		domain = "http://mail."+domain;
		if (check == "已激活") {
                $('#tipbox').html("<b>邮箱已激活！请完善个人信息。<\/b>");
				
		}  else if(check == "不存在此激活链接"){
		       $('#tipbox').html("<b>不存在此激活链接！<a id='' href='javascript:close();'>关闭</a>本页面后返回首页。</b>");
				
		}
		else if(check == "链接已失效"){
		       $('#tipbox').html("<b>激活链接当日有效，该链接已失效！请<button type='button' id='rebtn'   onclick='SendMail();'>重新发送激活邮件!</button>。<a href='javascript:close();'>关闭</a>本页面后返回首页。</b>");
				
		} else if(check == "激活失败"){
		       $('#tipbox').html("<b>激活失败！请检查激活邮件中激活链接地址是否无误。<a href='javascript:close();'>关闭</a>本页面后返回首页。</b>");
				
		}
		else{
			location.href = "/Member/login.jsp";
		};
		
		
	function close(){
		window.location.href = '/index.jsp';
		
	};
	function SendMail(){
		
        $.ajax({
            url: "<%=path%>/reSendMail",
            type: 'post',
            async: true,
            timeout:60000,
            dataType: 'text',
            data: {actmail:actmail},
            beforeSend: function () {
		        // 禁用按钮防止重复提交
		        $("#rebtn").attr({ disabled: "disabled" });
		    },
            success: function (data) {
            	if(data=="true"){
               	 $("#headmodal").draggable({
                     cursor: "move",
                     handle: '.modal-header',
                 });    	                            
           	  //modal居中  
	          	   $("#headmodal .modal-body").html("<p>激活邮件已发送到您的邮箱"+actmail+",请您<a href='"+domain+"'>登录邮箱</a>后点击邮件中激活链接以激活邮箱！</p>");
	          	   $("#headmodal").modal("show");
	          	   $('#headmodal').on("hidden.bs.modal", function () {
	         		//关闭模态框后清除模态框数据
	         		shutdown();
	         		});
            	}           	
            	else{
            	   $("#headmodal .modal-body").html("<p>重发邮件失败！请联系管理员:imed120@163.com!</p>");
  	          	   $("#headmodal").modal("show");
            		
            	}
                
            },
            error: function (err) {
            	 alert("重发邮件失败！请联系管理员:imed120@163.com");
            	 return;
            	}                   
        });
		
	};
    </script>
	
	  <%@ include file="/Master/footer.jsp"%>

	
</body>
</html>