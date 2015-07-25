<%@ page language="java" 
import="java.util.*,
		com.opensymphony.xwork2.ActionContext,
		org.util.HibernateSessionFactory,
		org.apache.struts2.ServletActionContext,
		org.hibernate.Session,
		org.hibernate.Query,
		java.util.List,
		org.model.Posts,
		org.model.Reply
" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	
	<title>正在跳转...</title>
	   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/postcache.css">

</head>
  
<body>

	<div class='assembly'>
	    <div class='plane'>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	    </div>
	    <div class='plane'>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	    </div>
	    <div class='plane'>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	    </div>
	    <div class='plane'>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	        <div class='block'>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	            <div class='lateral'></div>
	        </div>
	    </div>
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
	
	<%
		Session session1 = HibernateSessionFactory.getSession();
		Query usernameFindPostIdQuery = session1.createQuery("from Reply where admin='" + username + "' order by reply_id desc");
		usernameFindPostIdQuery.setFirstResult(0);
		usernameFindPostIdQuery.setMaxResults(1);
		List<Reply> usernameFindPostIdList = usernameFindPostIdQuery.list();
		Reply theReply = usernameFindPostIdList.get(0);
		int postid = theReply.getPosts().getPostid();
		long replyid = theReply.getReplyId();
		
		final int NUMPERPAGE = 30;
		long howManyPost = (Long) replyid;
		long howManyPage = howManyPost / NUMPERPAGE + 1;
		
		String content = 3+";URL=post.jsp?pId="+postid+"&pageNum="+howManyPage;
		response.setHeader("REFRESH",content);
	%>
	
	<%session1.close(); %>
	
</body>
</html>
