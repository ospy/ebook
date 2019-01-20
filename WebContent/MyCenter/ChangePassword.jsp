<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>

<link type="text/css" rel="stylesheet" href="../Css/jquery-ui.css"/>
<link type="text/css" rel="stylesheet" href="../Css/ChangePassword.css"/>

<script type="text/javascript" src="/Js/jquery-ui.min.js"></script>
<script  type="text/javascript" src="<%=path %>/Js/bootstrap.js" ></script>
</head>
<body>
       <div class="navibar"><a href="#">首页</a> > 修改密码</div>
<div class="reg_content">
     <div class="reg_form">
                <form name="frmEmp" id="frmEmp">
                <h2>修改密码</h2>
         <div class="form_item">
                        <span class="red star">*</span><label>
                            请输入旧密码：</label>
                        <input id="old_pwd" class="text-input  typeahead" type="password" onblur="checkOldPwd()" />&nbsp;&nbsp;<span
                            id="old_pwdTip"></span>
                    </div>
                    <div class="form_item">
                        <span class="red star">*</span><label>
                            请输入新密码：</label>
                        <input id="reg_pwd" class="text-input  typeahead" type="password" onblur="checkPwd()" />&nbsp;&nbsp;<span
                            id="reg_pwdTip"></span>
                    </div>
                    <div class="form_item">
                        <span class="red star">*</span><label>确认新密码：</label> 
                            <input id="reg_pwd2" class="text-input  typeahead" type="password" onblur="checkRePwd()" />&nbsp;&nbsp;<span
                            id="reg_pwd2Tip"></span>
                    </div>
                    <div class="form_item">
						<span class="red star">*</span><label>验证码：</label> <input id="txt_ValidateCode"
								class="text-input validatecode" onblur="checkCode();"
								type="text">&nbsp;&nbsp;&nbsp;&nbsp;<img id="validimg" src="../code.do?name=user_reg" alt="看不清?换一张" style="cursor: pointer; vertical-align: top; font-size: 12px;"
                            onclick="this.src='../code.do?name=user_reg&id='+new Date();" /> <p id="tip-validatecode" class="tip red"></p>
					</div>
                    <div class="form_item">
                        <input value="确定" type="button" class="submit" onclick="updatepsw();" />
                    </div>
                
                </form>
            </div>
</div>
<script type="text/javascript">
checklogin();
var check0 = false;
var check1 = false;
var check2 = false;
var check3 = false;

function checkOldPwd(text) {
    var oldpwd = $("#old_pwd").val();
    if (oldpwd == "" || oldpwd == null) {
        $("#old_pwdTip").removeClass("onCorrect");
        $("#old_pwdTip").addClass("onError").html("不可为空！");
        check0 = false;
    } else if ( oldpwd.length > 30||oldpwd.length < 6 ) {
        $("#old_pwdTip").removeClass("onCorrect");
        $("#old_pwdTip").addClass("onError").html("密码长度为6-30位！");
        check0 = false;
    } else {
        $("#old_pwdTip").addClass("onCorrect").html("正确！");
        check0 = true;
    }
}
function checkPwd() {
    var pwd = $("#reg_pwd").val();
    if (pwd == "" || pwd == null) {
        $("#reg_pwdTip").removeClass("onCorrect");
        $("#reg_pwdTip").addClass("onError").html("不可为空！");
        check1 = false;
    } else if (pwd.length > 30||pwd.length < 6) {
        $("#reg_pwdTip").removeClass("onCorrect");
        $("#reg_pwdTip").addClass("onError").html("密码长度为6-30位！");
        check1 = false;
    } else {
        $("#reg_pwdTip").addClass("onCorrect").html("正确！");
        check1 = true;
    }
}

function checkRePwd() {
    var pwd = $("#reg_pwd").val().trim();
    var pwd2 = $("#reg_pwd2").val().trim();
    if (pwd2 == "" || pwd2 == null) {
        $("#reg_pwd2Tip").removeClass("onCorrect");
        $("#reg_pwd2Tip").addClass("onError").html("不可为空！");
        check2 = false;
    } else if (pwd2.length > 30||pwd2.length < 6) {
        $("#reg_pwd2Tip").removeClass("onCorrect");
        $("#reg_pwd2Tip").addClass("onError").html("密码长度为6-30位！");
        check2 = false;
    } else {
        if (pwd == pwd2) {
            $("#reg_pwd2Tip").addClass("onCorrect").html("正确！");
            check2 = true;
        } else {
            $("#reg_pwd2Tip").removeClass("onCorrect");
            $("#reg_pwd2Tip").addClass("onError").html("两次输入不一致！");
            check2 = false;
        }
    }
}
function checkCode() {
	
	var v_code = $("#txt_ValidateCode").val();
	if (v_code == "" || v_code == null) {
		$("#tip-validatecode").removeClass("onCorrect").addClass("onError")
				.html("不可为空！");
		check3 = false;
		
	}
	// var ver_code = getCookie("VCode").toLowerCase();
	var ver_code;
	$.ajax({
		url : "../code.do",
		type : 'post',
		async : false,
		dataType : 'text',
		data : {
			name : 'user_reg'
		},
		success : function(data) {
			ver_code = data;
		},
		error : function() {
			alert("获取验证码失败，请联系管理员");
		}
	});

	if (ver_code == v_code.toLowerCase()) {
		$("#tip-validatecode").addClass("onCorrect").html("");
		check3 = true;
	} else {
		$("#tip-validatecode").removeClass("onCorrect").addClass("onError")
				.html("验证码输入有误！");
		check3 = false;
	}
}
function updatepsw(){
	var uid="<%=uid%>";
	checkOldPwd();
	checkPwd();
	checkRePwd();
	checkCode();
	
	var oldpwd = $("#old_pwd").val().trim();
	var pwd = $("#reg_pwd").val().trim();
    var pwd2 = $("#reg_pwd2").val().trim();
    if (check0==true&&check1==true&&check2==true&&check3==true) {
    	$.ajax({
    		url : "<%=path%>/UpdatePwd",
    		type : 'post',
    		async : true,
    		timeout: 30000,
    		dataType : 'text',
    		data : {UID:uid,oldpwd:oldpwd,PWD:pwd},
    		success : function(data) {
                if(data=="1"){
					var $copysuc = $("<p>恭喜您！修改密码成功。</p>");
		           	  //modal居中  
		          	   $("#headmodal .modal-body").html($copysuc);
		          	   $("#headmodal").modal("show");
		          	 $('#headmodal').on("hidden.bs.modal", function () {
		         		//关闭模态框后清除模态框数据
		          		location.href = "<%=path%>/index.jsp";
		         		});
					
				} 
                else if(data=="-1"){
                	$("#old_pwdTip").removeClass("onCorrect");
                    $("#old_pwdTip").addClass("onError").html("旧密码输入错误！");
                    $("#validimg").attr("src","/code.do?name=user_reg&id="+new Date());
				}
                else {
					var $copysuc = $("<p>修改失败！请发送问题至客服邮箱：imed120@163.com</p>");
		           	  //modal居中  
		          	   $("#headmodal .modal-body").html($copysuc);
		          	   $("#headmodal").modal("show");
		          	 $('#headmodal').on("hidden.bs.modal", function () {
		         		//关闭模态框后清除模态框数据
		          		location.href = "<%=path%>/index.jsp";
		         		});
				}
    		},
    		error : function() {
    			alert("更新密码失败!请发送问题至客服邮箱：imed120@163.com");
    		}
    	});
    } 
}
	 
</script>
</body>
</html>