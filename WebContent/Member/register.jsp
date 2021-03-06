<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册信息-用户注册</title>
<link type="text/css" rel="stylesheet" href="../Css/reg.css"/>
</head>
<body>
<%@ include  file="/Master/header.jsp"%>
<%
//System.out.println("register:");
//System.out.println(path);
//System.out.println(basePath);
%>
<div class="navibar"><a href="#">首页</a> > 注册</div>
<div class="reg_content">
     <div class="reg_form">
                <form name="frmEmp" id="frmEmp">
                <h2>注册信息</h2>
                <br>
                    <div class="form_item">
                        <label>
                            电子邮箱：</label>
                        <input id="reg_email" class="text-input  typeahead" type="text" onblur="checkEmail()" />&nbsp;&nbsp;<span
                            id="reg_emailTip"></span>
                    </div>
                    <div class="form_item">
                        <label>
                            用&nbsp;&nbsp;户&nbsp;&nbsp;名：</label>
                        <input id="reg_username" class="text-input  typeahead" type="text" onblur="checkName()" placeholder="6-30位字母或数字"/>&nbsp;&nbsp;<span
                            id="reg_usernameTip"></span>
                    </div>
                    <div class="form_item">
                        <label>
                            密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                        <input id="reg_pwd" class="text-input  typeahead" type="password" onblur="checkPwd()" placeholder="6-30位字母或数字"/>&nbsp;&nbsp;<span
                            id="reg_pwdTip"></span>
                    </div>
                    <div class="form_item">
                        <label>
                            确认密码：</label>
                        <input id="reg_pwd2" class="text-input  typeahead" type="password" onblur="checkRePwd()" placeholder="6-30位字母或数字"/>&nbsp;&nbsp;<span
                            id="reg_pwd2Tip"></span>
                    </div>

                    <div class="form_item">
                        <label>
                            验&nbsp;&nbsp;证&nbsp;&nbsp;码：</label>
                        <input id="reg_ValidateCode" class="text-input  typeahead validatecode" type="text" onblur="checkCode();" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <img src="../code.do?name=user_reg" alt="看不清?换一张" style="cursor: pointer; vertical-align: middle; font-size: 12px;"
                            onclick="this.src='../code.do?name=user_reg&id='+encodeURI(new Date());" />
                        &nbsp;&nbsp;<span id="reg_ValidateCodeTip"></span>
                    </div>
                    <div class="form_item">
                        <input value="注    册" id="save" type="button" class="submit" onclick="Sign();" />
                    </div>
                </form>
            </div>
</div>
  <%@ include file="/Master/footer.jsp"%>
<script type="text/javascript">
          getsession()
        checklogined();
        var check1 = false;
        var check2 = false;
        var check3 = false;
        var check4 = false;
        var check5 = false;
        $("#reg_ValidateCode").val('');

        function Sign() {
            var Loginid = $("#reg_username").val();
            var Email = $("#reg_email").val();
            var Password = $("#reg_pwd").val();
            
            checkEmail();
            checkName();
            checkPwd();
            checkRePwd();
            checkCode();
            if (check1 && check2 && check3 && check4 && check5) {
                $.ajax({
                    url: "<%=path%>/Member/Register",
                    type: 'post',
                    async: true,
                    timeout:60000,
                    dataType: 'text',
                    data: { Loginid: Loginid, Email: Email, Password: Password,ip:ip,city:city },
                    beforeSend: function () {
				        // 禁用按钮防止重复提交
				        $("#save").attr({ disabled: "disabled" });
				    },
                    success: function (data) {
                    	if(data=="1"){
                    		location.href = "<%=path%>/Member/actmail.jsp?email="+Email;
                    	}
                    	else if(data=="1.1"){
                    		 $("#validimg").attr("src","/code.do?name=user_reg&id="+encodeURI(new Date()));
                    		alert("邮件发送失败，请重新操作!");                   		
                    	}
                    	else if(data=="2"){
                    		 $("#validimg").attr("src","/code.do?name=user_reg&id="+encodeURI(new Date()));
                    		alert("Email已被使用!");	
                    	}
                    	else if(data=="3"){                    		
                    		 $("#validimg").attr("src","/code.do?name=user_reg&id="+encodeURI(new Date()));
                    		 alert("用户名已被使用!");
                    	}
                    	else{
                    		 $("#validimg").attr("src","/code.do?name=user_reg&id="+encodeURI(new Date()));
                    		alert("添加失败！请发送邮件联系管理员:imed120@163.com");
                    	}
                        
                    },
                    complete: function () {
				        $("#save").removeAttr("disabled");
				    },
                    error:function(XMLHttpRequest, textStatus){  
                    	
                    	alert(XMLHttpRequest.status);  
                    	alert(XMLHttpRequest.readyState);  
                    	alert(textStatus);
                    	 alert("添加失败！请发送邮件联系管理员:imed120@163.com");
                    	 return;
                    	}                    
                });
            } else {
                alert('注册信息填写错误！');
            }


        }

        //检查电子邮件
        function checkEmail() {
            var email = $("#reg_email").val();
            if (email == "" || email == null) {
                $("#reg_emailTip").removeClass("onCorrect");
                $("#reg_emailTip").addClass("onError").html("不可为空！");
                check1 = false;
            } else {
            	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //正则表达式
                if (!reg.test(email)) {
                //if (1==2) {
                    $("#reg_emailTip").removeClass("onCorrect");
                    $("#reg_emailTip").addClass("onError").html("电子邮箱输入有误！");
                    check1 = false;
                } else {
                    if (email.length > 5 && email.length < 31) {
                        $.ajax({
                            url: "<%=path%>/check.do",
                            type: 'post',
                            async: false,
                            dataType: 'text',
                            data: { value: email,type:'email' },
                            success: function (data) {
                                if (data == "false") {
                                    $("#reg_emailTip").removeClass("onCorrect");
                                    $("#reg_emailTip").addClass("onError").html("已使用！");
                                    check1 = false;
                                } else {
                                    $("#reg_emailTip").addClass("onCorrect").html("正确！");
                                    check1 = true;
                                }
                            },
                            error: function (err) {
                                alert("检查邮箱失败，请联系管理员");
                                check1 = false;
                            }
                        });
                    } else {
                        $("#reg_emailTip").removeClass("onCorrect");
                        $("#reg_emailTip").addClass("onError").html("长度限制为6-30位！");
                        check1 = false;
                    }
                }

            }
        }

        function checkName() {
            var userName = $("#reg_username").val();
            if (userName == "" || userName == null) {
                $("#reg_usernameTip").removeClass("onCorrect");
                $("#reg_usernameTip").addClass("onError").html("不可为空！");
                check2 = false;
            } else {
                if (userName.length > 5 && userName.length < 31) {
                    var reg = /([^0-9](.)*)/;
                    if (!reg.test(userName)) {
                        $("#reg_usernameTip").removeClass("onCorrect").addClass("onError").html("须使用字母+数字！");
                        check2 = false;
                    } else {
                        $.ajax({
                            url: "<%=path%>/check.do",
                            type: 'post',
                            async: false,
                            dataType: 'text',
                            data: { value: userName,type:'name' },
                            success: function (data) {
                                if (data == "false") {
                                    $("#reg_usernameTip").removeClass("onCorrect");
                                    $("#reg_usernameTip").addClass("onError").html("该用户名已使用！");
                                    check2 = false;
                                } else {
                                    $("#reg_usernameTip").addClass("onCorrect").html("正确！");
                                    check2 = true;
                                }
                            },
                            error: function () {
                                alert("检查用户名失败，请联系管理员");
                                check2 = false;;
                            }
                        });
                    }
                } else {
                    $("#reg_usernameTip").removeClass("onCorrect").addClass("onError").html("输入长度限制为6-30！");
                    check2 = false;
                }

            }
        }

        function checkPwd() {
            var pwd = $("#reg_pwd").val();
            if (pwd == "" || pwd == null) {
                $("#reg_pwdTip").removeClass("onCorrect");
                $("#reg_pwdTip").addClass("onError").html("不可为空！");
                check3 = false;
            } else if (pwd.length>30||pwd.length < 6  ) {
                $("#reg_pwdTip").removeClass("onCorrect");
                $("#reg_pwdTip").addClass("onError").html("密码长度为6-30位！");
                check3 = false;
            } else {
                $("#reg_pwdTip").addClass("onCorrect").html("正确！");
                check3 = true;
            }
        }

        function checkRePwd() {
            var pwd = $("#reg_pwd").val().trim();
            var pwd2 = $("#reg_pwd2").val().trim();
            if (pwd2 == "" || pwd2 == null) {
                $("#reg_pwd2Tip").removeClass("onCorrect");
                $("#reg_pwd2Tip").addClass("onError").html("不可为空！");
                check4 = false;
            } else if (pwd2.length>30||pwd2.length < 6) {
                $("#reg_pwd2Tip").removeClass("onCorrect");
                $("#reg_pwd2Tip").addClass("onError").html("密码长度为6-30位！");
                check4 = false;
            } else {
                if (pwd == pwd2) {
                    $("#reg_pwd2Tip").addClass("onCorrect").html("正确！");
                    check4 = true;
                } else {
                    $("#reg_pwd2Tip").removeClass("onCorrect");
                    $("#reg_pwd2Tip").addClass("onError").html("两次输入不一致！");
                    check4 = false;
                }
            }
        }

        function checkCode() {
            var v_code = $("#reg_ValidateCode").val();
            if (v_code == "" || v_code == null) {
                $("#reg_ValidateCodeTip").removeClass("onCorrect").html("");
                $("#reg_ValidateCodeTip").addClass("onError").html("不可为空！");
                check5 = false;
                return;
            }
           // var ver_code = getCookie("VCode").toLowerCase();
           var ver_code ;
            $.ajax({
                            url: "../code.do",
                            type: 'post',
                            async: false,
                            dataType: 'text',
                            data: { name: 'user_reg' },
                            success: function (data) {
                            	ver_code  = data; 
                            },
                            error: function () {
                                alert("获取验证码失败，请联系管理员");
                            }
                        });

            if (ver_code == v_code.toLowerCase()) {
                $("#reg_ValidateCodeTip").addClass("onCorrect").html("正确！");
                check5 = true;
            } else {
                $("#reg_ValidateCodeTip").removeClass("onCorrect").html("");
                $("#reg_ValidateCodeTip").addClass("onError").html("验证码输入有误！");
                check5 = false;
            }
        }


        function getCookie(name) {
            var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
            if (arr != null) return unescape(arr[2]); return null;
        }

    	
        
        $("body").keydown(function (event) {
            if (event.which == 13) {
                Sign();
            }
        });

    </script>
</body>
</html>