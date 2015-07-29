<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title>My JSP 'demo.jsp' starting page</title>
<body>
	<td class="thread">
		<a href="post.jsp?pId=202">第一次试验</a>
		<button class="btn btn-danger delpost">删</button>
	</td>
	<script src="js/jquery.min.js"></script>
	<script type="text/javascript">
		
	</script>
</body>
</html>
