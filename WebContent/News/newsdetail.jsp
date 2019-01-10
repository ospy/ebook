<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/Master/header.jsp"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title class="newtitle"></title>

<link href="/Css/NewsDetail.css" rel="stylesheet" />
<link href="/Css/Login.css" rel="stylesheet" />


<script src="/Js/bootstrap.js"></script>
<script src="/Js/jquery-ui.js"></script>


</head>

<script type="text/javascript">
    getsession();
	(function($) {

			$.getUrlParam = function(name)
		{
			var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
		if (r!=null) return unescape(r[2]); return null;
			}
		
	}(jQuery));
	
	
</script>
<body>
<div class="main" id="newsdetail">
		  <h2 class="newtitle"></h2>
		  <hr>
		  <p id="datetime"></p>
		  <div id="newcontent"></div>
		  <a onclick="javascript:window.close();" class="btn btn-link goback"><span class="close">×</span>关闭</a>
  </div>
</body>
<script>
getNewsDetail();
//获取新闻详情
function getNewsDetail() {
	var nid=$.getUrlParam('id');
	$.ajax({
				url : "/NewsDetail",
				type : 'post',
				async : true,
				dataType : 'json',
				data: { nid:nid},
				success : function(result) {
					if (result != "") {								
							$(".newtitle").html(result[0].title);
							$("#datetime").html(result[0].datetime.substr(0,10));
						$("#newcontent").html(result[0].content);
					}
				},
				error : function() {
					alert("获取新闻详情异常，请联系管理员！");
					return false;
				}
			});
}

</script>
</html>