<%@page import="com.ebook.utils.SendEmailUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ebook.constant.*" %>
<%@ page import="com.ebook.entity.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include  file="/Master/header.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>激活邮件-用户注册</title>
<link type="text/css" rel="stylesheet" href="../Css/reg.css"/>
</head>
<%
String mail = request.getParameter("email");
String domain = mail.substring(mail.indexOf("@")+1);
domain = "http://mail."+domain;

%>
<body>
     <div class="reg_content">
     <div class="reg_form">
                <form name="frmEmp" id="frmEmp">
                <h2>激活邮件</h2>
                <br>
                <div class="actmail">
                    <h3>激活邮件已发送到您的邮箱<%=mail %>,请您<a href="<%=domain %>">登录邮箱</a>后点击邮件中激活链接以激活邮箱！</h3>
                </div>
                
                <div class="act_tips">
                        <h3>Tips:</h3>
                        <ul>
		                        <li>1. 检查Email地址是否填写错误？<a href="register.jsp">重新填写邮箱地址申请</a></li>							
								<li>2. 看看激活邮件是否在邮箱的<b>"垃圾箱"</b>里。</li>
								<li>3. 发送邮件到：imed120@163.com ,帮助我们查找原因。</li>
					  </ul>
                    </div>
            </div>
</div>
</body>
</html>