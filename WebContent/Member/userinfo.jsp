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
				
				<div class="form_item">
					<label> 职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业：</label> 
					    <input id="occu1"  name="ocu"  type="radio"  value="医务人员"  checked="checked"/>医务人员
						<input id="occu2"   name="ocu"   type="radio"  value="教师" />教师
						<input id="occu3"   name="ocu"  type="radio"  value="研发人员" />研发人员
						<input id="occu4"   name="ocu"  type="radio"  value="学生" />学生
						<input id="occu5"   name="ocu"  type="radio"  value="其它" />其它
				</div>
				<div class="form_item">
                        <label>真实姓名：</label> <input id="txtName" class="text-input  typeahead"
                                type="text"  onblur="checkName();" />&nbsp;&nbsp;<span id="txtNameTip" class="TipItem"></span>
                    </div>
                    <div class="form_item">
                        <label>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</label> <input id="txtMobile" class="text-input  typeahead"
                                type="text" onblur="checkMobile();" />&nbsp;&nbsp;<span id="txtMobileTip" class="TipItem"></span>
                    </div>
				<div class="form_item">
					<label> 工作单位：</label> <input id="txt_unit"
						class="text-input  typeahead" type="text"  value="xx市xx区(县)xx单位"  onfocus="if (value =='xx市xx区(县)xx单位'){value =''}" onblur="checkUnit()" />&nbsp;&nbsp;<span
						id="txt_unitTip"></span>
				</div>
				<div class="form_item">
					<label> 职务职称：</label> <input id="txt_Ocu"
						class="text-input  typeahead" type="text" onblur="checkOcu()" />&nbsp;&nbsp;<span
						id="txt_OcuTip"></span>
				</div>
				<div class="form_item">
					<label> 学科专业：</label> <input id="txt_Spe"
						class="text-input  typeahead" type="text"
						onblur="checkSpe()" />&nbsp;&nbsp;<span id="txt_SpeTip"></span>
				</div>
				<div class="form_item">
					<label> 最高学历：</label> 
					<input id="edu1" type="radio" name="role"  value="专科" />专科
					<input id="edu2" type="radio"  value="本科"  checked="checked"/>本科
					<input id="edu3" type="radio"  value="硕士" />硕士
					<input id="edu4" type="radio"   value="博士" />博士
					<input id="edu5" type="radio"   value="其它" />其它
				</div>
				
				<div class="form_item">
					<input value="提    交" type="button" class="submit"
						onclick="check();"/>
				</div>
				<div class="form_item declare">
					<label> 本站声明：</label> 
					<p>1.本站所保存之用户个人信息仅供用户统计和联系使用，不会用于任何商业目的；</p>
					<p>2.填写手机号码后可使用手机号码登录本站；</p>
					<p>3.填写完整个人信息将获得**积分奖励；</p>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">

	
	  var state1=false;
	  var state2=false;
	  var state3=false;
	  var state4=false;
	  var state5=false;
	
	   function checkName(){
	       var name = $("#txtName").val();
            if (name == "" || name == null) {
                $("#txtNameTip").removeClass("onCorrect").addClass("onError").html("真实姓名不能为空！");
            }
            else if(name.length<2){
              $("#txtNameTip").removeClass("onCorrect").addClass("onError").html("真实姓名不能小于2个字符！");    
            }
	         else {
              $("#txtNameTip").removeClass("onError").addClass("onCorrect").html("");
             state1 = true;
            }
	   
	   }
	
	  	   function checkUnit(){
	  	   
	        var unit = $("#txt_unit").val();
            if (unit == "" || unit == null) {
                 $("#txt_unit").val('xx市xx区(县)xx单位');
                $("#txt_unitTip").removeClass("onCorrect").addClass("onError").html("工作单位不能为空！");
            }
            else if(unit.length<6){
              $("#txt_unitTip").removeClass("onCorrect").addClass("onError").html("工作单位不能小于6个字符！");    
            }
	         else {
              $("#txt_unitTip").removeClass("onError").addClass("onCorrect").html("");
              state2 = true;
            }
	   
	   }
	
	 function checkOcu(){
	        var ocu = $("#txt_Ocu").val();
            if (ocu == "" || ocu == null) {
                $("#txt_OcuTip").removeClass("onCorrect").addClass("onError").html("职务职称不能为空！");
            }
            else if(ocu.length<2){
              $("#txt_OcuTip").removeClass("onCorrect").addClass("onError").html("职务职称不能小于2个字符！");    
            }
	         else {
              $("#txt_OcuTip").removeClass("onError").addClass("onCorrect").html("");
               state3 = true;
            }
	   
	   }
	
	   function checkSpe(){
	        var spe = $("#txt_Spe").val();
            if (spe == "" || spe == null) {
                $("#txt_SpeTip").removeClass("onCorrect").addClass("onError").html("职务职称不能为空！");
            }
            else if(spe.length<2){
              $("#txt_SpeTip").removeClass("onCorrect").addClass("onError").html("职务职称不能小于2个字符！");    
            }
	         else {
              $("#txt_SpeTip").removeClass("onError").addClass("onCorrect").html("");
               state4 = true;
            }
	   
	   }
	
        function checkMobile() {
            var mobile = $("#txtMobile").val();
            if (mobile == "" || mobile == null) {
                $("#txtMobileTip").addClass("onError").html("输入手机号不能为空！");
                $("#btnSendVerCode").attr("disabled", "disabled");
                f2 = false;
            } else {
                var reg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
                if (!reg.test(mobile)) {
                    $("#txtMobileTip").removeClass("onCorrect").html("");
                    $("#txtMobileTip").addClass("onError").html("输入手机号错误！");
                    $("#btnSendVerCode").attr("disabled", "disabled");
                    f2 = false;}
                 else {
                    $.ajax({
                        url: "/Member/CheckMobile",
                        type: 'post',
                        async: false,
                        dataType: 'text',
                        data: { Mobile: mobile },
                        success: function (data) {
                            if (data == "true") {
                                $("#txtMobileTip").removeClass("onCorrect").html("");
                                $("#txtMobileTip").addClass("onError").html("该手机号已使用，请更换手机号码！");
                            } else {
                                $("#txtMobileTip").addClass("onCorrect").html("恭喜您,该手机号可以使用！");
                                return true;
                                
                            }
                        },
                        error: function (err) {
                        state5 = true;
//                             alert("检查手机号失败，请联系管理员");
                        }
                    });
               }
            }
        }
	
	
	
	           function check() {
	               if(  state1&&state2&&state3&&state4&&state5){
	                    alert("成功");
	               }
	               else{
	                   alert("失败");
	               }
	           
	           }
	</script>
	
</body>
</html>