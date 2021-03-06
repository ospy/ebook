<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/Master/header.jsp"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title id="bookname"></title>

<link href="/Css/page.css" rel="stylesheet" />
<link href="/Css/bootstrap.css" rel="stylesheet" />
<link href="/Css/jquery-ui.css" rel="stylesheet" />
<link href="/Css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
<link href="/Css/Detail.css" rel="stylesheet" />
<link href="/Css/Login.css" rel="stylesheet" />


<script src="/Js/bootstrap.js"></script>
<script src="/Js/jquery-ui.js"></script>
<script type="text/javascript" src="/Js/jquery.zclip.min.js"></script>

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
	
	//script部分
           function zclip(){
                if ( window.clipboardData ) {  
                    $('.copy').click(function() { 
                        window.clipboardData.setData("Text", $(this).siblings('span.psw').text());  
                         //复制成功  
					    var $copysuc = $("<div class='copy-tips'><div class='copy-tips-wrap'>☺提取码:"+$(this).siblings('span.psw').text()+"复制成功!</div></div>");
					    $("body").find(".copy-tips").remove().end().append($copysuc);
					    $(".copy-tips").fadeOut(3000);
                    });  
                } else {  
                    $(".copy").zclip({  
                        path:'/Js/ZeroClipboard.swf',  
                        copy:function(){
                            return $(this).siblings('span.psw').text();
                        },  
                        afterCopy:function(){
                            //粘结好后暂时修改span内容
                        //复制成功  
					    var $copysuc = $("<div class='copy-tips'><div class='copy-tips-wrap'>☺提取码:"+$(this).siblings('span.psw').text()+"复制成功!</div></div>");
					    $("body").find(".copy-tips").remove().end().append($copysuc);
					    $(".copy-tips").fadeOut(3000);
                        }  
                    });  
                }  
           }
	
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
	<div class="main">
		<div class="col_left">

			<div class="left_list">
				<h3>
					<a target="_blank" href="/RankingList/DownloadRanking.aspx"></a>最新书目
				</h3>
				<ul id="latest_publish">

				</ul>
			</div>

			<div class="left_list">
				<h3>热门下载</h3>
				<ul id="max_download">
				</ul>
			</div>
			<div class="left_list">
				<h3>最近下载</h3>
				<ul id="latest_download">
				</ul>
			</div>

		</div>

		<div class="col_right">
		   <div class="book_top">
			               <h1 class="booktitle"></h1>
            <div class="pic">
                <img id="book_image" alt="" src="" width="350" height="350" >
            </div>
            <div class="book_intro_box">
                <ul id="book_intro" class="basicinfo">
                
                            <li class="col"><label>资源编号：</label><span id="discuId"></span></li>
                            <li class="col"><label>资源大小：</label><span id="volume"></span></li>
                            <li class="col"><label>资源格式：</label><span id="format"></span></li>
                            <li class="col"><label>发布日期：</label><span id="date"></span></li>
                            <li class="col2"><label>资源学科：</label><span id="speciality"></span><span id="specid"></span></li>
                            <li class="col"><label>资源页码：</label><span class="pages"></span> </li>
                            <li class="col"><label>点击次数：</label><span id="clickCount"></span></li>                                 
                            <li class="col2"><label>下载点数：</label><b class="price">￥<span class="download-price"></span></b></li>
                            <li class="col" style="visibility:hidden;"><label>下载次数：</label><span id="downCount"></span></li>
                            <li class="col2"><label>参考链接：</label><a class="referlink dangdang" onclick="goRefer(1);">当当</a><a class="referlink jd" onclick="goRefer(2);">京东</a><a class="referlink amazon" onclick="goRefer(3);">亚马逊</a><a class="referlink douban" onclick="goRefer(4);">豆瓣</a></li> 
                            
                </ul>
                <br> 
                <br>
                <br>
                <input id="downbtn" type="button" value="下载文件" onclick="checkaccount();">                   
	        </div>
	         
	    </div>
        <div id="bookabstract">
             <div id="downloadUrl" class="items">
                <div class="ItemTop"><h2>下载地址</h2><a class="folder">
<img src="/Images/icons/show.png">
</a></div>
                <div class='ItemContent'></div>
             </div>
             <div id="seriesName" class="items">
                <div class="ItemTop"><h2>丛书名</h2><a class="folder">
<img src="/Images/icons/show.png">
</a></div>
                <div class='ItemContent'></div>
             </div>
              <div id="authorName" class="items">
                <div class="ItemTop"><h2>作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;者</h2><a class="folder">
<img src="/Images/icons/show.png">
</a></div>
                <div class='ItemContent'></div>
             </div>
              <div id="authorIntro" class="items">
                <div class="ItemTop"><h2>作者简介</h2><a class="folder">
<img src="/Images/icons/show.png">
</a></div>
                <div class='ItemContent'></div>
             </div>
              <div id="contentIntro" class="items">
                <div class="ItemTop"><h2>内容简介</h2><a class="folder">
<img src="/Images/icons/show.png">
</a></div>
                <div class='ItemContent'></div>
             </div>
              <div id="contentIndex" class="items">
                <div class="ItemTop"><h2>目&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录</h2><a class="folder">
<img src="/Images/icons/show.png">
</a></div>
                <div class='ItemContent'><pre></pre></div>
             </div>
        
       
        </div>

        <div id="publishinfo">
          
           <ul>
               <li id="edition"><label>版 次：</label><span></span></li>
               <li id="impression"><label>印 次：</label><span></span></li>
               <li id="pack"><label>包 装：</label><span></span></li>               
               <li id="paper"><label>纸 张：</label><span></span></li>
               
               <li id="bookprice"><label>价格：</label><span></span></li>
               <li><label>页 数：</label><span class="pages"></span></li>
               <li id="wordNumber"><label>字 数：</label><span></span></li>               
               <li id="ISBN"><label>ISBN:</label><span></span></li>
               
               <li id="pressName"><label>出版社:</label><span></span></li>
               <li id="publishTime"><label>出版时间:</label><span></span></li>
               
               
           </ul>
        </div>


		<div class="clear"></div>

	</div>
    </div>
    
    
      <div id="myModal" class="modal  fade"  tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h2 class="modal-title">文件下载 <span id="currdate" class="currdate"></span></h2>
                </div>
                <div id="mymodal-body" class="modal-body">
                   <h2 class="booktitle"></h2>
                   <p>下载本资源需要：<span id="price" class="download-price red"></span> 下载点</p>
                   <p>当前账户余额为：<span id="account"></span> 下载点</p>
                   <br><br>
                   <p id="downtips" class="tips"></p>
                </div>
                <div class="modal-footer">
                    
                    <button type="button" id="downsubmit" class="btn btn-primary" onclick="DownloadFile()">确 定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
	
	  <div id="loginModal" class="modal  fade"  tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document" style="width: 460px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h2 class="modal-title">用户登录<span id="currdate" class="currdate"></span></h4>
                </div>
                <div id="loginmodal-body" class="modal-body">
                  
                    <form class="login-form">
						<p class="fieldset">
							<span class=title>用户名：</span> <label
								class="image-replace cd-username" for="signin-username">用户名</label>
							<input class="full-width has-padding has-border"
								id="signin-username" placeholder="输入用户名、手机号、邮箱" type="text"
								onblur="checkUserName();"> <span id="nametip"></span>
						</p>
						<p id="tip-username" class="tip red"></p>
						<p class="fieldset">
							<span class=title>密&nbsp;&nbsp;码：</span> <label
								class="image-replace cd-password" for="signin-password">密码</label>
							<input class="full-width has-padding has-border"
								id="signin-password" placeholder="输入密码" type="password"
								onblur="checkpsw();"> <span id="pwdtip"></span>
						</p>
						<p id="tip-password" class="tip red"></p>
						<p class="fieldset">
							<span class=title>验证码：</span> <input id="txt_ValidateCode"
								class="text-input validatecode" onblur="checkCode();"
								type="text">&nbsp;&nbsp;&nbsp;&nbsp;<img id="validimg" src="../code.do?name=user_reg" alt="看不清?换一张" style="cursor: pointer; vertical-align: top; font-size: 12px;"
                            onclick="this.src='../code.do?name=user_reg&id='+encodeURI(new Date());" /> <span id="codetip"></span>
						</p>
						<p id="tip-validatecode" class="tip red"></p>
						<!-- 					<p class="fieldset remember"> -->
						<!-- 						<input id="remember-me"  checked="checked" type="checkbox"> -->
						<!-- 						<label class="remember-txt">&nbsp;&nbsp;记住登录状态</label> -->
						<!-- 					</p> -->

						<p class="fieldset">
							<input id="loginbtn" class="full-width" value="登 录"
								type="button" onclick="login()">
						</p>
					</form>
                
               
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
</div>


	
	<script type="text/javascript">
	       
             getDetail();
             
             getAbstract();
           
             isDownload();
			 
			 getNewByClass();
             
			 getHotByClass();
			 
			 getLatestDownByClass();
			 		 		
			
		
		//分类下最新发布图书
		function getNewByClass() {
			var specid=$("#specid").html();
			$.ajax({
						url : "<%=path%>/NewByClass",
						type : 'post',
						async : true,
						dataType : 'json',
						data: { spid:specid},
						success : function(result) {
							if (result != "") {								
								var str = "";
								for (var i = 0; i < result.length; i++) {
									str += "<li><a class=\"img\" target=\"_blank\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" title=\"\">";
									str += "<img title=\"" + result[i].s_desc + "\" alt=\"" + result[i].s_desc + "\" src=\"" + result[i].s_imgurl + "\" height=\"60\" width=\"60\"></a>";
									str += "<p class=\"name\"> <a  title=\"" + result[i].s_desc + "\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" target=\"_blank\">"
											+ result[i].s_desc.substring(0, 40)
											+ "</a></p> </li>";
								}
								$("#latest_publish").append(str);
							}
						},
						error : function(err) {
							alert("获取最新发布文档异常，请联系管理员");
							return false;
						}
					});
		}
        
		//分类下下载次数最多图书
		function getHotByClass(spid) {
			var specid=$("#specid").html();
			$.ajax({
						url : "<%=path%>/HotByClass",
						type : 'post',
						async : true,
						dataType : 'json',
						data: { spid:specid},
						success : function(result) {
							if (result != "") {								
								var str = "";
								for (var i = 0; i < result.length; i++) {
									str += "<li><a class=\"img\" target=\"_blank\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" title=\"\">";
									str += "<img title=\"" + result[i].s_desc + "\" alt=\"" + result[i].s_desc + "\" src=\"" + result[i].s_imgurl + "\" height=\"150\" width=\"150\"></a>";
									str += "<p class=\"name\"> <a  title=\"" + result[i].s_desc + "\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" target=\"_blank\">"
											+ result[i].s_desc.substring(0, 40)
											+ "</a></p> </li>";
								}
								$("#max_download").append(str);
							}
						},
						error : function(err) {
							alert("分类下下载次数最多文档异常，请联系管理员");
							return false;
						}
					});
		}
		
		//分类下最新下载图书
		function getLatestDownByClass(spid) {
			var specid=$("#specid").html();
			$.ajax({
						url : "<%=path%>/LatestDownByClass",
						type : 'post',
						async : true,
						dataType : 'json',
						data: { spid:specid},
						success : function(result) {
							if (result != "") {								
								var str = "";
								for (var i = 0; i < result.length; i++) {
									str += "<li><a class=\"img\" target=\"_blank\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" title=\"\">";
									str += "<img title=\"" + result[i].s_desc + "\" alt=\"" + result[i].s_desc + "\" src=\"" + result[i].s_imgurl + "\" height=\"150\" width=\"150\"></a>";
									str += "<p class=\"name\"> <a  title=\"" + result[i].s_desc + "\" href=\"/Detail/detail.jsp?id=" + result[i].i_discuid + "\" target=\"_blank\">"
											+ result[i].s_desc.substring(0, 40)
											+ "</a></p> </li>";
								}
								$("#latest_download").append(str);
							}
						},
						error : function(err) {
							alert("分类下最新下载文档异常，请联系管理员");
							return false;
						}
					});
		}
		
		
		

		//字符串转json
		function strToJson(str) {
			var json = eval('(' + str + ')');
			return json;
		}		

        
		//获取图书固定信息
         function getDetail(){
        	 var bookid =$.getUrlParam('id');
        	 
	            $.ajax({
	                url: "<%=path%>/Detail",
	                type: 'post',
	                async: false,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'json',
	                data: {bookid : bookid},
	                success: function (result) {
	                	
	                	if (result != 0) {
	                		$("#book_image").attr("src",result[0].s_imgurl);
	                		$(".booktitle").html(result[0].s_desc);
	                		$("#bookname").html(result[0].s_desc);
	                		$("#discuId").html(result[0].i_discuid);
	                		$("#speciality").html(result[0].s_spec);
	                        $("#specid").html(result[0].s_specid);
	                		$("#format").html(result[0].s_filetypes);
	                		
	                		$("#downCount").html(result[0].i_download_times);
	                		$("#clickCount").html(result[0].i_click_times);
	                		
	                		$(".download-price").html(result[0].i_Price);
	                		$("#date").html(result[0].s_create_time);
	                		$("#clickCount").html(result[0].i_click_times);
			
	                	} else {
	                        $("#book_intro").html("<div class='no_record'>抱歉！没有找到符合限定条件的记录。</div>");
	                    }
	                },
	                error: function () {
	                    alert("获取书目列表异常！");
	                    return false;
	                }
	            });	 

	}

     	//获取书目摘要信息
         function getAbstract(){
        	 var bookid =$.getUrlParam('id');
        	 
	            $.ajax({
	                url: "<%=path%>/Abstract",
	                type: 'post',
	                async: false,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'json',
	                data: {bookid:bookid},
	                success: function (result) {
	                	
	                if (result != 0) {	
	                	var str="";
	                	for(var key in result[0]){
	                		
	                		if(result[0][key] !=""){
	                			switch (key) {
	                			case "seriesName":$("#seriesName .ItemContent").html(result[0].seriesName);$("#seriesName").show();
								break;
								case "authorName":$("#authorName .ItemContent").html(result[0].authorName);$("#authorName").show();
								break;
								
								case "authorIntro":$("#authorIntro .ItemContent").html(result[0].authorIntro);$("#authorIntro").show();
								break;
                                case "contentIntro":$("#contentIntro .ItemContent").html(result[0].contentIntro);$("#contentIntro").show();
								break;
								
								case "contentIndex":$("#contentIndex .ItemContent pre").html(result[0].contentIndex);$("#contentIndex").show();
								break; 
								
								
								case "edition":$("#edition span").html(result[0].edition);
								break;
								case "impression":$("#impression span").html(result[0].impression);
								break;
								case "pack":$("#pack span").html(result[0].pack);
								break;
								case "paper":$("#paper span").html(result[0].paper);
								break;
								case "price":$("#bookprice span").html(result[0].price);
								break;
								case "pages":$(".pages").html(result[0].pages);
								break;
								case "wordNumber":$("#wordNumber span").html(result[0].wordNumber);
								break;
								case "ISBN":$("#ISBN span").html(result[0].ISBN);
								break;
								case "pressName":$("#pressName span").html(result[0].pressName);
								break;
								case "publishTime":$("#publishTime span").html(result[0].publishTime);
								break;
								
								default:break;
								
	                		  }
	                		}	
	                		
	                		}
	                	
	                    }
	                else {
                        $("#bookabstract").html("<div class='no_record'>抱歉！没有找到符合限定条件的记录。</div>");
	                }
	                },
	                error: function () {
	                    alert("获取书目列表异常！");
	                    return false;
	                }
	            });	 
	
	}
         function checkaccount() {
        	 var username = '<%=username%>';
             if(username!='null'){
            	 var isdownload=isDownload();
            	 if(!isdownload){//没有下载过该文件
            		 getBalance();
                   	 
               	  $("#myModal").draggable({
                         cursor: "move",
                         handle: '.modal-header',
                     });
              	                            
               	  //modal居中  
               	  $("#myModal").modal("show");
               	  var account=$("#account").html();
               	  var price=$("#price").html();
               	  if(parseInt(account)>=parseInt(price)){
               		$("#downsubmit").attr('disabled',false);
               	  }
               	  else{
               		$("#downtips").html("账户余额不足，请充值！");
               		$("#downsubmit").attr('disabled',true);
               		$("#downsubmit").hide(); 
               	  }
            	 }
            	 else{//下载过该文件
            		 jumpto();
            	 }
            	            	  
             }
             else{            	 
            	 $("#loginModal").draggable({
                     cursor: "move",
                     handle: '.modal-header',
                 });   	                            
           	  //modal居中  
           	    $("#loginModal").modal("show");  
             }
         }
         
         
         function isDownload(){
        	 
     	    var uid="<%=uid%>";   
     	    var bookid =$.getUrlParam('id');
     	    var isdownload=false;
     	   if(uid!=""&&uid!="null"){
	            $.ajax({
	                url: "<%=path%>/IsDownload",
	                type: 'post',
	                async: false,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'json',
	                data: {Uid:uid,BookId:bookid},
	                success: function (result) {	                	
	                	if (result != "0") {
	                		var content="";
	                		for(var i in result){//遍历json数组时，这么写p为索引，0,1
	                			   j=parseInt(i)+1;
	                		       content+="<p>下载地址"+j+"：<a target=_blank href="+result[i].s_path+">"+result[i].s_path+"</a>  提取码：<span class='psw'>"+result[i].s_password+"</span> <a class='copy'>复制</a></p>";
	                			   	
	                			}
	                		$("#downloadUrl .ItemContent").empty().append(content);
	                		$("#downloadUrl").show();	                	
	                		$("#downbtn").attr("onclick","jumpto();");
	                		isdownload= true;
	                		zclip();  
	                	}
	                	else{
	                		 $("#downloadUrl .ItemContent").empty();
	                		 $("#downloadUrl").hide();
	                	}
	                },
	                error: function () {
	                    alert("获取下载历史信息异常！");
	                    return;
	                }
	            });	
	            return isdownload;
     	      }
	        }   
         
         function getBalance(){
        	 
        	    var uid="<%=uid%>";   
        	    var bookid =$.getUrlParam('id');
        	    var array =  new Array(2);
        	    if(uid!=""&&uid!="null"){
		            $.ajax({
		                url: "<%=path%>/GetAccount",
		                type: 'post',
		                async: false,
		                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		                dataType: 'text',
		                data: {Uid:uid,BookId:bookid},
		                success: function (result) {
		                	
		                	if (result != "") {
		                		
		                		$("#account").html(result);
	
		                	} else {
		                        $("#account").html("查询余额有误，请联系客服！");
		                    }
		                },
		                error: function () {
		                    alert("获取账户余额异常！");
		                    return false;
		                }
		            });	 
        	    }
        	    
	        }   
         
         function DownloadFile(){
        	 $("#myModal").modal("hide");  
     	    var uid="<%=uid%>";   
     	    var bookid =$.getUrlParam('id');
	           if(uid!=""&&uid!="null"){ 
	        	   $.ajax({
	                url: "<%=path%>/Download",
	                type: 'post',
	                async: false,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: 'json',
	                data: {uid:uid,bookid:bookid},
	                success: function (result) {
                       if (result=="-1") {                    	   
                            alert("账户余额不足，请充值！");
	                	}
                       else if (result.length!=0) {
	                		
	                		$("#accountHead a").html(result[0].newbalance);	                			                	
	                		for(var i=0;i<result.length;i++){
	                			var j=i+1;
	                		$("#downloadUrl .ItemContent").append("<p>下载地址"+j+"：<a target=_blank href="+result[i].s_path+">"+result[i].s_path+"</a>  提取码：<span class='psw'>"+result[i].s_password+"</span> <a class='copy'>复制</a></p>");
	                		
	                		}	                		
	                		$("#downloadUrl").show();
	                		zclip();
	                		             		
	                	} else {
	                        $("#account").html("下载文件时发生异常！请您联系管理员：imed120@163.com");
	                    }
                       window.location.reload();
	                },
	                error : function(XMLHttpRequest, textStatus) {
						alert(XMLHttpRequest.status);  
                    	alert(XMLHttpRequest.readyState);  
                    	alert(textStatus);
                    	$("#account").html("下载文件时发生异常！请您联系管理员：imed120@163.com");
					}
	             });	 
	           }
	        }   
         function jumpto() {

             /*实现页内跳转*/
             var _targetTop = $("#downloadUrl").offset().top-50;//获取位置
             jQuery("html,body").animate({ scrollTop: _targetTop }, 100);//跳转


         };
	</script>
	
	<script type="text/javascript">
	//用户登录
	var state1 = false;
	var state2 = false;
	var state3 = false;
	function checkUserName() {
		var name = $("#signin-username").val();
		if (name == "" || name == null) {
			$("#tip-username").removeClass("onCorrect").addClass("onError")
					.html("不可为空！");
		} else {
			$("#tip-username").removeClass("onError").addClass("onCorrect")
					.html("");
			state1 = true;
		}

	}

	function checkpsw() {

		var pwd = $("#signin-password").val();
		if (pwd == "" || pwd == null) {

			$("#tip-password").removeClass("onCorrect").addClass("onError")
					.html("不可为空！");
		} else {
			$("#tip-password").removeClass("onError").addClass("onCorrect")
					.html("");
			state2 = true;
		}

	}

	function checkCode() {
		var v_code = $("#txt_ValidateCode").val();
		if (v_code == "" || v_code == null) {
			$("#tip-validatecode").removeClass("onCorrect").addClass("onError")
					.html("不可为空！");
			check3 = false;
			
		}
		// var ver_code = getCookie("VCode").toLowerCase();
		var ver_code;
		$.ajax({
			url : "../code.do",
			type : 'post',
			async : false,
			dataType : 'text',
			data : {
				name : 'user_reg'
			},
			success : function(data) {
				ver_code = data;
			},
			error : function() {
				alert("获取验证码失败，请联系管理员");
			}
		});

		if (ver_code == v_code.toLowerCase()) {
			$("#tip-validatecode").addClass("onCorrect").html("");
			state3 = true;
		} else {
			$("#tip-validatecode").removeClass("onCorrect").addClass("onError")
					.html("验证码输入有误！");
			state3 = false;
		}
	}
	
	function login(){
		 checkUserName() ;
		 checkpsw();
		 checkCode();
		 var url = window.location.href;
		 if(state1&&state2&&state3){
			 var uName = $("#signin-username").val();
	         var pwd = $("#signin-password").val();
	            $.ajax({
	                url: "<%=path%>/UserLogin",
	                type: 'post',
	                async: false,
	                dataType: 'text',
	                data: { uName: uName, pwd: pwd,url:url},
	                success: function (result) {
	                    if (result == 1) {
	                    	  window.location.reload();
	                    } else {
	                    	$("#tip-username").removeClass("onCorrect").addClass("onError").html("用户名或密码错误！");
	                        $("#tip-password").removeClass("onCorrect").addClass("onError").html("用户名或密码错误！");
	                        $('#validimg').attr("src",'../code.do?name=user_reg&id='+encodeURI(new Date()));
	                    }
	                },
	                error: function () {
	                    alert("用户登录异常，请联系管理员");
	                    return;
	                }
	            });	 
		 }
		 else{
			 return;
			 
		 }
	
	}

    //折叠菜单
    $(".folder").click(function () {

        var control = $(this).parent().siblings(".ItemContent");
        //control.slideToggle();
        if (control.css("display") == "block") {

            control.css("display", "none");
            $(this).children("img").attr("src", "/Images/icons/hide.png");

        } else {

            control.css("display", "block");
            $(this).children("img").attr("src", "/Images/icons/show.png");
        };
    });
	function goRefer(key){
	    var title=$("h1.booktitle").html();
		switch (key) {
		case 1:
			var url="http://search.dangdang.com/?key="+title+"&rd_flag=noresult";
	        window.open(url);
			break;
		case 2:
			var url="http://search.jd.com/Search?keyword="+title+"&enc=utf-8";
            window.open(url);
			break;
		case 3:
			var url="http://www.amazon.cn/gp/search/ref=sr_hi_2?&keywords="+title;
	        window.open(url);
	        break;
		case 4:
			var url="https://book.douban.com/subject_search?search_text="+title;
	        window.open(url);
	        break;
		default:
			break;
		}
	}
</script>
<script>
//百度自动收录
(function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https') {
        bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';
    }
    else {
        bp.src = 'http://push.zhanzhang.baidu.com/push.js';
    }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>
<script>
//360自动收录
(function(){
var src = (document.location.protocol == "http:") ? "http://js.passport.qihucdn.com/11.0.1.js?bff6f99cac950f127c9c635467ce528c":"https://jspassport.ssl.qhimg.com/11.0.1.js?bff6f99cac950f127c9c635467ce528c";
document.write('<script src="' + src + '" id="sozz"><\/script>');
})();
</script>
<%@ include file="/Master/footer.jsp"%>
</body>
</html>