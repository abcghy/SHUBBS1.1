<%@ page language="java"
import="java.util.*,
		com.opensymphony.xwork2.ActionContext,
		org.util.HibernateSessionFactory,
		org.apache.struts2.ServletActionContext,
		org.hibernate.Session,
		org.hibernate.Query,
		java.util.List,
		org.model.Bigboard,
		org.model.Smallboard,
		org.model.Userinfo"
pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
	
	<!-- Custom styles for this template -->
	<link href="css/carousel.css" rel="stylesheet">
</head>
<body>
	<%
		Session session1 = HibernateSessionFactory.getSession();
		Query query1 = session1.createQuery("from Bigboard order by biboid");
		List<Bigboard> list1 = query1.list();
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
				<%if(username != null) { %>
					<ul class="nav navbar-nav navbar-right">
						<li class="active"><a href="welcome.jsp">Home</a></li>
						<%
							Query findRoleIdQuery = session1.createQuery("from Userinfo where admin='" + username+ "'");
							List<Userinfo> findRoleIdList = findRoleIdQuery.list();
							Userinfo theUser = findRoleIdList.get(0);
							int roleId = theUser.getRoleid();
							if (roleId == 1) {
						%>
						<li><a href="dashboard.jsp">Dash</a></li>
						<%}%>
						<li><a href="info.jsp"><%=username%></a></li>
						<li><a href="login!logout">Exit</a></li>
					</ul>
				<%} else {%>
					<div class="navbar-form navbar-left">
						<a href="login.jsp#toregister"><button class="btn btn-danger">注册</button></a>
					</div>
					<form class="navbar-form navbar-right" method="post" action="login">
						<div class="form-group">
							<input type="text" placeholder="Username" name="username" class="form-control">
						</div>
						<div class="form-group">
							<input type="password" placeholder="Password" name="password" class="form-control">
						</div>
						<button type="submit" class="btn btn-success">登录</button>
					</form>
				<%}%>
			</div>
		</div>
	</nav>

	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class=""></li>
			<li data-target="#myCarousel" data-slide-to="1" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="2" class=""></li>
		</ol>
		<div class="carousel-inner" role="listbox">
			<div class="item">
				<img class="first-slide" src="images/shubg2.jpg" alt="First slide">
				<div class="container">
					<div class="carousel-caption">
						<h1>官方资讯</h1>
						<p>此版块由校园官方管理，发布校园新闻、官方动态等资讯。</p>
						<p>子板块分类：校园资讯、社区学院、新生区、学生会招聘、校园专题。</p>
					</div>
				</div>
			</div>
			<div class="item active">
				<img class="second-slide" src="images/shubg1.png" alt="Second slide">

				<div class="container">
					<div class="carousel-caption">
						<h1>上海大学</h1>
						<p>讨论版旨在同学们自由交流，由学生自主管理。已注册学生可以在各个子版块中发帖、回帖，对校园新闻或兴趣爱好等进行讨论。</p>
						<p>子版块：校园周边、吃喝玩乐、时政讨论、文学艺术、游戏数码、影视专区...</p>
					</div>
				</div>
			</div>
			<div class="item">
				<img class="third-slide" src="images/shubg3.jpg" alt="Third slide">

				<div class="container">
					<div class="carousel-caption">
						<h1>上海大学</h1>
						<p>跳蚤市场提供学生自己的交易平台和实习招聘资讯。</p>
						<p>子版块：二手专区、兼职招聘。</p>
					</div>
				</div>
			</div>
		</div>
		<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev"> 
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
		<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
	
	<div class="container">
		<%
			if (list1.size() > 0) {
				for (int i = 0; i < list1.size(); i++) {
					out.println("<table class=\"table table-striped table-bordered\">");
					out.println("<caption>" + list1.get(i).getBiBoTitle() + "</caption><tbody>");
					//看看多少个子模块，然后决定由几个<tr>
					Query query2 = session1.createQuery("select count(*) from Smallboard where biboid=" + i);
					long smallNumber = (Long) query2.uniqueResult();
					Query query3 = session1.createQuery("from Smallboard where biboid=" + i + "order by smboidid desc");
					List<Smallboard> list3 = query3.list();
					int flag = 0;
					out.println("<tr>");
					while(smallNumber > 0) {
						Query query4 = session1.createQuery("select count(*) from Posts where smboidid=" + list3.get((int)smallNumber-1).getSmBoidid());
						long postNumber = (Long) query4.uniqueResult();
						out.println("<td width=\"32.9%\" align=\"center\"><a href=\"smallBoard.jsp?aId=" + list3.get((int)smallNumber-1).getSmBoidid() + "\">" + list3.get((int)smallNumber-1).getSmBoTitle() + "</a><br/>帖子数：" + postNumber + "</td>");
						flag++;
						if (flag == 3) {
							flag = 0;
							out.println("</tr>");
						}
						smallNumber--;
					}
					if(flag != 0) {
						while(flag < 3) {
							out.println("<td width=\"32.9%\" align=\"center\">&nbsp;</td>");
							flag++;
						}
					}
					out.println("</tr></tbody><table>");
				}
			}
		%>

	<hr>

	<footer>
	<p class="pull-right">
		<a href="#">Back to top</a>
	</p>
	<p>
		&copy; SHUBBS · <a href="#">Privacy</a> · <a href="#">Terms</a>
	</p>
	</footer>
	</div>
	<!-- /container -->


	<!-- Bootstrap core JavaScript
	    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<%session1.close(); %>
</body>
</html>
