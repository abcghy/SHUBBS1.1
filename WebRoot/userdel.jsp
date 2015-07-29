<%@page import="org.hibernate.Transaction"%>
<%@ page language="java" import="java.util.*,
		com.opensymphony.xwork2.ActionContext,
		org.util.HibernateSessionFactory,
		org.apache.struts2.ServletActionContext,
		org.hibernate.Session,
		org.hibernate.Query,
		java.util.List,
		org.model.Bigboard,
		org.model.Smallboard,
		org.model.Userinfo,
		org.util.Time" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String username = request.getParameter("username");
	Session session1 = HibernateSessionFactory.getSession();
	Query findUserQuery = session1.createQuery("from Userinfo where admin='" +username+"'");
	List<Userinfo> findUserList = findUserQuery.list();
	if (findUserList.size() > 0) {
		Userinfo ui = findUserList.get(0);
		try {
			Transaction trans = session1.beginTransaction();
			session1.delete(ui);
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session1.close();
		}
	}
%>
