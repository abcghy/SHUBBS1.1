<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>错误</title>
	<link rel="stylesheet" type="text/css" href="css/error.css">
	</head>
  
	<body>
		<section class="pen">
			<div class="panel top">
				<div class="title"><h1>你兩次輸入的密碼不相同</h1></div>
			</div>
			<div class="panel bottom">
				<div class="back"><h1><a href="javascript:history.back(-1)">返回</a></h1></div>
				<div class="scroll"></div>
			</div>
		</section>  
	</body>
</html>
