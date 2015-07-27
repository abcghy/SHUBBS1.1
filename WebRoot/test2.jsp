<%@ page language="java" 
import="java.util.*,
		com.opensymphony.xwork2.ActionContext,
		org.util.HibernateSessionFactory,
		org.apache.struts2.ServletActionContext,
		org.hibernate.Session,
		org.hibernate.Query,
		java.util.List,
		org.model.Bigboard,
		org.model.Smallboard
" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<meta name="description" content="">
	<meta name="author" content="">
	<link rel="icon" href="http://v3.bootcss.com/favicon.ico">
	
	<title>Home</title>
	
	<!-- Bootstrap core CSS -->
	<link href="css/bootstrap.css" rel="stylesheet">
	
</head>
  
<body>
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
			<div id="navbar" class="navbar-collapse collapse">
				<%if(username != null) { %>
					<ul class="nav navbar-nav navbar-right">
						<li class="active"><a href="welcome.jsp">Home</a></li>
						<li><a href="info.jsp"><%=username%></a></li>
						<li><a href="login!logout">Exit</a></li>
					</ul>
				<%} else {%>
					<form class="navbar-form navbar-right">
						<div class="form-group">
							<input type="text" placeholder="Username" class="form-control">
						</div>
						<div class="form-group">
							<input type="password" placeholder="Password" class="form-control">
						</div>
						<button type="submit" class="btn btn-success">登录</button>
					</form>
				<%}%>
			</div>
		</div>
	</nav>
</body>
</html>
