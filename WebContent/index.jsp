<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ebook.index.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<script type="text/javascript"
	src="<%=path%>/Js/jquery.SuperSlide.2.1.1.source.js"></script>
<link type="text/css" rel="stylesheet" href="<%=path%>/Css/index.css" />
</head>
<%
List newBooks = IndexService.getNewBooks();//1.新书速递
List hotDownloads = IndexService.getHotDownload();//2.热门下载
List newVisits = IndexService.getNewVisit();//3.最近访问
System.out.println(newVisits.size());
List newRegisters = IndexService.getNewRegister();//1.最新注册
List NewAccounts = IndexService.getNewAccount();//2.账户变化
List topDownloads = IndexService.getTopDownload();//3.下载排行
%>
<body>
	<div class="main">
		<div class="leftbox">
			<div class="medclass leftitem">
				<h2>临床医学</h2>
				<div class="leftcontent">
					<div class="classify">
						<ul>
							<li class="first"><a  target="blank" href="/Classlist/classlist.jsp?classid=1000">内科</a></li>
							<li ><a  target="blank" href="/Classlist/classlist.jsp?classid=1001">呼吸内科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=1002">消化内科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=1003">神经内科</a></li>
							<li ><a  target="blank" href="/Classlist/classlist.jsp?classid=1004">心血管内科</a></li>
							
						</ul>
					</div>

					<div class="classify">
						<ul>
							<li class="first"></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=1005">血液科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=1006">肾内科</a></li>
							
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=1007">内分泌</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=1008">风湿免疫科</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=1010">老年科</a></li>
						</ul>
					</div>

					<div class="classify">
						<ul>
							<li class="first"> <a  target="blank" href="/Classlist/classlist.jsp?classid=2000">外科</a></li>
							
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=2001">普外科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=2002">神经外科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=2003">骨科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=2004">泌尿外科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=2005">胸外科</a></li>
						</ul>
					</div>

					<div class="classify">
						<ul>
							<li class="first"></li>
							
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=2006">心血管外科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=2007">烧伤科</a></li>

						</ul>
					</div>
					<div class="classify">
						<ul>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=3100">妇产科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=3200">儿科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=3300">眼科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=3400">耳鼻喉</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=3500">口腔科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=3600">皮肤性病科</a></li>
						</ul>
					</div>
					<div class="classify">
						<ul>
							
							
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=3700">整形美容科</a></li>
							
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=3800">传染科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=3900">肿瘤科</a></li>
							
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4000">急诊科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4100">重症医学科</a></li>
						</ul>
					</div>
					<div class="classify">
						<ul>
						<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4200">康复医学科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4300">运动医学科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4400">职业病科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4500">特种医学科</a></li>
							
						</ul>
					</div>
					<div class="classify">
						<ul>
						<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4600">麻醉科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4700">疼痛科</a></li>
						<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4800">精神科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=4900">中医科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=5000">中西医结合科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=5100">护理学</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=5200">检验科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=5300">病理科</a></li>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=5400">影像科</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="bioclass leftitem">
				<h2>基础医学</h2>
				<div class="leftcontent">
					<div class="classify">
						<ul>
							<li> <a  target="blank" href="/Classlist/classlist.jsp?classid=6000">医用高数</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=6100">医用物理</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=6200">基础化学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=6300">有机化学</a></li>
						 <li><a  target="blank" href="/Classlist/classlist.jsp?classid=6400">解剖学</a></li>
						</ul>
					</div>

					<div class="classify">
						<ul>
						   
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=6500">生物化学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=6600">遗传学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=6700">细胞生物学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=6800">组织胚胎学</a></li>
                            <li><a  target="blank" href="/Classlist/classlist.jsp?classid=7300">免疫学</a></li>
						</ul>
					</div>

					<div class="classify">
						<ul>	
							
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=6900">生物工程</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=7000">生理学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=7100">病原微生物学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=7200">寄生虫学</a></li>
                            
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=7400">病理学</a></li>
                            <li><a  target="blank" href="/Classlist/classlist.jsp?classid=7500">病理生理学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=7600">医学心理学</a></li>
						</ul>
					</div>

					<div class="classify">
						<ul>
							
							
						
						</ul>
					</div>

				</div>
			</div>
			<div class="drugclass leftitem">
				<h2>药学</h2>
				<div class="leftcontent">
					<div class="classify">
						<ul>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9000">基础药学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9001">药物分析</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9002">药典</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9003">处方集</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9004">药物鉴定</a></li>
							
							
						</ul>
					</div>

					<div class="classify">
						<ul><li><a  target="blank" href="/Classlist/classlist.jsp?classid=9005">天然药物</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9006">药剂学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9007">药事组织</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9008">药理学</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9009">药品</a></li>
							<li><a  target="blank" href="/Classlist/classlist.jsp?classid=9010">毒理学</a></li>

							
						</ul>
					</div>


				</div>

			</div>
			<div class="dynanmic leftitem slideTxtBox" id="leftTabBox">
				<h2>用户动态</h2>

				<div class="hd">
					<ul>
						<li class="on"><a>最新注册</a></li>
						<li class=""><a>账户变化</a></li>
						<li class=""><a>阅读排行</a></li>
					</ul>
				</div>

				<div class="bd">

					<ul class="dyn">
						<li class="dyntitle"><span>用户名</span><span class="s_right">注册时间</span></li>

						<%for(int i=0;i<newRegisters.size();i++){  //循环显示新书start
						Map newRegister = (Map)newRegisters.get(i);				
					%>
						<li class="dyncontent"><span> <%=newRegister.get("s_loginid")%></span>
							<span class="s_right"><%=newRegister.get("s_create_time").toString().substring(5, 10) %></span>

						</li>
						<%}%>

					</ul>
					<ul>
						<li class="dyntitle"><span class="s_loginid">用户名</span><span
							class="s_type">类型</span><span class="s_right">下载点</span></li>

						<%for(int i=0;i<NewAccounts.size();i++){  //循环显示新书start
						Map Account = (Map)NewAccounts.get(i);				
					%>

						<li><span class="s_loginid"><%=Account.get("s_loginid") %></span>
							<span class="s_type"><%=Account.get("s_type") %></span> <span
							class="s_value"><%=Account.get("i_value") %></span></li>
						<%} %>
					</ul>
					<ul>
						<li class="dyntitle"><span class="s_loginid">用户名</span><span
							class="s_right">下载数</span></li>

						<%for(int i=0;i<topDownloads.size();i++){  //循环显示新书start
						Map topDownload = (Map)topDownloads.get(i);				
					%>

						<li><span class="s_loginid"><%=topDownload.get("s_loginid") %></span>

							<span class="s_right"><%=topDownload.get("count") %></span></li>
						<%} %>
					</ul>
				</div>
				<script type="text/javascript">
					jQuery("#leftTabBox").slide({});
				</script>
			</div>
		</div>
		<div class="mainbox">
			<div class="topmain">

				<div id="focus" class="slideBox">
					<div class="hd">
						<ul>
							<li class="on">1</li>
							<li class="">2</li>
							<li class="">3</li>
						</ul>
					</div>
					<div class="bd">
						<ul>
							<li style="display: list-item;"><a
								href="#" target="_blank"><img
									src="/Images/focus1.png"></a></li>
							<li style="display: none;"><a
								href="#" target="_blank"><img
									src="/Images/focus1.png"></a></li>
							<li style="display: none;"><a
								href="#" target="_blank"><img
									src="./Images/focus1.png"></a></li>
						</ul>
					</div>

					<!-- 下面是前/后按钮代码，如果不需要删除即可 -->
					<a class="prev" href="javascript:void(0)"></a> <a class="next"
						href="javascript:void(0)"></a>

				</div>

				<script id="jsID" type="text/javascript">
					var ary = location.href.split("&amp;");
					jQuery(".slideBox").slide({
						mainCell : ".bd ul",
						effect : ary[1],
						autoPlay : ary[2],
						trigger : ary[3],
						easing : ary[4],
						delayTime : ary[5],
						mouseOverStop : ary[6],
						pnLoop : ary[7]
					});
				</script>

				<div class="news">
					<h2>News</h2>
					<ul id="news">

					</ul>
				</div>
			</div>

			<!-- //新书速递开始 -->


			<div id="newbook" class="picScroll-left">
				<div class="hd">
					<a class="next"></a>
					<ul></ul>
					<a class="prev"></a>
					<h2>最新上传</h2>
				</div>
				<div class="bd">
					<ul class="picList">
						<%for(int i=0;i<newBooks.size();i++){  //循环显示新书start
						Map book = (Map)newBooks.get(i);				
					%>
						<li class="pic"><a title="上传时间<%=book.get("s_create_time") %>" href="/Detail/detail.jsp?id=<%=book.get("i_discuid") %>"
							target="_blank"> <img src="<%=book.get("s_imgurl")%>" />
						</a> <a class="title" href="/Detail/detail.jsp?id=<%=book.get("i_discuid") %>"
							target="_blank">
								<%if(book.get("s_desc").toString().length()>16){
									out.println(book.get("s_desc").toString().substring(0, 16));
									
								} 
								else{
									out.println(book.get("s_desc"));
									
								}%>
						</a></li>
						<%}   //循环显示新书end %>
					</ul>
				</div>
			</div>
			<script type="text/javascript">
				jQuery("#newbook").slide({
					titCell : ".hd ul",
					mainCell : ".bd ul",
					autoPage : true,
					effect : "left",
					vis : 5,
					scroll : 5,
					pnLoop : "false"
				});
			</script>

			<!--  //热门下载开始 -->
			<div id="hotdown" class="picScroll-left">
				<div class="hd">
					<a class="next"></a>
					<ul></ul>
					<a class="prev"></a>
					<h2>热门下载</h2>
				</div>
				<div class="bd">
					<ul class="picList">
						<% for(int i=0;i<hotDownloads.size();i++){  //循环显示热门下载start
						Map Download = (Map)hotDownloads.get(i);				
					%>
						<li class="pic"><a
							title="总下载次数<%=Download.get("i_download_times")%>"
							href="/Detail/detail.jsp?id=<%=Download.get("i_discuid") %>" target="_blank"><img
								src="<%=Download.get("s_imgurl")%>" /></a> <a class="title"
							title="总下载次数<%=Download.get("i_download_times")%>"
							href="/Detail/detail.jsp?id=<%=Download.get("i_discuid") %>" target="_blank">
								<%if(Download.get("s_desc").toString().length()>16){
									out.println(Download.get("s_desc").toString().substring(0, 16));
									
								} 
								else{
									out.println(Download.get("s_desc"));
									
								}%>
						</a></li>
						<%}  //循环显示热门下载end %>

					</ul>
				</div>
			</div>
			<script type="text/javascript">
				jQuery("#hotdown").slide({
					titCell : ".hd ul",
					mainCell : ".bd ul",
					autoPage : true,
					effect : "left",
					vis : 5,
					scroll : 5,
					pnLoop : "false"
				});
			</script>

			<!-- recommand开始 -->
			<div id="recommand" class="picScroll-left">
				<div class="hd">
					<a class="next"></a>
					<ul></ul>
					<a class="prev"></a>
					<h2>最近访问</h2>
				</div>
				<div class="bd">
					<ul class="picList">
						<%for(int i=0;i<newVisits.size();i++){ 
						Map newVisit = (Map)newVisits.get(i);				
					%>
						<li class="pic">
						<a title="访问时间<%=newVisit.get("s_create_time")%>" href="/Detail/detail.jsp?id=<%=newVisit.get("i_discuid") %>"  target="_blank"><img src='<%=newVisit.get("s_imgurl")%>' /> </a>
						<a class="title" title='<%=newVisit.get("s_desc") %>' href="/Detail/detail.jsp?id=<%=newVisit.get("i_discuid") %>"
							target="_blank"><%=newVisit.get("s_desc") %></a></li>
						<%} %>
					</ul>
				</div>
			</div>
			<script type="text/javascript">
				jQuery("#recommand").slide({
					titCell : ".hd ul",
					mainCell : ".bd ul",
					autoPage : true,
					effect : "left",
					vis : 5,
					scroll : 5,
					pnLoop : "false"
				});
			</script>

		</div>

	</div>
	<script>
	
	getnews();
	
	function getnews() {
		var uid="<%=uid%>";
 	   $.ajax({
           url: "<%=path%>/News",
           type: 'post',
           async: false,
           contentType: "application/x-www-form-urlencoded; charset=UTF-8",
           dataType: 'json',
           data: {uid:uid},
           success: function (result) {
           	
           	if (result!= "") {
           		var str="";
           		for(var i=0;i<result.length;i++){
        			
            		str+="<li><a title="+result[i].title+" target=_blank href='/News/newsdetail.jsp?id="+result[i].id+"'>"+result[i].title.substring(0,14)+"</a><span title="+result[i].datetime.substring(0,10)+">"+result[i].datetime.substring(5,10)+"</span></li>";
            		
            		}
           		$("#news").html(str);
           	} 
           },
           error: function () {
               alert("获取新闻异常！");
               return false;
           }
        });	
		
	}
	</script>
	<%@ include file="/Master/footer.jsp"%>
</body>
</html>