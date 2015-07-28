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
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	
	<title>My JSP 'Test2.jsp' starting page</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<%
		Session session1 = HibernateSessionFactory.getSession();
		Query bigBoardQuery = session1.createQuery("from Bigboard");
		List<Bigboard> bigBoardList = bigBoardQuery.list();
	%>
	
	<select id="bigboard" onchange="showSmallBoard(this.value)">
		<option value="">---请选择---</option>
		<%
			for (int i = 0; i < bigBoardList.size(); i++) {
				Bigboard theBigBoard = bigBoardList.get(i);
		%>
		<option value="<%=theBigBoard.getBiBoid()%>"><%=theBigBoard.getBiBoTitle()%></option>
		<%} %>
	</select>
	
	<select id="smallboard">
		<option value="">---请先选择父板块---</option>
	</select>
	<br/>
	<div id="texthint">nicai</div>
	
	
	<script src="js/jquery.min.js"></script>
	<script type="text/javascript">
		function showSmallBoard(str) {
			var xmlhttp;
			xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					document.getElementById("txthint").innerHTML = xmlhttp.responseText;
				}
			}
			xmlhttp.open("get", "Test/Test3.jsp?biboid=" + str, true);
			xmlhttp.send();
		}
	</script>
	
</body>
</html>
