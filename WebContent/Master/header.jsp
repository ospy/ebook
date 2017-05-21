
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
        <div class="loginleft">
            <span id="guest">游客</span><label id="username"></label>,欢迎来到MedPdf网站！
            <label style="display: none" id="tips"></label>
        </div>
        <div class="loginright">
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
                <li><a href="/Classlist/classlist.jsp?classid=1">临床医学</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=2">基础医学</a></li>
                <li><a href="/Classlist/classlist.jsp?classid=3">药&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学</a></li>
                <li></li>
            </ul>
        </div>
