<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户信息</title>
<link type="text/css" rel="stylesheet" href="../Css/userinfo.css"/>
</head>

<body>
     <div class="navibar"><a href="#">首页</a> > 个人信息</div>
<div class="reg_content">
     <div class="reg_form">
                <form name="frmEmp" id="frmEmp">
                <h2>个人信息<span id="reg_username" style="display:none;"></span></h2>
                <div class="form_item">
                        <label>电子邮箱：</label>
                        <span id="reg_email" class="text-input  typeahead" type="text"></span>&nbsp;&nbsp;<span
                            id="reg_emailTip"></span>
                    </div>
                    <div class="form_item">
                        <label>姓名：</label> <input id="txtName" class="text-input  typeahead"
                                type="text" onblur="checkName();" />&nbsp;&nbsp;<span id="txtNameTip" class="TipItem"></span>
                    </div>
                    
                    <div class="form_item">
                        <label><span class="red star">*</span>手机：</label> <input id="txtMobile" class="text-input  typeahead"
                                type="text" onblur="checkMobile();" />&nbsp;&nbsp;<span id="txtMobileTip" class="TipItem"></span>
                    </div>
                <div class="form_item">
					<label> 学科专业：</label> <input id="txt_Spe"
						class="text-input  typeahead" type="text"
						onblur="checkSpe();" />&nbsp;&nbsp;<span id="txt_SpeTip"></span>
				</div>
                    <div class="form_item">
					<label> 职业：</label> 
					    <input id="occu1"  name="ocu"  type="radio"  value="1" checked="checked" />医务人员
						<input id="occu2"   name="ocu"   type="radio"  value="2" />教师
						<input id="occu3"   name="ocu"  type="radio"  value="3" />研发人员
						<input id="occu4"   name="ocu"  type="radio"  value="4" />学生
						<input id="occu5"   name="ocu"  type="radio"  value="5" />其它
				</div>

                    
				<div class="form_item">
					<label> 工作单位：</label> <input id="txt_unit"
						class="text-input  typeahead" type="text"  value="" onblur="checkUnit();" />&nbsp;&nbsp;<span
						id="txt_unitTip"></span>
				</div>
				<div class="form_item">
					<label> 职务职称：</label> <input id="txt_Level"
						class="text-input  typeahead" type="text" onblur="checkLevel();" />&nbsp;&nbsp;<span
						id="txt_LevelTip"></span>
				</div>

				<div class="form_item">
					<label> 最高学历：</label> 
					<input id="edu1" name="edu"  type="radio"  value="1" />专科
					<input id="edu2" name="edu"  type="radio"  value="2" checked="checked"/>本科
					<input id="edu3" name="edu"  type="radio"  value="3" />硕士
					<input id="edu4" name="edu"  type="radio"   value="4" />博士
					<input id="edu5" name="edu"  type="radio"   value="5"  />其它
				</div>
				<div class="form_item">
                        <label>验&nbsp;&nbsp;证&nbsp;&nbsp;码：</label>
                        <input id="reg_ValidateCode" class="text-input  typeahead validatecode" type="text" onblur="checkCode();" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <img src="../code.do?name=user_reg" alt="看不清?换一张" style="cursor: pointer; vertical-align: middle; font-size: 12px;"
                            onclick="this.src='../code.do?name=user_reg&id='+new Date();" />
                        &nbsp;&nbsp;<span id="reg_ValidateCodeTip"></span>
                    </div>
                    <div class="form_item">
                        <input value="保  存" type="button" id="save" class="submit" onclick="updatememberinfo();" />
                    </div>
                </form>
            </div>
</div>

  <%@ include file="/Master/footer.jsp"%>
	<script type="text/javascript">
      checklogin();
	  getMemberInfo();
	  var state1=false;
 	  var state2=false;
      var state3=false;
      var state4=false;
	  var state5=false;
	  var state6=false;
     
function checkName(){
	       var name = $("#txtName").val();
            if (name == "" || name == null) {
                $("#txtNameTip").removeClass("onCorrect").addClass("onError").html("输入不能小于2个字符！");
            }
            else if(name.length<2){
              $("#txtNameTip").removeClass("onCorrect").addClass("onError").html("输入不能小于2个字符！");    
            }
	         else {
              $("#txtNameTip").removeClass("onError").addClass("onCorrect").html("");
             state1 = true;
            }
	   
	   } 
	
	  	   function checkUnit(){
	  	   
	        var unit = $("#txt_unit").val();
            if (unit == "" || unit == null) {
                
                $("#txt_unitTip").removeClass("onCorrect").addClass("onError").html("输入不能小于6个字符！");
            }
            else if(unit.length<6){
              $("#txt_unitTip").removeClass("onCorrect").addClass("onError").html("输入不能小于6个字符！");    
            }
	         else {
              $("#txt_unitTip").removeClass("onError").addClass("onCorrect").html("");
              state2 = true;
            }
	   
	   }
	
	 function checkLevel(){
	        var level = $("#txt_Level").val();
            if (level == "" || level == null) {
                $("#txt_LevelTip").removeClass("onCorrect").addClass("onError").html("输入不能小于2个字符！");
            }
            else if(level.length<2){
              $("#txt_LevelTip").removeClass("onCorrect").addClass("onError").html("输入不能小于2个字符！");    
            }
            else{
              $("#txt_LevelTip").removeClass("onError").addClass("onCorrect").html("");
               state3 = true;
            }
	   
	   }
	
	   function checkSpe(){
	        var spe = $("#txt_Spe").val();
            if (spe == "" || spe == null) {
                $("#txt_SpeTip").removeClass("onCorrect").addClass("onError").html("输入不能为空！");
            }
            else if(spe.length<2){
              $("#txt_SpeTip").removeClass("onCorrect").addClass("onError").html("输入不能小于2个字符！");    
            }
	         else {
              $("#txt_SpeTip").removeClass("onError").addClass("onCorrect").html("");
               state4 = true;
            }
	   
	   }
	
        function checkMobile() {
        	var uid="<%=uid%>";
        	var mobile = $("#txtMobile").val();
            if (mobile == "" || mobile == null) {
                $("#txtMobileTip").addClass("onError").html("手机号不能为空！");
                $("#btnSendVerCode").attr("disabled", "disabled");
               
            } else {
                var reg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
                if (!reg.test(mobile)) {
                    $("#txtMobileTip").removeClass("onCorrect").html("");
                    $("#txtMobileTip").addClass("onError").html("手机号输入错误！");
                    $("#btnSendVerCode").attr("disabled", "disabled");
                   
                   }
                 else {
                    $.ajax({
                        url: "<%=path%>/CheckSelfMobile",
                        type: 'post',
                        async: false,
                        dataType: 'text',
                        data: { Mobile: mobile,Uid:uid },
                        success: function (data) {
                        	
                        	if (data == "1") {
                                $("#txtMobileTip").removeClass("onError").html("");
                                $("#txtMobileTip").addClass("onCorrect").html("当前已绑定的号码！");
                                state5 = true;
                            }
                        	else if (data == "2") {
                                $("#txtMobileTip").removeClass("onCorrect").html("");
                                $("#txtMobileTip").addClass("onError").html("该号码已使用，请更换！");
                               
                            } else {
                            	$("#txtMobileTip").removeClass("onError").html("");
                            	$("#txtMobileTip").addClass("onCorrect").html("该号码可以使用！");
                                state5 = true;               
                            }
                        },
                        error: function (err) {
                        
                             alert("检查手机号失败，请联系管理员");
                        }
                    });
               }
            }
        }
function checkCode() {
            var v_code = $("#reg_ValidateCode").val();
            if (v_code == "" || v_code == null) {
                $("#reg_ValidateCodeTip").removeClass("onCorrect").html("");
                $("#reg_ValidateCodeTip").addClass("onError").html("不可为空！");
                state6 = false;
                return;
            };
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
                state6 = true;
            } 
            else {
                $("#reg_ValidateCodeTip").removeClass("onCorrect").html("");
                $("#reg_ValidateCodeTip").addClass("onError").html("验证码输入有误！");
            }
        }
      //获取个人信息
        function getMemberInfo(){
        	var uid="<%=uid%>";
        	 if(uid!=""&&uid!="null"){
	            $.ajax({
	                url: "<%=path%>/GetMemberInfo",
	                type: 'post',
	                async: false,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'json',
	                data: {uid:uid},
	                success: function (result) {
	                //address,capacity,education,member,mobile,name,occupation,speciality	
	                	if (result != 0) {
	                		$("#reg_username").html(result[0].id);
	                		$("#txtName").val(result[0].name);
	                		$("#reg_email").html(result[0].email);
	                		$("#txtMobile").val(result[0].mobile);
	                		$("#txt_Spe").val(result[0].speciality);
	                       
	                		$("#txt_unit").val(result[0].address);
	                		switch(result[0].occupation)
	                		{
	                		case "1":
	                			$("#occu1").attr('checked','true');
	                		  break;
	                		case "2":
	                			$("#occu2").attr('checked','true');
	                		  break;
	                		case "3":
	                			$("#occu3").attr('checked','true');
	                		  break;
	                		case "4":
	                			$("#occu4").attr('checked','true');
	                		  break;
	                		case "5":
	                			$("#occu5").attr('checked','true');
	                		  break;
	                		default:
	                			$("#occu1").attr('checked','true');
	                		}
	                    
	                		$("#txt_Level").val(result[0].capacity);
	                		switch(result[0].education)
	                		{
	                		case "1":
	                			$("#edu1").attr('checked','true');
	                		  break;
	                		case "2":
	                			$("#edu2").attr('checked','true');
	                		  break;
	                		case "3":
	                			$("#edu3").attr('checked','true');
	                		  break;
	                		case "4":
	                			$("#edu4").attr('checked','true');
	                		  break;
	                		case "5":
	                			$("#edu5").attr('checked','true');
	                		  break;
	                		default:
	                			$("#edu2").attr('checked','true');
	                		}
				
	                	} 
	                },
	                error: function () {
	                    alert("读取个人信息异常！");
	                    return false;
	                }
	            });	 
        	 }
        	 else{
        		 
        		 window.location.href="/Member/login.jsp";
        	 }
           
	
	}
	
	           function updatememberinfo() {
	        	   
	        	   //checkEmail();
	        	   checkName();
	        	   checkMobile();
	        	   checkSpe();
	        	   checkLevel();
	        	   checkUnit();
	        	   checkCode();
	        	   
	               if(state1&&state2&&state3&&state4&&state5&&state6){
                     $.ajax({
                        url: "<%=path%>/UpdateMemberInfo",
							type : 'post',
							async : false,
							timeout : 60000,
							dataType : 'text',
							data : {
								occupation : $("input[name=ocu]:checked").val(),
								name : $("#txtName").val(),
								mobile : $("#txtMobile").val(),
								address : $("#txt_unit").val(),
								capacity : $("#txt_Level").val(),
								speciality : $("#txt_Spe").val(),
								education : $("input[name=edu]:checked").val()
							},
							beforeSend: function () {
						        // 禁用按钮防止重复提交
						        $("#save").attr({ disabled: "disabled" });
						    },
							success : function(data) {
								if (data == "1") {
									var $copysuc = $("<p>恭喜您！更新个人信息成功。</p>");
						           	  //modal居中  
						          	   $("#headmodal .modal-body").html($copysuc);
						          	   $("#headmodal").modal("show");
						          	 $('#headmodal').on("hidden.bs.modal", function () {
						         		//关闭模态框后清除模态框数据
						          		location.href = "<%=path%>/index.jsp";
						         		});
									
								} 
								else if (data == "2") {
									var $copysuc = $("<p>恭喜您！提交个人信息成功，获得赠送10下载点。</p>"); 
						            	 $("#headmodal").draggable({
						                     cursor: "move",
						                     handle: '.modal-header',
						                 });    	                            
						           	  //modal居中  
						          	   $("#headmodal .modal-body").html($copysuc);
						          	   $("#headmodal").modal("show");
						          	 $('#headmodal').on("hidden.bs.modal", function () {
						         		//关闭模态框后清除模态框数据
						          		location.href = "<%=path%>/index.jsp";
						         		});
						            			
								}
								else {
									$copysuc = $("<p>提交失败！请发送问题至客服邮箱：****@163.com</p>");
						           	  //modal居中  
						          	   $("#headmodal .modal-body").html($copysuc);
						          	   $("#headmodal").modal("show");
						          	 $('#headmodal').on("hidden.bs.modal", function () {
						         		//关闭模态框后清除模态框数据
						          		location.href = "<%=path%>/index.jsp";
						         		});
						          	 $("#validimg").attr("src","/code.do?name=user_reg&id="+new Date());
								}
							},
							complete: function () {
						        $("#save").removeAttr("disabled");
						    },
						    error : function(XMLHttpRequest, textStatus) {
								alert(XMLHttpRequest.status);  
		                    	alert(XMLHttpRequest.readyState);  
		                    	alert(textStatus);
							}
						});

			} else {
				return;
			}
		}
		function timedCount() {
		    var c = $('#second').html(); 
		    c--;
		    
		    if(c > 0){	
		        $('#second').html(c);			
				setTimeout("timedCount()", 1000);
				
			}
		    else{
				 location.href = "<%=path%>/index.jsp";
				}
			}
	</script>
<body>

</body>
</html>