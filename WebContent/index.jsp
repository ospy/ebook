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
							<li class="first">内科</li>
							<li>呼吸内科</li>
							<li>消化内科</li>
							<li>血液科</li>
							<li>心内科</li>
						</ul>
					</div>

					<div class="classify">
						<ul>
							<li class="first"></li>
							<li>神经内科</li>
							<li>内分泌</li>
							<li>风湿科</li>
							<li>老年科</li>
						</ul>
					</div>

					<div class="classify">
						<ul>
							<li class="first">外科</li>
							<li>骨科</li>
							<li>普外科</li>
							<li>神经外科</li>
							<li>泌尿外科</li>
						</ul>
					</div>

					<div class="classify">
						<ul>
							<li class="first"></li>
							<li>胸外科</li>
							<li>烧伤科</li>
							<li>心血管外科</li>
							<li></li>
						</ul>
					</div>
					<div class="classify">
						<ul>
							<li>妇产科</li>
							<li>儿科</li>
							<li>眼科</li>
							<li>耳鼻喉</li>
							<li>口腔科</li>
							<li>皮肤性病科</li>
						</ul>
					</div>
					<div class="classify">
						<ul>
							<li>肿瘤科</li>
							<li>急诊科</li>
							<li>整形美容科</li>
							<li>精神科</li>
							<li>传染科</li>
						</ul>
					</div>
					<div class="classify">
						<ul>
							<li>中医科</li>
							<li>麻醉科</li>
							<li>病理科</li>
							<li>影像科</li>
							<li>检验科</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="bioclass leftitem">
				<h2>基础医学</h2>
				<div class="leftcontent">
					<div class="classify">
						<ul>
							<li>医用高数</li>
							<li>医用物理</li>
							<li>基础化学</li>
							<li>有机化学</li>
						
						</ul>
					</div>

					<div class="classify">
						<ul>
							<li>生物化学</li>
							<li>遗传学</li>
							<li>细胞生物学</li>
							<li>组织胚胎学</li>

						</ul>
					</div>

					<div class="classify">
						<ul>	<li>解剖学</li>
							
							<li>生理学</li>
							<li>病原微生物学</li>
							<li>寄生虫学</li>


						</ul>
					</div>

					<div class="classify">
						<ul>
							<li>免疫学</li>
							<li>病理学</li>
							<li>病理生理学</li>
							<li>生物工程</li>
						
						</ul>
					</div>
					<div class="classify">
						<ul>	
							<li>医学心理学</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="drugclass leftitem">
				<h2>药学</h2>
				<div class="leftcontent">
					<div class="classify">
						<ul>
							<li>基础药学</li>
							<li>药理学</li>
							<li>药物分析</li>
							<li>药理学</li>
							<li>毒理学</li>
							
							
						</ul>
					</div>

					<div class="classify">
						<ul><li>药物鉴定</li>
							<li>药典</li>
							<li>药品</li>
							<li>天然药物学</li>
							<li>药剂学</li>

							
						</ul>
					</div>

					<div class="classify">
						<ul>
						<li>处方集</li>
							<li>药事组织</li>
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
						<li class=""><a>读书排行</a></li>
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
							class="s_type">类型</span><span class="s_right">下载豆</span></li>

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
								href="http://www.SuperSlide2.com" target="_blank"><img
									src="..//Images/focus1.png"></a></li>
							<li style="display: none;"><a
								href="http://www.SuperSlide2.com" target="_blank"><img
									src="..//Images/focus1.png"></a></li>
							<li style="display: none;"><a
								href="http://www.SuperSlide2.com" target="_blank"><img
									src="..//Images/pic3.jpg"></a></li>
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
					<ul>
						<li><a href="#">系想你想你信息</a></li>
						<li><a href="#">系想你想你信息</a></li>
						<li><a href="#">系想你想你信息</a></li>
						<li><a href="#">系想你想你信息</a></li>
						<li><a href="#">系想你想你信息</a></li>
						<li><a href="#">系想你想你信息</a></li>
						<li><a href="#">系想你想你信息</a></li>
						<li><a href="#">系想你想你信息</a></li>
						<li><a href="#">系想你想你信息</a></li>
						<li><a href="#">系想你想你信息</a></li>
					</ul>
				</div>
			</div>

			<!-- //新书速递开始 -->


			<div id="newbook" class="picScroll-left">
				<div class="hd">
					<a class="next"></a>
					<ul></ul>
					<a class="prev"></a>
					<h2>新书速递</h2>
				</div>
				<div class="bd">
					<ul class="picList">
						<%for(int i=0;i<newBooks.size();i++){  //循环显示新书start
						Map book = (Map)newBooks.get(i);				
					%>
						<li class="pic"><a href="http://www.SuperSlide2.com"
							target="_blank"> <img src="<%=book.get("s_imgurl")%>" />
						</a> <a class="title" href="<%=book.get("i_discuid") %>"
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
							href="http://www.SuperSlide2.com" target="_blank"><img
								src="<%=Download.get("s_imgurl")%>" /></a> <a class="title"
							title="总下载次数<%=Download.get("i_download_times")%>"
							href="<%=Download.get("i_discuid") %>" target="_blank">
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
						<a href=""  target="_blank"><img src='<%=newVisit.get("s_imgurl")%>' /> </a>
						<a class="title" title='<%=newVisit.get("s_desc") %>' href='<%=newVisit.get("i_discuid") %>'
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
	<%@ include file="/Master/footer.jsp"%>
</body>
</html>