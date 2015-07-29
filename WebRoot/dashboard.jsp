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
		org.model.Userinfo,
		org.util.Time"
	pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="http://v3.bootcss.com/favicon.ico">

<title>Dashboard Template for Bootstrap</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/dashboard.css" rel="stylesheet">
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
		if(username == null) {
			response.sendRedirect(basePath+"login!login");
		}
	%>
	<%
		String function = request.getParameter("func");
		if (function == null) {
			function = "module";
		}
	%>
	<%Session session1 = HibernateSessionFactory.getSession(); %>
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
			<form class="navbar-form navbar-right" method="post" action="login">
				<div class="form-group">
					<input type="text" placeholder="Username" name="username"
						class="form-control">
				</div>
				<div class="form-group">
					<input type="password" placeholder="Password" name="password"
						class="form-control">
				</div>
				<button type="submit" class="btn btn-success">登录</button>
			</form>
			<%}%>
		</div>
	</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li <%if (function.equals("module")) out.print("class=\"active\"");%>><a href="dashboard.jsp?func=module">板块</a></li>
					<li <%if (function.equals("post")) out.print("class=\"active\"");%>><a href="dashboard.jsp?func=post">帖子</a></li>
					<li <%if (function.equals("user")) out.print("class=\"active\"");%>><a href="dashboard.jsp?func=user">用户</a></li>
				</ul>
			</div>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 style="font-family: 'Hiragino Sans GB';">欢迎来到控制台</h1>
				<%if (function.equals("module")) { %>
				<div class="left-look col-md-5">
					<h2 class="sub-header">版块一览</h2>
						<div class="table-responsive">
						<%
							Query bigBoardQuery = session1.createQuery("from Bigboard");
							List<Bigboard> bigBoardList = bigBoardQuery.list();
							for (int i = 0; i < bigBoardList.size(); i++) {
								Bigboard theBigBoard = bigBoardList.get(i);
						%>
						<table class="table table-striped table-bordered table-hover">
							<caption>父板块：<%=theBigBoard.getBiBoTitle()%></caption>
							<thead>
								<tr>
									<th class="col-md-4">子版块</th>
									<th class="col-md-4">id</th>
									<th class="col-md-4">帖子数</th>
								</tr>
							</thead>
							<tbody>
							<%
								Query biBoFindSmBoQuery = session1.createQuery("from Smallboard where biboid=" + theBigBoard.getBiBoid());
								List<Smallboard> biBoFindSmBoList = biBoFindSmBoQuery.list();
								for (int j = 0; j < biBoFindSmBoList.size(); j++) {
									Smallboard theSmallBoard = biBoFindSmBoList.get(j);
									Query smBoFindPostNumQuery = session1.createQuery("select count(*) from Posts where smboidid=" + theSmallBoard.getSmBoidid());
									long howManyPosts = (Long) smBoFindPostNumQuery.uniqueResult();
							%>
								<tr>
									<td><%=theSmallBoard.getSmBoTitle()%></td>
									<td><%=theSmallBoard.getSmBoidid()%></td>
									<td><%=howManyPosts%></td>
								</tr>
							<%} %>
							</tbody>
						</table>
						<%} %>
					</div>
				</div>
				
				<div class="right-look col-md-6">
					<h2 class="sub-header">添加板块</h2>
					<form action="addModule" method="post">
						<label for="biboidaddmo">父板块：</label>
						<select class="form-control" name="biboid" id="biboidaddmo">
							<%
							for (int i = 0; i < bigBoardList.size(); i++) { 
								Bigboard theBigBoard = bigBoardList.get(i);
							%>
								<option value="<%=theBigBoard.getBiBoid()%>"><%=theBigBoard.getBiBoTitle()%></option>
							<%} %>
						</select><br/>
						<label for="smbotitleaddmo">新添板块名称:</label>
						<input name="smbotitle" id="smbotitleaddmo" type="text" class="form-control"/><br/>
						<input type="submit" value="添加板块" class="btn btn-info"/>
					</form>
				</div>
				
				<div class="right-look col-md-6">
					<h2 class="sub-header">删除板块</h2>
					<form action="deleteModule" method="post">
						<%-- <label for="biboiddelmo">父板块：</label>
						<select class="form-control" name="biboid" id="biboiddelmo" onchange="showSmBoId(this.value)">
							<option value="">---请选择---</option>
							<%
							for (int i = 0; i < bigBoardList.size(); i++) { 
								Bigboard theBigBoard = bigBoardList.get(i);
							%>
								<option value="<%=theBigBoard.getBiBoid()%>"><%=theBigBoard.getBiBoTitle()%></option>
							<%} %>
						</select> --%>
						<label for="smboididdelmo">子版块：</label>
						<select class="form-control" name="smboidid" id="smboididdelmo">
							<!-- <option value="">---请先选择父板块---</option> -->
							<%
								Query smQuery = session1.createQuery("from Smallboard");
								List<Smallboard> smList = smQuery.list();
								for (int i = 0; i < smList.size(); i++) {
									Smallboard theSM = smList.get(i);
							%>
							<option value="<%=theSM.getSmBoidid()%>"><%=theSM.getSmBoTitle()%></option>
							<%} %>
						</select><br/>
						<input type="submit" value="删除板块" class="btn btn-danger" /><br/>
						<div class="alert alert-danger" role="alert">
							<span>↑请勿随便按下，而且只能删除没有帖子的板块</span>
						</div>
						
					</form>
				</div>
				
				<%} else if (function.equals("post")) { %>
					<h2 class="sub-header">帖子管理</h2>
					<div class="jumbotron">
						<h2>暂时放在论坛页面管理，这样比较快捷</h2>
					</div>
				<%} else if (function.equals("user")) { %>
					<h2 class="sub-header">用户管理</h2>
					<%
						Query userQuery = session1.createQuery("from Userinfo");
						List<Userinfo> userList = userQuery.list();
					%>
					<p>共有<span style="color: red;"><%=userList.size()%></span>条记录</p>
					<table class="table table-bordered table-striped table-hover">
						<thead>
							<tr>
								<th>操作</th>
								<th>用户名</th>
								<th>邮箱</th>
								<th>性别</th>
								<th>出生日期</th>
								<th>电话</th>
								<th>等级</th>
								<th>注册时间</th>
							</tr>
						</thead>
						<tbody>
						<%
							for (int i = 0; i < userList.size(); i++) {
								Userinfo theUI = userList.get(i);
						%>
							<tr>
								<td><input type="button" class="btn btn-danger delete" value="删除"/></td>
								<td class="username"><%=theUI.getAdmin()%></td>
								<td><%=theUI.getEmail()%></td>
								<td><%=theUI.getSex()%></td>
								<td><%if(theUI.getBirthdate() == null) {
									out.print(theUI.getBirthdate());
								} else {
									out.print(Time.format(theUI.getBirthdate()));
								}%></td>
								<td><%=theUI.getPhone()%></td>
								<td><%=theUI.getUserlevel()%></td>
								<td><%=Time.fullFormat(theUI.getRegisterdate())%></td>
							</tr>
						<%} %>
						</tbody>
					</table>
				<%} %>
				

			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript
	    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".delete").click(function() {
				var xmlhttp;
				xmlhttp = new XMLHttpRequest();
				var username = $(this).parent().next().text();
				xmlhttp.open("get", "userdel.jsp?username="+username, true);
				xmlhttp.send();
				setTimeout(location.reload(true), 2000);
			});
		});
	</script>
	
	<%session1.close(); %>
</body>
</html>
