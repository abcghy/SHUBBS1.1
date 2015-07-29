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
		org.util.Time,
		org.model.Posts,
		org.model.Reply" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String postId = request.getParameter("postId");
	System.out.println(postId);
	Session session1 = HibernateSessionFactory.getSession();
	Query postIdDeletePostQuery = session1.createQuery("from Posts where postid="+postId);
	List<Posts> postIdDeletePostList = postIdDeletePostQuery.list();
	Posts thePosts = postIdDeletePostList.get(0);
	Query findReplyQuery = session1.createQuery("from Reply where postid=" + postId);
	List<Reply> findReplyList = findReplyQuery.list();
	try {
		Transaction trans = session1.beginTransaction();
		for(int i = 0; i < findReplyList.size(); i++) {
			session1.delete(findReplyList.get(i));
		}
		session1.delete(thePosts);
		trans.commit();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		session1.close();
	}
%>
