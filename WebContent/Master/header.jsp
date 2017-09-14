
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    String path = request.getContextPath(); 
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%> 
<link href="<%=path %>/Css/header.css" rel="stylesheet" />
<link href="<%=path %>/Css/main.css" rel="stylesheet" />

<script  type="text/javascript" src="<%=path %>/Js/jquery-1.9.1.js" ></script>

<script type="text/javascript" src="<%=path %>/Js/header.js" ></script>



    <div class="sitetop">
        <% String username = (String)session.getAttribute("username"); 
          String uid = (String)session.getAttribute("uid");
          String account = (String)session.getAttribute("account");
		%>
        <div class="loginleft">
            <span id="username"></span>,欢迎来到MedPdf网站！
            <label style="display: none" id="tips"></label>
        </div>
        <div class="loginright">
            <span class="accountbox"><span id="accountHead"></span></span>
            <ul class="loginright_ul">
               
                <li id="center" class="dropdown" style="display: none"><a id="menuClick" href="#">个人中心</a><b class=""></b>
                    <ul id="dropdown_menu" class="dropdown_menu">
                        <li class="alt"><a href="/Center/ResourceManage">资源管理</a></li>
                        <li class="alt"><a href="/Center/AccountsDetail">账务中心</a></li>
                        <li class="alt"><a href="/ReleaseDiscu/ResourceList">发布资源</a></li>
                    </ul>
                </li>
                <li><span id="login"><a href="<%=path %>/Member/login.jsp">登&nbsp;&nbsp;录</a></span></li>
                <li><span id="regist"><a href="<%=path %>/Member/register.jsp">免费注册</a></span></li>
            </ul>
        </div>
    </div>

    <div class="header">
        <div class="logo">
            <a href="/index.jsp">
                <img src="<%=path %>/Images/logo.png" /></a>
        </div>
        <div class="search">
            <div class="searchbox">
                <input id="keys" type="text" class="search_txtbox" value="">
                <input id="search" name="search" class="searchbtn" type="button" onclick="Search();" value="搜索">
            </div>
        </div>

        <div class="clear"></div>
    </div>
   <div class="navibar" id="navibar">
            <ul>
                <li class="home"><a href="/index.jsp"><span></span>首&nbsp;&nbsp;页</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=0">全&nbsp;&nbsp;&nbsp;部</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=1">临床医学</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=2">基础医学</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=3">药&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学</a></li>
               
            </ul>
        </div>
<script type="text/javascript">


			login();  
	

       function Search(){
    	  var keys =$("#keys").val();
    	  alert(keys.length);
    	  if(keys==""){
    	      alert("搜索条件不能为空！");
    	  }
    	  else if(keys.length>36){
    		  alert("搜索条件限制在36个中文字符！")
    		  
    	  }
    	  else{
    		  var url ="http://localhost:8080/SearchList/searchlist.jsp?search="+encodeURI(keys);
        	  window.location.href =url;
    	  }
       }

       function login(){
    	   var username = "<%=username%>";
    	   var uid = "<%=uid%>";
    	   var account = "<%=account%>";
           if(username!="null"){
        	   $("#accountHead").html("账户余额：<a href='#'>"+account+"资源点</a>");
             $("#username").html("<a href="+uid+">"+username+"</a>");
             $("#login").html('<a href="<%=path%>/LoginOut">注&nbsp;&nbsp;销</a>');
           }
           else{
        	   $("#login").html('<a href="/Member/login.jsp">登&nbsp;&nbsp;录</a>');
        	   $("#username").html("游客");
           }
    	   
       }
       



</script>