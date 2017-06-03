<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分类列表</title>
<%@ page import="com.ebook.classeslist.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>

<link href="/Css/jquery-ui.css" rel="stylesheet" />
<link href="/Css/classlist.css?v=20171223" rel="stylesheet" />
<link href="/Css/page.css?v=20171214" rel="stylesheet" />
<link href="/Css/bootstrap.css?v=20161214" rel="stylesheet" />
<link href="/Css/jquery-ui.css" rel="stylesheet" />
<link href="/Css/jquery-ui-timepicker-addon.css" rel="stylesheet" />

<script src="/Js/jquery-ui.js"></script>
<script src="/Js/jquery.myPagination.js"></script>
<script src="/Js/Disculist.js"></script>



<script src="/Js/jquery-ui-timepicker-addon.min.js"></script>
<script src="/Js/jquery-ui-timepicker-zh-CN.js"></script>
</head>

<script type="text/javascript">
	(function($) {

		$(function() {
			$.datepicker.regional['zh-CN'] = {
				changeMonth : true,
				changeYear : true,
				clearText : '清除',
				clearStatus : '清除已选日期',
				closeText : '关闭',
				closeStatus : '不改变当前选择',
				prevText : '<上月',
				prevStatus : '显示上月',
				prevBigText : '<<',
						prevBigStatus: '显示上一年',
						nextText: '下月>',
				nextStatus : '显示下月',
				nextBigText : '>>',
				nextBigStatus : '显示下一年',
				currentText : '今天',
				currentStatus : '显示本月',
				monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月',
						'九月', '十月', '十一月', '十二月' ],
				monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8',
						'9', '10', '11', '12' ],
				monthStatus : '选择月份',
				yearStatus : '选择年份',
				weekHeader : '周',
				weekStatus : '年内周次',
				dayNames : [ '星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六' ],
				dayNamesShort : [ '周日', '周一', '周二', '周三', '周四', '周五', '周六' ],
				dayNamesMin : [ '日', '一', '二', '三', '四', '五', '六' ],
				dayStatus : '设置 DD 为一周起始',
				dateStatus : '选择 m月 d日, DD',
				dateFormat : 'yy-mm-dd',
				firstDay : 1,
				initStatus : '请选择日期',
				isRTL : false
			};

		});

		$(function() {

			$.datepicker.setDefaults($.datepicker.regional['zh-CN']);

			$("#StartTime").prop("readonly", true).datepicker({
				showMonthAfterYear : true, // 月在年之后显示      
				changeMonth : true, // 允许选择月份     
				changeYear : true, // 允许选择年份     
				dateFormat : 'yy-mm-dd', // 设置日期格式   
				onClose : function(selectedDate) {
				}

			});

			$("#EndTime").prop("readonly", true).datepicker({
				showMonthAfterYear : true, // 月在年之后显示      
				changeMonth : true, // 允许选择月份     
				changeYear : true, // 允许选择年份     
				dateFormat : 'yy-mm-dd', // 设置日期格式   
				defaultDate:  new Date(),
				setDate:new Date(),
				onClose : function(selectedDate) {
				}
			
			});
		});

	
			$.getUrlParam = function(name)
		{
			var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
		if (r!=null) return unescape(r[2]); return null;
			}
		
	}(jQuery));
	
	
</script>
<body>
	<div class="main">
		<div class="col_left">

			<div class="ranking_list">
				<h3>
					<a target="_blank" href="/RankingList/DownloadRanking.aspx"></a>最新书目
				</h3>
				<ul id="latest_publish">

				</ul>
			</div>

			<div class="ranking_list">
				<h3>热门下载</h3>
				<ul id="month_download">
				</ul>
			</div>
			<div class="ranking_list">
				<h3>最近下载</h3>
				<ul id="latest_download">
				</ul>
			</div>

		</div>

		<div class="col_right">
		    <table class="limit">
		          <tr class="clinic_tr  classlist">
		                <td class="top">临床医学：</td>
		                 <td><div class="Clinic  Spec">
						
						<div class="Spec_show">
							
							<ul class="item">

								<li><a onclick="getClassListBySpid(1000)">内科综合</a></li>
								<li><a onclick="getClassListBySpid(1001)">呼吸综合</a></li>
								<li><a onclick="getClassListBySpid(1002)">消化内科</a></li>
								<li><a onclick="getClassListBySpid(1003)">神经内科</a></li>
								<li><a onclick="getClassListBySpid(1004)">心血管内科</a></li>
								<li><a onclick="getClassListBySpid(1005)">血液内科</a></li>
								<li><a onclick="getClassListBySpid(1006)">肾内科</a></li>
								<li><a onclick="getClassListBySpid(1007)">内分泌科</a></li>
								<li><a onclick="getClassListBySpid(1008)">风湿免疫科</a></li>
								<li><a onclick="getClassListBySpid(1009)">变态反应科</a></li>
								<li><a onclick="getClassListBySpid(1010)">老年病科</a></li>
							</ul>
						</div>
						<div class="Spec_show ">
							<ul class="secondclass">
								<li><a onclick="getClassListBySpid(2000)">外科综合</a></li>
								<li><a onclick="getClassListBySpid(2001)">普通外科</a></li>
								<li><a onclick="getClassListBySpid(2002)">神经外科</a></li>
								<li><a onclick="getClassListBySpid(2003)">骨科</a></li>
								<li><a onclick="getClassListBySpid(2004)">泌尿外科 </a></li>
								<li><a onclick="getClassListBySpid(2005)">胸外科</a></li>
								<li><a onclick="getClassListBySpid(2006)">心血管外科</a></li>
								<li><a onclick="getClassListBySpid(2007)">烧伤科</a></li>
							</ul>
						</div>
						<div class="Spec_show">
							<ul class="item">
								<li><a onclick="getClassListBySpid(3000)">全科医学</a></li>
								<li><a onclick="getClassListBySpid(3100)">妇产科</a></li>
								<li><a onclick="getClassListBySpid(3200)">儿科</a></li>
								<li><a onclick="getClassListBySpid(3300)">眼科</a></li>
								<li><a onclick="getClassListBySpid(3400)">耳鼻咽喉科</a></li>
								<li><a onclick="getClassListBySpid(3500)">口腔科</a></li>
								<li><a onclick="getClassListBySpid(3600)">皮肤性病科</a></li>
								<li><a onclick="getClassListBySpid(3700)">整形美容科</a></li>
								<li><a onclick="getClassListBySpid(3800)">传染科</a></li>
								<li><a onclick="getClassListBySpid(3900)">肿瘤科</a></li>

							</ul>
						</div>

						<div class="Spec_show">
							<ul class="item">
								<li><a onclick="getClassListBySpid(4000)">急诊医学科</a></li>
								<li><a onclick="getClassListBySpid(4100)">重症医学科</a></li>
								<li><a onclick="getClassListBySpid(4200)">康复医学科</a></li>
								<li><a onclick="getClassListBySpid(4300)">运动医学科</a></li>
								<li><a onclick="getClassListBySpid(4400)">职业病科</a></li>
								<li><a onclick="getClassListBySpid(4500)">特种医学</a></li>
								<li><a onclick="getClassListBySpid(4600)">麻醉科</a></li>
								<li><a onclick="getClassListBySpid(4700)">疼痛科</a></li>
								<li><a onclick="getClassListBySpid(4800)">精神科</a></li>
								<li><a onclick="getClassListBySpid(4900)">中医科</a></li>
							</ul>
						</div>
						<div class="Spec_show">
							<ul class="item">
								<li><a onclick="getClassListBySpid(5000)">中西医结合</a></li>
								<li><a onclick="getClassListBySpid(5100)">护理</a></li>
								<li><a onclick="getClassListBySpid(5200)">医学检验</a></li>
								<li><a onclick="getClassListBySpid(5300)">病理科</a></li>
								<li><a onclick="getClassListBySpid(5400)">影像科</a></li>
								<li><a onclick="getClassListBySpid(5500)">营养保健科</a></li>
								<li><a onclick="getClassListBySpid(5600)">流行病学与防疫</a></li>
								<li><a onclick="getClassListBySpid(5700)">卫生事业管理</a></li>

							</ul>
						</div>
					</div></td>
<!-- 		            <td  class="top"><span class="more">更多 <i class="more-arrow"></i></span></td> -->
		          </tr>
		          <tr class="basic_tr classlist"><td  class="top">基础医学：</td>
		                 <td><div class="Basic Spec_show ">
						
						<ul class="item">
							<li><a onclick="getClassListBySpid(6000)">医用数学</a></li>
							<li><a onclick="getClassListBySpid(6100)">医用物理</a></li>
							<li><a onclick="getClassListBySpid(6200)">基础化学</a></li>
							<li><a onclick="getClassListBySpid(6300)">有机化学</a></li>
							<li><a onclick="getClassListBySpid(6400)">解剖学</a></li>
							<li><a onclick="getClassListBySpid(6500)">生物化学</a></li>
							<li><a onclick="getClassListBySpid(6600)">遗传学</a></li>
							<li><a onclick="getClassListBySpid(6700)">细胞生物学</a></li>
							<li><a onclick="getClassListBySpid(6800)">组织胚胎学</a></li>
							<li><a onclick="getClassListBySpid(6900)">生物工程</a></li>
							<li><a onclick="getClassListBySpid(7000)">生理学</a></li>
							<li><a onclick="getClassListBySpid(7100)">微生物学</a></li>
							<li><a onclick="getClassListBySpid(7200)">寄生虫学</a></li>
							<li><a onclick="getClassListBySpid(7300)">医学免疫学</a></li>
							<li><a onclick="getClassListBySpid(7400)">病理学</a></li>
							<li><a onclick="getClassListBySpid(7500)">病理生理学</a></li>
							<li><a onclick="getClassListBySpid(7600)">医学心理学</a></li>
						</ul>
					</div></td>
		                
		          </tr>
		          <tr class="pharmacy_tr classlist">
		                 <td  class="top">药&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学：</td>
		                 <td><div class="Pharmacy Spec_show">						
						<ul class="item">
							<li><a onclick="getClassListBySpid(9000)">基础药学</a></li>
							<li><a onclick="getClassListBySpid(9001)">药物分析</a></li>
							<li><a onclick="getClassListBySpid(9002)">药典</a></li>
							<li><a onclick="getClassListBySpid(9003)">处方集</a></li>
							<li><a onclick="getClassListBySpid(9004)">药物鉴定</a></li>
							<li><a onclick="getClassListBySpid(9005)">天然药物学</a></li>
							<li><a onclick="getClassListBySpid(9006)">药剂学</a></li>
							<li><a onclick="getClassListBySpid(9007)">药事组织</a></li>
							<li><a onclick="getClassListBySpid(9008)">药理学</a></li>
							<li><a onclick="getClassListBySpid(9009)">药品</a></li>
							<li><a onclick="getClassListBySpid(9010)">毒理学</a></li>

						</ul>
					</div></td>
		                  
		          </tr>
		          <tr class="date_control"><td class="top">发布日期：</td>
		                 <td>							<div class="control-group">
								<input id="StartTime" />
							</div>
							--
							<div class="control-group">
		
								<input id="EndTime">
							</div></td>
		                  </tr>
		    </table>
					

             <div class="listcontent">
			<div class="orderbox">
				共找到&nbsp;<span id="total" style="color: red"></span>&nbsp;条记录 <span class="ordercontrol">排序方式：发布时间 <a id="down_time" data="order by a.s_create_time desc" class="down_arrow down_arrow_actived order  actived"></a>&nbsp;<a id="up_time" data="order by a.s_create_time asc" class="up_arrow  order"></a>&nbsp;&nbsp;下载次数 <a id="down_download" data="order by a.i_download_times desc" class="down_arrow  order"></a>&nbsp;<a id="up_download" data="order by a.i_download_times asc" class="up_arrow  order"></a>&nbsp;&nbsp;点击次数 <a id="down_click"  data="order by a.i_click_times desc" class="down_arrow  order"></a>&nbsp;<a id="up_click" data="order by a.i_click_times asc" class="up_arrow  order"></a></span>
			</div>
			<div id="discuList"  style="height: auto;"></div>
			<div id="foot" style="height: 40px; text-align: center;"></div>

			<div id="Pager" style="width: 800px;"></div>
		</div>
		</div>

		



		<div class="clear"></div>

	</div>

	</div>
	<script type="text/javascript">
		var spid = 0;//spid = 0 学科编码
		var totalPage = 0;
		var pageListSize = 20;//每页显示调试
		//var uType = 0;//uType=2管理员
		var startTime = "";
		var endTime = "";
        var classid =$.getUrlParam('classid');
        var where ="";
        var order ="";
		$(function() {
              if(classid==1){
            	  $(".clinic_tr").show().siblings(".classlist").hide();
            	
              }
              if(classid==2){
            	  $(".basic_tr").show().siblings(".classlist").hide();
            	 
              }
              if(classid==3){
            	  $(".pharmacy_tr").show().siblings(".classlist").hide();
            	 
              }
              else{
            	  
            	  $(".classlist").show();
              }

			//排序显示样式控制
			 $(".down_arrow").click(function(){				 
				   $(this).addClass("down_arrow_actived actived").siblings().removeClass("down_arrow_actived up_arrow_actived actived");
				   getClassListBySpid();
			 })
			  $(".up_arrow").click(function(){								 
				  $(this).addClass("up_arrow_actived actived").siblings().removeClass("down_arrow_actived up_arrow_actived actived");			  
				  getClassListBySpid();
			 })
   
			           
             getClassListBySpid();
			

		});

		//学科筛选
		function getClassListBySpid(i_spid) {
			spid = i_spid;
			//GetDepartment(dpid);
			//$(".secondclass li a").removeClass("spec");
			//$("." + dpid).addClass("spec");

			//时间条件限定
			startTime = $("#startTime").val();
			var curr_time = new Date();
			endTime = curr_time.getFullYear() + "-";
			endTime += curr_time.getMonth() + 1 + "-";
			endTime += curr_time.getDate();

			if ($("#startTime").val() != "" && $("#endTime").val() == "") {
				startTime = $("#startTime").val();
				$("#sTime").html(startTime);
			}
			if ($("#endTime").val() != "") {
				endTime = $("#endTime").val();
				$("#eTime").html(endTime);
			}
			
			getCount(spid);

		
		}

		//时间筛选
		function timeSearch() {
			GetDepartment(dpid);
			//时间条件限定
			startTime = "2007-01-01";

			var curr_time = new Date();
			var endTime = curr_time.getFullYear() + "-";
			endTime += curr_time.getMonth() + 1 + "-";
			endTime += curr_time.getDate();

			if ($("#startTime").val() != "" && $("#endTime").val() == "") {
				startTime = $("#startTime").val();
				$("#sTime").html(startTime);
				$("#between").html("至今");
			}

			if ($("#endTime").val() != "") {
				if ($("#startTime").val() != "") {
					startTime = $("#startTime").val();
				}
				$("#sTime").html(startTime);
				$("#eTime").html(endTime);
				endTime = $("#endTime").val();
				$("#between").html("至");
				$("#eTime").html(endTime);
			}
			//面包屑限定条件样式
			$("#time_limit").removeClass("limit_info");
			$("#time_limit .crumbDelete").remove();
			if ($("#startTime").val() != "" || $("#endTime").val() != "") {
				$("#time_limit").addClass("limit_info");
				$("#time_limit").append(
						'<a class="crumbDelete" onclick="ClearTime();"></a>')
			} else {
				$("#time_limit").removeClass("limit_info");
				$("#time_limit .crumbDelete").remove();
			}

			$("#foot").html("<img src='/images/loading.gif'/>");
			
			
			//GetDiscuByPage(0, pageListSize, dpid, startTime, endTime);

			$("#foot").html("");
		}

		//清除时间限定
		function ClearTime() {
			$("#startTime").val('');
			$("#endTime").val('');
			$("#sTime").html("");
			$("#eTime").html("");
			$("#between").html("");
			$("#time_limit").removeClass("limit_info");
			$("#time_limit .crumbDelete").remove();

			startTime = "2007-01-01";
			var curr_time = new Date();
			endTime = curr_time.getFullYear() + "-";
			endTime += curr_time.getMonth() + 1 + "-";
			endTime += curr_time.getDate();

			$("#foot").html("<img src='/images/loading.gif'/>");
			getCount(dpid);
			//GetDiscuByPage(0, pageListSize, dpid, startTime, endTime);

			$("#foot").html("");
		}
		//清除学科限定
		function ClearSpec() {
			startTime = "2007-01-01";

			var curr_time = new Date();
			endTime = curr_time.getFullYear() + "-";
			endTime += curr_time.getMonth() + 1 + "-";
			endTime += curr_time.getDate();

			if ($("#startTime").val() != "" && $("#endTime").val() == "") {
				startTime = $("#startTime").val();
				$("#sTime").html(startTime);
				$("#between").html("至今");
			}

			if ($("#endTime").val() != "") {
				endTime = $("#endTime").val();
				$("#between").html("至");
				$("#eTime").html(endTime);
			}
			$(".secondclass li a").removeClass("spec");
			$("#select").html("全部学科");
			$("#foot").html("<img src='/images/loading.gif'/>");
			GetDiscuCount(0);
			//GetDiscuByPage(0, pageListSize, 0, startTime, endTime);

			$("#foot").html("");
		}

		//根据学科编号获取学科名称
		function GetDepartment(dpid) {
			$
					.ajax({
						url : "/DiscuList/GetDepartment",
						type : 'post',
						async : false,
						dataType : 'text',
						data : {
							dpid : dpid
						},
						success : function(result) {
							if (result != "") {
								$("#select")
										.html(
												result
														+ '<a class="crumbDelete" onclick="ClearSpec();"></a>');
							}
						},
						error : function(err) {
							alert("获取学科异常，请联系管理员");
							return false;
						}
					});

		}

		//最新发布
		function GetNewDiscu() {
			$
					.ajax({
						url : "/Home/GetNewDiscu",
						type : 'post',
						async : false,
						dataType : 'text',
						success : function(result) {
							if (result != "") {
								var obj = strToJson(result);
								var str = "";
								for (var i = 0; i < obj.length; i++) {
									str += "<li><a class=\"img\" target=\"_blank\" href=\"/DiscuDetail/DiscuDetail/" + obj[i].i_discuid + "\" title=\"\">";
									str += "<img title=\"" + obj[i].s_desc + "\" alt=\"" + obj[i].s_desc + "\" src=\"/Pic/" + obj[i].s_path + "\" height=\"150\" width=\"150\"></a>";
									str += "<p class=\"name\"> <a  title=\"" + obj[i].s_desc + "\" href=\"/DiscuDetail/DiscuDetail/" + obj[i].i_discuid + "\" target=\"_blank\">"
											+ obj[i].s_desc.substring(0, 40)
											+ "</a></p> </li>";
								}
								$("#latest_publish").append(str);
							}
						},
						error : function(err) {
							alert("获取最新发布帖子异常，请联系管理员");
							return false;
						}
					});
		}

		//最新下载
		function GetDownDiscu() {
			$
					.ajax({
						url : "/Home/GetDownDiscu",
						type : 'post',
						async : false,
						dataType : 'text',
						success : function(result) {
							if (result != "") {
								var obj = strToJson(result);
								var str = "";
								for (var i = 0; i < obj.length; i++) {
									str += "<li><a class=\"img\" target=\"_blank\" href=\"/DiscuDetail/DiscuDetail/" + obj[i].i_discuid + "\" title=\"\">";
									str += "<img title=\"" + obj[i].s_desc + "\" alt=\"" + obj[i].s_desc + "\" src=\"/Pic/" + obj[i].s_path + "\" height=\"150\" width=\"150\"></a>";
									str += "<p class=\"name\"> <a  title=\"" + obj[i].s_desc + "\" href=\"/DiscuDetail/DiscuDetail/" + obj[i].i_discuid + "\" target=\"_blank\">"
											+ obj[i].s_desc.substring(0, 40)
											+ "</a></p> </li>";
								}
								$("#latest_download").append(str);
							}
						},
						error : function(err) {
							alert("获取最新下载异常，请联系管理员");
							return false;
						}
					});
		}

		//字符串转json
		function strToJson(str) {
			var json = eval('(' + str + ')');
			return json;
		}		

         function getCount(spid){
        	 spid = spid;       	
        	 startTime = $("#startTime").val();
    		 endTime = $("#endTime").val();
    		
	            $.ajax({
	                url: "<%=path%>/GetCount",
	                type: 'post',
	                async: true,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'json',
	                data: { spid:spid,startTime:startTime,endTime:endTime },
	                success: function (result) {
	               
                    if(result[0].Count !=0 ){       
					var	pageTotalCount = parseInt(result[0].Count);//总记录数
						$("#total").html(pageTotalCount);
						totalPage = parseInt(pageTotalCount
								/ pageListSize)
								+ ((pageTotalCount % pageListSize) > 0 ? 1
										: 0);

						//mypagination
						$("#Pager").show();
						$("#Pager").myPagination({
							currPage : 1,
							pageCount : totalPage,
							pageSize : 10
						});
                    }
                    else{
                    	$("#total").html("0");
                    	$("#discuList").html("<div class='no_record'>抱歉！没有找到符合限定条件的记录。</div>");
                    	$("#Pager").hide();
                          }	                		                	
	                },
	                error: function () {
	                    alert("获取记录总数异常！");
	                    return false;
	                }
	            });	 
        	 
         }
		//获取图书列表
         function getClassList(spid,pageIndex, pageListSize){
			 spid = spid;
        	 startTime = $("#startTime").val();
 			 endTime = $("#endTime").val();
 			 
		     order =$(".actived").attr("data");
		    
	            $.ajax({
	                url: "<%=path%>/ClassList",
	                type: 'post',
	                async: false,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'json',
	                data: { spid:spid,startTime:startTime,endTime:endTime,pageIndex:pageIndex,pageListSize:pageListSize,order:order },
	                success: function (result) {
	                	$("#discuList").html("");
	                	if (result != 0) {
	                	var str = "";
	                	for(var i=0;i < result.length;i++ ){
	                		
	                		str += "<div class=\"listtable\"><a title=\"" + result[i].s_desc + "\" class=\"pic\" href=\"/DiscuDetail/DiscuDetail/" + result[i].i_discuid + "\" target=\"_blank\">";
							str += "<img title=\"" + result[i].s_desc + "\" src=\"/Pic/" + result[i].s_imgurl + "\" style=\"height: 150px; width: 150px;\"><span  class=\"property\"><span class=\"bookmark\" title=\"书签\"></span></span>";
							str += "<span class=\"createTime\" style=\"display: none;\">"
									+ result[i].s_create_time
									+ "</span></a>";
							str += "<p class=\"firsttd\"><span class=\"icon pdf\"></span>";
							
						    str += "<a class=\"title\" title=\"" + result[i].s_desc + "\" href=\"/DiscuDetail/DiscuDetail/" + result[i].i_discuid + "\" target=\"_blank\">"
										+ result[i].s_desc + "</a>";

							str += "<span class=\"listtime\">&nbsp; "
									+ result[i].s_create_time.substring(0,
											10) + "</span></p>";
						
							str += "<p class=\"others\"><span class=\"subtitle\">资源类型："
									+ result[i].FileType+"</p>";
							str += "<p class=\"others\"><span class=\"subtitle\">发&nbsp;&nbsp;布&nbsp;&nbsp;者："
									+ result[i].s_loginid+"</p>";
							str += "<p class=\"others\"><span class=\"subtitle\">点击次数："
									+ result[i].i_click_times
									+ "</span>&nbsp;&nbsp;&nbsp;<span class=\"subtitle\">下载次数："
									+ result[i].i_download_times + "</span></p>";

							//str += "<p class=\"datail\">摘要：<span  class=\"abstract\">《折裂牙原因、分型及保存》根据作者多年的临床经验编写而成。全书主要内容包括，折裂牙原因，牙齿折裂的分型，折裂牙的保存范围，折裂牙的保存治疗，根裂，与折裂牙保存相关的牙周手术，与劈裂牙保存相关的其他问题等。全书内容全面，结构合理，同时作者还配用大量的图片进行说明，以便于读者的阅读和理解。《折裂牙原因、分型及保存》适合具有...</span></p>";
							str += "<p><span class=\"price\">￥"
									+ result[i].i_discuPrice
									+ "点</span>&nbsp;&nbsp;&nbsp;&nbsp;</p></div>";
						}
						$("#discuList").html(str);
	                	} else {
	                        $("#discuList").html("<div class='no_record'>抱歉！没有找到符合限定条件的记录。</div>");
	                    }
	                },
	                error: function () {
	                    alert("获取书目列表异常！");
	                    return false;
	                }
	            });	 
		 

	
	}

		


	</script>
</body>
</html>