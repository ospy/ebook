<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%@ include  file="/Master/header.jsp"%>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页</title>
<link type="text/css" rel="stylesheet" href="../Css/Login.css"/>
</head>
<body>

<div class="main">
  <div class="login_content">
   <div class="left"><img src="../Images/login_img.png"/>
   <h2>网站简介</h2>
   <ul>
		   <li>医学、药学、生物最新图书推送</li>
		   <li>关键词+主题词聚类技术，全面准确跟踪</li>
		   <li>大数据整合，提供一站式生物医药图书信息帮助</li>
   </ul>
   </div>
   <div class="right">
     <div class=login_box>
       <h2>用户登录</h2>
<form class="login-form">
					<p class="fieldset">
					    <span class=title>用户名：</span>
						<label class="image-replace cd-username" for="signin-username">用户名</label>
						<input class="full-width has-padding has-border" id="signin-username" placeholder="输入用户名、手机号、邮箱"  type="text">
						<span id="tip-username" >不可为空！</span>
					</p>

					<p class="fieldset">
					<span class=title>密&nbsp;&nbsp;码：</span>
						<label class="image-replace cd-password" for="signin-password">密码</label>
						<input class="full-width has-padding has-border" id="signin-password" placeholder="输入密码" type="password">
						<span id="tip-password"></span>
					</p>
                   <p class="fieldset">
                   <span class=title>验证码：</span>
                        <input id="txt_ValidateCode" class="text-input validatecode" onblur="checkCode();" type="text">
						<img src="/Code/ValidateCode.aspx?a=1" alt="看不清?换一张" style="cursor: pointer; vertical-align: middle; font-size: 12px;" onclick="change(this);">
						<span id="tip-validatecode"></span>
					</p>
					<p class="fieldset remember">
						<input id="remember-me"  checked="checked" type="checkbox">
						<label class="remember-txt">&nbsp;&nbsp;记住登录状态</label>
					</p>

					<p class="fieldset">
						<input class="full-width2" value="登 录" type="submit">
					</p>
				</form>

     </div>
   </div>
  </div>
</div>

</body>
</html>