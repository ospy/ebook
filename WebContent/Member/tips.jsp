
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

	var check,actmail,i_uid,loginid;
		
		actmail="<%=actmail%>";
		i_uid="<%=i_uid%>";
		loginid="<%=loginid%>";
		check ="<%=checkResult%>";
		if (check == "已激活") {
                $('#tipbox').html("<b>邮箱已激活！请完善个人信息。<\/b>");
				
		}  else if(check == "不存在此激活链接"){
		       $('#tipbox').html("<b>不存在此激活链接！<a href='javascript:close();'>关闭</a>本页面后返回首页。</b>");
				
		}
		else if(check == "链接已失效"){
		       $('#tipbox').html("<b>该链接已失效！请<a href='/Member/actmail.jsp?email="+actmail+"'>重新发送激活邮件</a>链接。<a href='javascript:close();'>关闭</a>本页面后返回首页。</b>");
				
		} else if(check == "激活失败"){
		       $('#tipbox').html("<b>激活失败！请检查激活邮件中激活链接地址是否无误。<a href='javascript:close();'>关闭</a>本页面后返回首页。</b>");
				
		}
		else{
			location.href = "/Member/login.jsp";
		};
		
		

	</script>

    <script type="text/javascript">
	function close(){
		window.location.href = '/index.jsp';
		
	};
    </script>
	
	  <%@ include file="/Master/footer.jsp"%>

	
</body>
</html>