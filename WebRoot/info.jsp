<%@ page language="java"
	import="java.util.*,
			org.apache.struts2.ServletActionContext,
			org.hibernate.Query,
			org.hibernate.Session,
			org.hibernate.Transaction,
			org.model.Userinfo,
			org.util.HibernateSessionFactory,
			java.text.SimpleDateFormat"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
	Session session1 = HibernateSessionFactory.getSession();
	Query query = session1.createQuery("from Userinfo where admin=\'" + username + "\'");
	List<Userinfo> list = query.list();
	Userinfo ui = list.get(0);
	String email = ui.getEmail();
	String registerDate = ui.getRegisterdate().toString();
	String userlevel = ui.getUserlevel().toString();
	String phonenumber = ui.getPhone();
	String sex = ui.getSex();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String birthdate = sdf.format(ui.getBirthdate());
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

<title>Info</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/jumbotron.css" rel="stylesheet">
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
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="welcome.jsp">Home</a></li>
				<li class="active"><a href="info.jsp"><%=username%></a></li>
				<li><a href="login!logout">Exit</a></li>
			</ul>
		</div>
		<!--/.navbar-collapse -->
	</div>
	</nav>

	<div class="container">
		<!-- Example row of columns -->
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="autoinfo">
					<div class="headimg col-md-2">
						<img src="images/headimg.gif" alt="头像" width="80" height="80" />
						<button class="btn btn-primary">修改头像</button>
					</div>
					<div class="rightinfo col-md-10" style="font-size: 20px;">
						<div class="col-md-4">
							<ul class="list-unstyled">
								<li><p class="form-control-static">
										用户名：<span style="color: deepskyblue;"><%=username%></span>
									</p></li>
								<li><p class="form-control-static">
										等级：<span style="color: deepskyblue;"><%=userlevel%></span>
									</p></li>
							</ul>
						</div>
						<div class="col-md-8">
							<ul class="list-unstyled">
								<li><p class="form-control-static">
										邮箱：<span style="color: deepskyblue;"><%=email%></span>
									</p></li>
								<li><p class="form-control-static">
										注册时间：<span style="color: deepskyblue;"><%=registerDate%></span>
									</p></li>
							</ul>
						</div>
					</div>
				</div>
				<br /> <br /> <br /> <br /> <br /> <br />
				<hr />
				<p style="text-align: center;font-family: 幼圆;font-size: 10px;">详细资料</p>
				<div class="details">
					<form class="form-horizontal" method="post" action="detailinfo">
						<div class="form-group">
							<label for="sex2" class="col-md-2 control-label">性别：</label>
							<div id="sex2" class="col-md-10">
								<div class="radio-inline">
									<label> 
										<input type="radio" name="sex" id="secret" value="保密" 
										<%
											if(sex.equals("保密")) {
												out.print("checked");
											}
										%>
										 /> 保密
									</label>
								</div>
								<div class="radio-inline">
									<label>
										<input type="radio" name="sex" id="male" value="男" 
										<%
											if(sex.equals("男")) {
												out.print("checked");
											}
										%>
										/> 男
									</label>
								</div>
								<div class="radio-inline">
									<label> 
										<input type="radio" name="sex" id="female" value="女" 
										<%
											if(sex.equals("女")) {
												out.print("checked");
											}
										%>
										/> 女
									</label>
								</div>
								<div class="radio-inline">
									<label> 
										<input type="radio" name="sex" id="else" value="其他" 
										<%
											if(sex.equals("其他")) {
												out.print("checked");
											}
										%>
										/> 其他
									</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="birthdate" class="col-md-2 control-label">出生日期：</label>
							<div class="col-md-10">
								<input type="text" name="birthdate" id="birthdate" class="form-control col-md-10" value="<%=birthdate%>"/>
							</div>
						</div>
						<div class="form-group">
							<label for="phonenumber" class="control-label col-md-2">手机号：</label>
							<div class="col-md-10">
								<input type="text" name="phonenumber" id="phonenumber" class="form-control" value="<%=phonenumber%> "/>
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-2"></div>
							<div class="col-md-10">
								<input type="submit" class="btn btn-primary" value="提交修改" />
							</div>
						</div>
					</form>
				</div>
				<hr />
				<p style="text-align: center;font-family: 幼圆;font-size: 10px;">密码设置</p>
				<div class="passwordchange">
					<form class="form-horizontal" method="post" action="changepassword">
						<div class="form-group">
							<label for="oldpassword" class="control-label col-md-2">旧密码：</label>
							<div class="col-md-10">
								<input type="password" name="oldpassword" id="oldpassword"
									class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="newpassword" class="control-label col-md-2">新密码：</label>
							<div class="col-md-10">
								<input type="password" name="newpassword" id="newpassword"
									class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="newpassword_confirm" class="control-label col-md-2">再输入新密码：</label>
							<div class="col-md-10">
								<input type="password" name="newpassword_confirm"
									id="newpassword_confirm" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-2"></div>
							<div class="col-md-10">
								<input type="submit" class="btn btn-primary" value="提交修改" />
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="col-md-2"></div>
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
