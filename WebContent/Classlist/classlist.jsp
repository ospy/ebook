<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分类列表</title>



<link href="/Css/page.css?v=20171214" rel="stylesheet" />
<link href="/Css/bootstrap.css?v=20161214" rel="stylesheet" />
<link href="/Css/jquery-ui.css" rel="stylesheet" />
<link href="/Css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
<link href="/Css/classlist.css" rel="stylesheet" />

<script  type="text/javascript" src="<%=path %>/Js/jquery-1.9.1.js" ></script>
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
		$.datepicker.setDefaults({
			showButtonPanel: true,
			beforeShow : function( input ) {
				setTimeout(function() {
					var buttonPane = $(input)
					.datepicker( "widget" )
					.find( ".ui-datepicker-buttonpane" );
					$( "<button>", {
						text: "清除",
						click: function() {
							$.datepicker._clearDate(input);
						}
					}).addClass("ui-state-default ui-priority-primary ui-corner-all").appendTo( buttonPane );
				}, 1 );
			}
		});


	
			$.getUrlParam = function(classid)
		{
			var reg = new RegExp("(^|&)"+ classid +"=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
		if (r!=null) return unescape(r[2]); return null;
			}
		
	}(jQuery));
	
	
</script>
<body>
<div href="javascript:;" id="backtop" title="回到顶部" style="text-align: center;"><br><br><span>回到</span><br><span>顶部</span></div>
<script>window.onload = function(){
    var obtn = document.getElementById('backtop');  //获取回到顶部按钮的ID
    var clientHeight = document.documentElement.clientHeight;   //获取可视区域的高度
    var timer = null; //定义一个定时器
    var isTop = true; //定义一个布尔值，用于判断是否到达顶部

    window.onscroll = function(){         //滚动条滚动事件

        //获取滚动条的滚动高度
        var osTop = document.documentElement.scrollTop || document.body.scrollTop; 

        if(osTop >= clientHeight){  //如果滚动高度大于可视区域高度，则显示回到顶部按钮
            obtn.style.display = 'block';
        }else{         //否则隐藏
            obtn.style.display = 'none';
        }

        //主要用于判断当 点击回到顶部按钮后 滚动条在回滚过程中，若手动滚动滚动条，则清除定时器
        if(!isTop){

            clearInterval(timer);
        }
        isTop = false;

    }

    obtn.onclick = function(){    //回到顶部按钮点击事件
        //设置一个定时器
        timer = setInterval(function(){
            //获取滚动条的滚动高度
            var osTop = document.documentElement.scrollTop || document.body.scrollTop;
            //用于设置速度差，产生缓动的效果
            var speed = Math.floor(-osTop / 6);
            document.documentElement.scrollTop = document.body.scrollTop = osTop + speed;
            isTop =true;  //用于阻止滚动事件清除定时器
            if(osTop == 0){
                clearInterval(timer);
            }
        },30);
    }
}</script> 
     <div class="location">
        首页 &gt; 分类列表 &gt; &nbsp;&nbsp;<span class="limit_info" id="select"></span>&nbsp;<span id="time_limit"><span id="sTime"></span><span id="between"></span><span id="eTime"></span></span>
    </div>
	<div class="main">
	   
		<div class="col_left">

			<div class="ranking_list">
				<h3>最新书目</h3>
				<ul id="latest_publish">

				</ul>
			</div>

			<div class="ranking_list">
				<h3>热门下载</h3>
				<ul id="max_download">
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
					<td class="top item"><a id="1" onclick="selectClass(1)">临床医学</a>：</td>
					<td><div id="clinic-content" class="Clinic  Spec_show">
                        </div>
	                </td>
					<!-- 		            <td  class="top"><span class="more">更多 <i class="more-arrow"></i></span></td> -->
				</tr>
				<tr class="basic_tr classlist">
					<td class="top item"><a id="2" onclick="selectClass(2)">基础医学</a>：</td>
					<td><div id="basic_content" class="Basic Spec_show ">

							
						</div></td>

				</tr>
				<tr class="pharmacy_tr classlist">
					<td class="top item"><a id="3"  onclick="selectClass(3)">药&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学</a>：</td>
					<td><div id="phar-content" class="Pharmacy Spec_show">
							
						</div></td>

				</tr>
				<tr class="date_control">
					<td class="top">发布日期：</td>
					<td>
						<div class="control-group">
							<input id="StartTime"  value=""/>
						</div> <div class="control-group">至</div>
						<div class="control-group">

							<input id="EndTime">
						</div>
					</td>
				</tr>
				
			</table>


			<div class="listcontent">
				<div class="orderbox">
					共找到&nbsp;<span id="total" style="color: red"></span>&nbsp;条记录 <span
						class="ordercontrol">排序方式：发布时间 <a id="down_time"
						data="order by a.s_create_time desc"
						class="down_arrow down_arrow_actived order  actived"></a>&nbsp;<a
						id="up_time" data="order by a.s_create_time asc"
						class="up_arrow  order"></a>&nbsp;&nbsp;下载次数 <a id="down_download"
						data="order by a.i_download_times desc" class="down_arrow  order"></a>&nbsp;<a
						id="up_download" data="order by a.i_download_times asc"
						class="up_arrow  order"></a>&nbsp;&nbsp;点击次数 <a id="down_click"
						data="order by a.i_click_times desc" class="down_arrow  order"></a>&nbsp;<a
						id="up_click" data="order by a.i_click_times asc"
						class="up_arrow  order"></a></span>
				</div>
				<div id="discuList" style="height: auto;"></div>
				<div id="foot" style="height: 40px; text-align: center;"></div>

				<div id="Pager" style="width: 800px;"></div>
			</div>
		</div>
		<div class="clear"></div>
	</div>

				
	<script type="text/javascript">
	    var classcount=0;
	    var currlimit="";
		var totalPage = 0;
		var pageListSize = 10;//每页显示调试
		//var uType = 0;//uType=2管理员
		var startTime = "";
		var endTime = "";		
		var classid =$.getUrlParam('classid');
        var search="";
        var where ="";
        var order ="";
		$(function() {
		
               //初始化日期时间控件
					$.datepicker.setDefaults($.datepicker.regional['zh-CN']);

					$("#StartTime").prop("readonly", false).datepicker({
						showMonthAfterYear : true, // 月在年之后显示      
						changeMonth : true, // 允许选择月份     
						changeYear : true, // 允许选择年份     
						dateFormat : 'yy-mm-dd', // 设置日期格式   
						onClose : function(selectedDate) {
							
							selectClass(classid);
						}

					});

					$("#EndTime").prop("readonly", false).datepicker({
						showMonthAfterYear : true, // 月在年之后显示      
						changeMonth : true, // 允许选择月份     
						changeYear : true, // 允许选择年份     
						dateFormat : 'yy-mm-dd', // 设置日期格式   
						defaultDate:  new Date(),
						setDate:new Date(),
						onClose : function(selectedDate) {
							
							selectClass(classid);
						}
					
					});
		
			//排序显示样式控制
			 $(".down_arrow").click(function(){				 
				   $(this).addClass("down_arrow_actived actived").siblings().removeClass("down_arrow_actived up_arrow_actived actived");
				   $("#Pager").myPagination({
						currPage : 1,
						pageCount : totalPage,
						pageSize : 10
					});
			 });
			  $(".up_arrow").click(function(){								 
				  $(this).addClass("up_arrow_actived actived").siblings().removeClass("down_arrow_actived up_arrow_actived actived");			  
				  $("#Pager").myPagination({
						currPage : 1,
						pageCount : totalPage,
						pageSize : 10
					});
			 });
   
			           
			 GetSpec();
			 selectClass(classid);
			 
			 getNewByClass(classid);
             
			 getHotByClass(classid);
			 
			 getLatestDownByClass(classid);
			 
			
		});
		//选择分类
		function selectClass(id){
			classid=id;
			$(".item a").removeClass("selected");
			$("#"+classid).addClass("selected");
			
		    //面包屑限定条件样式
			currlimit="";
			if(classid==0||classid==""||classid==null){
				currlimit="全部学科";
			}
			else if(classid==1){
				currlimit="临床医学";
			}
			else if(classid==2){
				currlimit="基础医学";
			}
			else if(classid==3){
				currlimit="药学";
			}
			else{
				if($(".selected").length!=0){
				$(".selected").each(function(){
					currlimit=$(this).html();			
					});
				 
			    }
				
			}
			$("#select").html(currlimit);
         
		 startTime = $("#StartTime").val();
   		 endTime = $("#EndTime").val();
            if ($("#StartTime").val() != "" || $("#EndTime").val() != "") {
            	$("#time_limit").html(startTime+" 至 "+endTime);
                $("#time_limit").addClass("limit_info");
               // $("#time_limit").append('<a class="crumbDelete" onclick="ClearTime();"></a>')
            }
            else {
                $("#time_limit").removeClass("limit_info");
                $("#time_limit").html("");
                //$("#time_limit .crumbDelete").remove();
            }
            getCount(classid);
		}
		//最多选择3个分类
		function setclassid(spid,obj){
		classcount=$(".selected").length;	
		if(classcount<2){
			if($(obj).attr("class").indexOf("selected") > -1){				
				$(obj).removeClass("selected");				
			 }
			else{				
				$(obj).addClass("selected");								
			    }	
			}
		else if(classcount==2){	
			if($(obj).attr("class").indexOf("selected") == -1){
				$(obj).addClass("selected");
				$(obj).addClass("lasted");				
			 }
			else if($(obj).attr("class").indexOf("selected") > -1){
				$(obj).removeClass("selected");
				$(obj).removeClass("lasted");				
			 }
			
			}
		else if(classcount==3){
			if($(obj).attr("class").indexOf("selected") == -1){
				$("ul.spec").find(".lasted").removeClass("lasted").removeClass("selected");
				$(obj).addClass("selected");
				$(obj).addClass("lasted");				
			 }
			else if($(obj).attr("class").indexOf("selected") > -1){
				$("ul.spec").find(".lasted").removeClass("lasted");
				$(obj).removeClass("selected");
			 }
	
		   }	 
       
		}
		
		 //获取全部分类
	    function GetSpec() {
	    	var content1="";
	    	var content2="";
	    	var content3="";
	        $.ajax({
	        	
	            url: "/GetSpec",
	            type: "post",
	            async: false,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            dataType: "text",
	            data: {},
	            success: function (result) {
	                if (result != "") {
	                	
	                	var Obj=eval("("+result+")");//转换为json对象 
	                //临床医学1-3区		 
	                   for(var i=1;i<4;i++){
	                	content1+="<div class='scitem'><ul class='spec item'>";
	                	var root="区"+i;	                	               	 
			               	  //遍历json数组 
			               	  $.each(Obj[root], function(j, item) { 
			               	  content1+="<li><a id=\'"+item.i_spid+"\' class=\'"+item.i_spid+"\' onclick='selectClass("+item.i_spid+")' >"+item.s_spec+"</a></li>"; 	               
	               	  }); 
	                 	content1+="</ul></div>";
	                   }
	                   $("#clinic-content").html(content1);
	                   //基础医学4区	                   
		                	content2+="<div class='scitem'><ul class='spec item'>";
		                	var root="区4";	                	               	 
				               	  //遍历json数组 
				               	  $.each(Obj[root], function(j, item) { 
				               	  content2+="<li><a id=\'"+item.i_spid+"\' class=\'"+item.i_spid+"\' onclick='selectClass("+item.i_spid+")' >"+item.s_spec+"</a></li>"; 	               
		               	  }); 
		                 	content2+="</ul></div>";
			
	                		$("#basic_content").html(content2); //分割后的字符输出 
	                     
	                   //药学5区		                   
	                	content3+="<div class='scitem'><ul class='spec item'>";
	                	var root="区5";	                	               	 
			               	  //遍历json数组 
			               	  $.each(Obj[root], function(j, item) { 
			               	  content3+="<li><a id=\'"+item.i_spid+"\' class=\'"+item.i_spid+"\' onclick='selectClass("+item.i_spid+")' >"+item.s_spec+"</a></li>"; 	               
	               	  }); 
	                 	content3+="</ul></div>";
		
	            		$("#phar-content").html(content3); //分割后的字符输出 
                 }
	                else{ 
	                	    
	                	 alert("获取学科分类为空！") ;  
	                		
	                	} 

	            },
	            error: function () {
	                alert("获取学科分类异常！");
	                return false;
	            }
	        });
	    }

		//时间筛选
		function timeSearch() {
			GetDepartment(classid);
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

			startTime = "2008-01-01";
			var curr_time = new Date();
			endTime = curr_time.getFullYear() + "-";
			endTime += curr_time.getMonth() + 1 + "-";
			endTime += curr_time.getDate();

			$("#foot").html("<img src='/images/loading.gif'/>");
			getCount(classid);
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
			$(".spec li a").removeClass("selected");
			$("#select").html("全部学科");
			$("#foot").html("<img src='/images/loading.gif'/>");
			getCount(0);
			//GetDiscuByPage(0, pageListSize, 0, startTime, endTime);

			$("#foot").html("");
		}

		
		//分类下最新发布图书
		function getNewByClass(classid) {
			
			$.ajax({
						url : "/NewByClass",
						type : 'post',
						async : true,
						dataType : 'json',
						data: { spid:classid},
						success : function(result) {
							if (result != "") {								
								var str = "";
								for (var i = 0; i < result.length; i++) {
									str += "<li><a class=\"img\" target=\"_blank\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" title=\"\">";
									str += "<img title=\"" + result[i].s_desc + "\" alt=\"" + result[i].s_desc + "\" src=\"" + result[i].s_imgurl + "\" height=\"60\" width=\"60\"></a>";
									str += "<p class=\"name\"> <a  title=\"" + result[i].s_desc + "\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" target=\"_blank\">"
											+ result[i].s_desc.substring(0, 32)
											+ "</a></p> ";
									str += 	"<p class='lefttime'>"+result[i].s_create_time.substring(0, 10)+"</p></li>";	
								}
								
							}
							$("#latest_publish").html(str);
						},
						error : function() {
							alert("获取最新发布帖子异常，请联系管理员");
							return false;
						}
					});
		}
        
		//分类下下载次数最多图书
		function getHotByClass(classid) {
		
			$.ajax({
						url : "/HotByClass",
						type : 'post',
						async : true,
						dataType : 'json',
						data: { spid:classid},
						success : function(result) {
							if (result != "") {								
								var str = "";
								for (var i = 0; i < result.length; i++) {
									str += "<li><a class=\"img\" target=\"_blank\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" title=\"\">";
									str += "<img title=\"" + result[i].s_desc + "\" alt=\"" + result[i].s_desc + "\" src=\"" + result[i].s_imgurl + "\" height=\"60\" width=\"60\"></a>";
									str += "<p class=\"name\"> <a  title=\"" + result[i].s_desc + "\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" target=\"_blank\">"
											+ result[i].s_desc.substring(0, 32)
											+ "</a></p>";
									str += 	"<p class='lefttime'>"+result[i].s_create_time.substring(0, 10)+"</p></li>";		
								}
								$("#max_download").html(str);
							}
						},
						error : function() {
							alert("获取分类下下载次数最多异常，请联系管理员");
							return false;
						}
					});
		}
		
		//分类下最新下载图书
		function getLatestDownByClass(classid) {
		
			$.ajax({
						url : "/LatestDownByClass",
						type : 'post',
						async : true,
						dataType : 'json',
						data: { spid:classid},
						success : function(result) {
							if (result != "") {								
								var str = "";
								for (var i = 0; i < result.length; i++) {
									str += "<li><a class=\"img\" target=\"_blank\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" title=\"\">";
									str += "<img title=\"" + result[i].s_desc + "\" alt=\"" + result[i].s_desc + "\" src=\"" + result[i].s_imgurl + "\" height=\"60\" width=\"60\"></a>";
									str += "<p class=\"name\"> <a  title=\"" + result[i].s_desc + "\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" target=\"_blank\">"
											+ result[i].s_desc.substring(0, 32)
											+ "</a></p>";
									str += 	"<p class='lefttime'>"+result[i].s_create_time.substring(0, 10)+"</p></li>";
								}
								$("#latest_download").html(str);
							}
						},
						error : function() {
							alert("获取分类下最新下载异常，请联系管理员");
							return false;
						}
					});
		}
		
		
		

		//字符串转json
		function strToJson(str) {
			var json = eval('(' + str + ')');
			return json;
		}		

         function getCount(classid){
        	   	
        	 startTime = $("#StartTime").val();
    		 endTime = $("#EndTime").val();
    		
	            $.ajax({
	                url: "<%=path%>/GetCount",
	                type: 'post',
	                async: false,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'text',
	                data: {search:search,classid:classid,startTime:startTime,endTime:endTime },
	                success : function(result) {
					 
		                    if(result !=0 ){       
							var	pageTotalCount = parseInt(result);//总记录数
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
         function getClassList(classid,pageIndex){
			
        	 startTime = $("#StartTime").val();
 			 endTime = $("#EndTime").val();
 			 
		     order =$(".actived").attr("data");
		    
	            $.ajax({
	                url: "<%=path%>/ClassList",
	                type: 'post',
	                async: false,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'json',
	                data: {search:search, classid:classid,startTime:startTime,endTime:endTime,pageIndex:pageIndex,pageListSize:pageListSize,order:order },
	                success: function (result) {
	                	$("#discuList").html("");
	                	if (result != 0) {
	                	var str = "";
	                	for(var i=0;i < result.length;i++ ){
	                		
	                		str += "<div class=\"listtable\"><a title=\"" + result[i].s_desc + "\" class=\"pic\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" target=\"_blank\">";
							str += "<img title=\"" + result[i].s_desc + "\" src=\"" + result[i].s_imgurl + "\" style=\"height: 150px; width: 150px;\"><span  class=\"property\"><span class=\"bookmark\" title=\"书签\"></span></span>";
							str += "<span class=\"createTime\" style=\"display: none;\">"
									+ result[i].s_create_time
									+ "</span></a>";
							str += "<p class=\"firsttd\"><span class=\"icon pdf\"></span>";
							
						    str += "<a class=\"title\" title=\"" + result[i].s_desc + "\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" target=\"_blank\">"
										+ result[i].s_desc + "</a>";

							str += "<span class=\"listtime\">&nbsp; "+ result[i].s_create_time+ "</span></p>";
						
							str += "<p class=\"others\"><span class=\"subtitle\">资源类型："
									+ result[i].s_filetypes+"</p>";
							//str += "<p class=\"others\"><span class=\"subtitle\">发&nbsp;&nbsp;布&nbsp;&nbsp;者："
									//+ result[i].s_loginid+"</p>";
							str += "<p class=\"others\"><span class=\"subtitle\">点击次数："
									+ result[i].i_click_times
									+ "</span>&nbsp;&nbsp;&nbsp;<span class=\"subtitle\">下载次数："
									+ result[i].i_download_times + "</span></p>";

							str += "<p class=\"others\"><span class=\"subtitle\">学科分类："+ result[i].s_spec+"</span></p>";
							str += "<p><span class=\"price\">￥"
									+ result[i].i_Price
									+ "点</span>&nbsp;&nbsp;&nbsp;&nbsp;</p></div>";
						};
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
	<%@ include file="/Master/footer.jsp"%>
</body>
</html>