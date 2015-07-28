<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String temp = request.getParameter("biboid");
	int biboid = Integer.parseInt(temp);
	out.print(biboid);
%>
