<%@page import="com.ebook.entity.*"%>
<%@page import="com.ebook.constant.*"%>
<%@page import="com.ebook.constant.Constant"%>
<%@page import="com.ebook.entity.Activate"%>
<%@page import="com.ebook.entity.Member"%>
<%@page import="com.ebook.member.dao.MemberDao"%>
<%@page import="com.ebook.utils.DateUtils"%>
<%@page import="com.ebook.utils.LOG"%>
<%@page import="com.ebook.utils.Md5Util"%>
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
		check ="<%=checkResult%>";
		actmail="<%=actmail%>";
		i_uid="<%=i_uid%>";
		loginid="<%=loginid%>";
		

		
		if (check == "已激活"||check=="激活成功") {
                $('#modal-body').html("<b>邮箱已激活！请完善个人信息。<\/b>");
				$('#myModal').modal('show');
		} 
		else{
			location.href = "/Member/login.jsp";
		}
		;

	</script>

    
	<div class="reg_content">
		<div class="reg_form">
			<form name="frmEmp" id="frmEmp">
				<h2>个人信息</h2>
				
                <div class="form_item">
                        <label>用户名：</label> <span id="loginid"></span>&nbsp;&nbsp;&nbsp;&nbsp;<label>注册邮箱：</label> <span id="email"></span>
                    </div>
                     <div class="form_item">
                        <label><span class="red star">*</span>手机：</label> <input id="txtMobile" class="text-input  typeahead"
                                type="text" onblur="checkMobile();" />&nbsp;&nbsp;<span id="txtMobileTip" class="TipItem"></span>
                    </div>
				<div class="form_item">
                        <label><span class="red star">*</span>姓名：</label> <input id="txtName" class="text-input  typeahead"
                                type="text"  onblur="checkName();" />&nbsp;&nbsp;<span id="txtNameTip" class="TipItem"></span>
                    </div>
                   
				<div class="form_item">
					<label> <span class="red star">*</span>工作单位：</label> <input id="txt_unit"
						class="text-input  typeahead" type="text"  value="" onblur="checkUnit();" />&nbsp;&nbsp;<span
						id="txt_unitTip"></span>
				</div>
				<div class="form_item">
					<label><span class="red star">*</span>职务职称：</label> <input id="txt_Level"
						class="text-input  typeahead" type="text" onblur="checkLevel();" />&nbsp;&nbsp;<span
						id="txt_LevelTip"></span>
				</div>
				<div class="form_item">
					<label><span class="red star">*</span>学科专业：</label> <input id="txt_Spe"
						class="text-input  typeahead" type="text"
						onblur="checkSpe();" />&nbsp;&nbsp;<span id="txt_SpeTip"></span>
				</div>
				<div class="form_item">
					<label><span class="red star">*</span>职业：</label> 
					    <input id="occu1"  name="ocu"  type="radio"  value="1"  checked="checked"/>医务人员
						<input id="occu2"   name="ocu"   type="radio"  value="2" />教师
						<input id="occu3"   name="ocu"  type="radio"  value="3" />研发人员
						<input id="occu4"   name="ocu"  type="radio"  value="4" />学生
						<input id="occu5"   name="ocu"  type="radio"  value="5" />其它
				</div>
				<div class="form_item">
					<label><span class="star red">*</span>最高学历：</label> 
					<input id="edu1" name="edu" type="radio"  value="1" />专科
					<input id="edu2" name="edu"  type="radio"  value="2" checked="checked"/>本科
					<input id="edu3" name="edu"  type="radio"  value="3" />硕士
					<input id="edu4" name="edu"  type="radio"   value="4" />博士
					<input id="edu5" name="edu"  type="radio"   value="5"  />其它
				</div>
				
				<div class="form_item">
					<input value="提    交" type="button" class="submit"
						onclick="check();"/>
				</div>
				<div class="form_item declare">
					<label> 本站声明：</label> 
					<p>1.请如实填写个人信息，本站所保存之用户个人信息仅供用户统计和联系使用，不会用于任何商业目的；</p>
					<p>2.填写手机号码后可使用手机号码登录本站；</p>
					<p>3.完整填写个人信息将获赠10下载点；</p>
				</div>
			</form>
		</div>
	</div>
	  <%@ include file="/Master/footer.jsp"%>
	<script type="text/javascript">
		$('#loginid').html(loginid);
		$('#email').html(actmail);
	
	  var state1=false;
 	  var state2=false;
      var state3=false;
      var state4=false;
	  var state5=false;
	
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
                        url: "<%=path%>/CheckMobile",
                        type: 'post',
                        async: false,
                        dataType: 'text',
                        data: { Mobile: mobile },
                        success: function (data) {
                            if (data == "false") {
                                $("#txtMobileTip").removeClass("onCorrect").html("");
                                $("#txtMobileTip").addClass("onError").html("该号码已使用，请更换！");
                            } else {
                                $("#txtMobileTip").addClass("onCorrect").html("");
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
	
	
	
	           function check() {
	        	   checkMobile();
	        	   checkName();
	        	   checkUnit();
	        	   checkLevel();
	        	   checkSpe();
	        	   
	               if( state1&&state2&&state3&&state4&&state5){
                     $.ajax({
                        url: "<%=path%>/SaveMemberInfo",
							type : 'post',
							async : false,
							dataType : 'text',
							data : {
								ocu : $("input[name=ocu]:checked").val(),
								name : $("#txtName").val(),
								mobile : $("#txtMobile").val(),
								unit : $("#txt_unit").val(),
								level : $("#txt_Level").val(),
								spe : $("#txt_Spe").val(),
								edu : $("input[name=edu]:checked").val()
							},
							success : function(data) {
								if (data == "true") {
									var $copysuc = $("<div class='alert-tips'><div class='alert-tips-wrap'>恭喜您！注册成功，请登录。<span id='second'>10</span>秒钟后将自动跳转到登录页！</div></div>");
									$("body").find(".alert-tips").remove()
											.end().append($copysuc);
									timedCount();
									$(".alert-tips").fadeOut(10000);
									
								}
								else if (data == "会话过期") {						
									alert("session已过期！请重新点击激活邮件中的链接");
								}
								else {
									alert("提交失败！请发送问题至客服邮箱：imed120@163.com");
								}
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
			 location.href = "<%=path%>/Member/login.jsp";
			}
			}
	</script>
	
</body>
</html>