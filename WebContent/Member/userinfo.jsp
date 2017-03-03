<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="com.ebook.utils.StringUtil"%>
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人信息-用户注册</title>
<link href="../Css/bootstrap.css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="../Css/reg.css" />
<script  type="text/javascript" src="../Js/bootstrap.js" ></script>

</head>
<body>
    <!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close back-index" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">激活提示</h4>
      </div>
      <div class="modal-body" id="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default back-index" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>





	<%
		String checkResult = (String) request.getSession().getAttribute(
				"checkResult");
		if (StringUtil.isBlank(checkResult)) {
			checkResult = " ";
		}
	%>
	
	<script type="text/javascript">

		var check;
		check ="<%=checkResult%>";
		if (check == "已激活") {
                $('#modal-body').html("<b>该账户已激活！请<a href=\"/Member/login.jsp\">登录<\/a>网站。<\/b>");
				$('#myModal').modal('show');
		} else if(check == "链接已失效"){
		       $('#modal-body').html("<b>该链接已失效！请重新发送激活邮件链接。关闭本页面后返回首页。</b>");
				$('#myModal').modal('show');
		} else if(check == "激活失败"){
		         $('#modal-body').html("<b>激活失败！请检查激活邮件中激活链接地址是否无误。关闭本页面后返回首页。</b>");
				$('#myModal').modal('show');
		}
		;
        $('.back-index').click(function(){
             location.href = "/index.jsp";
});
	</script>


	<div class="reg_content">
		<div class="reg_form">
			<form name="frmEmp" id="frmEmp">
				<h2>个人信息</h2>
				<br>
				<div class="form_item">
					<label> 职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业：</label> <input
						id="occu1" type="radio" name="role" value="医务人员" checked="checked" />医务人员<input
						id="occu2" type="radio" name="role" value="教师" />教师<input
						id="occu3" type="radio" name="role" value="研发人员" />研发人员<input
						id="occu4" type="radio" name="role" value="学生" />学生<input
						id="occu5" type="radio" name="role" value="其它" checked="checked" />其它
				</div>
				<div class="form_item">
					<label> 工作单位：</label> <input id="reg_username"
						class="text-input  typeahead" type="text" onblur="checkName()" />&nbsp;&nbsp;<span
						id="reg_usernameTip"></span>
				</div>
				<div class="form_item">
					<label> 职务职称：</label> <input id="reg_pwd"
						class="text-input  typeahead" type="text" onblur="checkPwd()" />&nbsp;&nbsp;<span
						id="reg_pwdTip"></span>
				</div>
				<div class="form_item">
					<label> 学科专业：</label> <input id="reg_pwd2"
						class="text-input  typeahead" type="text"
						onblur="checkRePwd()" />&nbsp;&nbsp;<span id="reg_pwd2Tip"></span>
				</div>
				<div class="form_item">
					<label> 最高学历：</label> <input id="edu1" type="radio" name="role"
						value="专科" checked="checked" />专科<input id="edu2" type="radio"
						name="role" value="本科" />本科<input id="edu3" type="radio"
						name="role" value="硕士" />硕士<input id="edu4" type="radio"
						name="role" value="博士" />博士<input id="edu5" type="radio"
						name="role" value="其它" checked="checked" />其它
				</div>
				<div class="form_item">
					<input value="提    交" type="button" class="submit"
						onclick="Sign();" />
				</div>
			</form>
		</div>
	</div>
	
	
</body>
</html>