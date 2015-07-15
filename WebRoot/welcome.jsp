<%@page import="org.apache.struts2.ServletActionContext"%>
<%@ page language="java" 
	import="java.util.*,
		com.opensymphony.xwork2.ActionContext"
pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<meta name="description" content="">
	<meta name="author" content="">
	<link rel="icon" href="../../favicon.ico">
	
	<title>Home</title>
	
	<!-- Bootstrap core CSS -->
	<link href="css/bootstrap.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="css/jumbotron.css" rel="stylesheet">
	
	<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
	<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
	<script src="js/ie-emulation-modes-warning.js"></script>
	
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
			      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="welcome.jsp">SHUBBS</a>
		</div>
		<%
			HttpServletRequest request1 = ServletActionContext.getRequest();
			Cookie[] cookies = request1.getCookies();
			String username = null;
			String password = null;
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("username")) {
						username = cookie.getValue();
					}
					if (cookie.getName().equals("password")) {
						password = cookie.getValue();
						break;
					}
				}
			} else {
				System.out.println("We don't have user!");
			}
			
		%>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li class="active"><a href="welcome.jsp">Home</a></li>
				<li><a href="info.jsp"><%=username%></a></li>
				<li><a href="login!logout">Exit</a></li>
			</ul>
		</div>
		<!--/.navbar-collapse -->
	</div>
	</nav>

	<!-- Main jumbotron for a primary marketing message or call to action -->
	<div class="jumbotron">
		<div class="container">
			<h1>上大论坛</h1>
			<h3>这是上海大学的第一论坛</h3>
			<br /> <br /> <br /> <br />
			<!--<p><a class="btn btn-primary btn-lg" href="#" role="button">查看制作团队</a></p>-->
		</div>
	</div>

	<div class="container">
		<!-- Example row of columns -->
		<div class="row">
			<div class="col-md-4">
				<h2>校园資訊</h2>
				<p>此版块由校园官方管理，发布校园新闻、官方动态等资讯。</p>
				<p>子板块分类：校园资讯、社区学院、新生区、学生会招聘、校园专题。</p>
				<p>
					<a class="btn btn-default" href="#" role="button">進入板塊 &raquo;</a>
				</p>
			</div>
			<div class="col-md-4">
				<h2>讨论区</h2>
				<p>讨论版旨在同学们自由交流，由学生自主管理。已注册学生可以在各个子版块中发帖、回帖，对校园新闻或兴趣爱好等进行讨论。</p>
				<p>子版块：校园周边、吃喝玩乐、时政讨论、文学艺术、游戏数码、影视专区、体坛风采。</p>
				<p>
					<a class="btn btn-default" href="#" role="button">進入板塊 &raquo;</a>
				</p>
			</div>
			<div class="col-md-4">
				<h2>跳蚤市场</h2>
				<p>跳蚤市场提供学生自己的交易平台和实习招聘资讯。</p>
				<p>子版块：二手专区、兼职招聘。</p>
				<p>
					<a class="btn btn-default" href="#" role="button">進入板塊 &raquo;</a>
				</p>
			</div>
		</div>

		<hr>

		<footer>
		<p>&copy; SHUBBS</p>
		</footer>
	</div>
	<!-- /container -->


	<!-- Bootstrap core JavaScript
	    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
