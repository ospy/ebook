<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%@ include  file="/Master/header.jsp"%>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人信息-用户注册</title>
<link type="text/css" rel="stylesheet" href="../Css/reg.css"/>
</head>
<body>
        <div class="reg_content">
     <div class="reg_form">
                <form name="frmEmp" id="frmEmp">
                <h2>个人信息</h2>
                <br>
                    <div class="form_item">
                    <label>
                    职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业：</label>
                <input id="occu1" type="radio" name="role" value="医务人员" checked="checked" />医务人员<input id="occu2" type="radio" name="role" value="教师" />教师<input id="occu3" type="radio"  name="role" value="研发人员" />研发人员<input id="occu4" type="radio" name="role" value="学生" />学生<input id="occu5" type="radio" name="role" value="其它" checked="checked" />其它
                    </div>
                    <div class="form_item">
                        <label>
                            工作单位：</label>
                        <input id="reg_username" class="text-input  typeahead" type="text" onblur="checkName()" />&nbsp;&nbsp;<span
                            id="reg_usernameTip"></span>
                    </div>
                    <div class="form_item">
                        <label>
                            职务职称：</label>
                        <input id="reg_pwd" class="text-input  typeahead" type="password" onblur="checkPwd()" />&nbsp;&nbsp;<span
                            id="reg_pwdTip"></span>
                    </div>
                    <div class="form_item">
                        <label>
                            学科专业：</label>
                        <input id="reg_pwd2" class="text-input  typeahead" type="password" onblur="checkRePwd()" />&nbsp;&nbsp;<span
                            id="reg_pwd2Tip"></span>
                    </div>
                    <div class="form_item">
                    <label>
                    最高学历：</label>
                <input id="edu1" type="radio" name="role" value="专科" checked="checked" />专科<input id="edu2" type="radio" name="role" value="本科" />本科<input id="edu3" type="radio" name="role" value="硕士" />硕士<input id="edu4" type="radio" name="role" value="博士" />博士<input id="edu5" type="radio" name="role" value="其它" checked="checked" />其它
                    </div>
                    <div class="form_item">
                        <input value="提    交" type="button" class="submit" onclick="Sign();" />
                    </div>
                </form>
            </div>
</div>
</body>
</html>