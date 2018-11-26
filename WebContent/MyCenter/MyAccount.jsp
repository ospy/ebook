<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的账户</title>

<link type="text/css" rel="stylesheet" href="../Css/jquery-ui.css"/>
<link type="text/css" rel="stylesheet" href="../Css/myresource.css"/>
<link href="/Css/page.css?v=20180312" rel="stylesheet" />
<script type="text/javascript" src="/Js/jquery-ui.min.js"></script>
<script src="/Js/jquery.MyAccountPagination.js"></script>
</head>
<body>
   <div class="listcontent">
				<div class="location">
					共找到&nbsp;<span id="total" style="color: red"></span>&nbsp;条记录</div>
				</div>
				<div id="AccountList" class="main" style="height: auto;">
				</div>
				   
				<div id="Pager" style="width: 800px;margin: 0 auto;"></div>
			</div>
</body>
 <script>
  var uid="<%=uid%>";       	
	 var totalPage = 0;
	var pageListSize = 10;//每页显示调试
         getCount();
   		//字符串转json
		function strToJson(str) {
			var json = eval('(' + str + ')');
			return json;
		}		

         function getCount(){
        	 
        	 if(uid!=""&&uid!="null"){
	            $.ajax({
	                url: "<%=path%>/AccountCount",
	                type: 'post',
	                async: true,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'text',
	                data: {Uid:uid },
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
                    	$("#AccountList").html("<div class='no_record'>抱歉！没有找到符合限定条件的记录。</div>");
                    	$("#Pager").hide();
                          }	                		                	
						
						},
	                error: function () {
	                    alert("获取记录总数异常！");
	                    return false;
	                }
	            });	 
        	 }
        	 else{
        		 
        		 window.location.href="/Member/login.jsp";
        	 } 
         }
		//获取已下载列表
         function AccountList(pageIndex, pageListSize){
        	 var uid="<%=uid%>"; 
        	 
		    
	            $.ajax({
	                url: "<%=path%>/GetAccountList",
	                type: 'post',
	                async: false,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'json',
	                data: {Uid:uid,pageIndex:pageIndex,pageListSize:pageListSize},
	                success: function (result) {
	                	$("#AccountList").html("");
	                	if (result != 0) {
	                	var str = "<table><tr style='line-height:30px;background: #f6f6f6;'><td style='width:10%;text-align:center;'>类型</td><td style='width:40%;text-align:center;'>备注</td><td style='width:10%;text-align:center;'>使用前</td><td style='width:10%;text-align:center;'>变动</td><td style='width:10%;text-align:center;'>使用后</td><td style='width:20%;text-align:center;'>下载时间</td></tr>";
	                	for(var i=0;i < result.length;i++ ){
	                		var type=changeType(result[i].s_type);
	                		str += "<tr><td align='middle'>"+type+"</td>";
	                		str += "<td><a title='" +result[i].s_desc+ "' href='/Detail/detail.jsp?id=" + result[i].i_discuid + "' target='_blank'>"+ result[i].s_desc +"</a>" +result[i].s_message+"</td>";
	                		str += "<td align='middle'>"+result[i].i_old_value+"</td>";
	                		str += "<td align='middle'>"+result[i].i_value+"</td>";
	                		str += "<td align='middle'>"+result[i].i_new_value+"</td>";
	                		str += "<td align='middle' class=\"createTime\">"+ result[i].s_create_time+"</td>";
	
						}
	                	str += "</tr></table>";
						$("#AccountList").html(str);
						 SetTableRowColor();  
	                	} else {
	                        $("#AccountList").html("<div class='no_record'>抱歉！没有找到符合限定条件的记录。</div>");
	                    }
	                },
	                error: function () {
	                    alert("获取书目列表异常！");
	                    return false;
	                }
	            });	 
		 

	
	}
       //用CSS控制奇偶行的颜色    
         function changeType(type)    
         {    
        	 switch(type)
        	 {
        	 case "1":
        	 return "用户注册";
        	   break;
        	 case "2":
        	return "注册赠送";
        	   break;
        	 case "3":
        	   return "管理员添加";
        	   break;
        	 case "4":
          	   return "管理员减少";
          	   break;
        	 case "5":
            	   return "下载文件";
            	   break;
        	 case "6":
            	   return "微信支付";
            	   break;
        	 case "7":
            	   return "微信支付";
            	   break;
        	 case "8":
          	       return "奖励赠送";
          	       break;
        	 default:
        		 return type;
        	   
        	 }  
         }   
		
       //用CSS控制奇偶行的颜色    
         function SetTableRowColor()    
         {    
             
             $("#downloadList table tr:odd").css("background-color", "#f6f6f6");    
             $("#downloadList table tr:even").css("background-color", "#fff");    
         }   
  </script>
</html>