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
		org.model.Posts,
		java.text.SimpleDateFormat,
		org.model.Reply" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
	
	    <title>页面</title>
	
		<!-- Custom styles for this template -->
	    <link href="css/post.css" rel="stylesheet">
		
	    <!-- Bootstrap core CSS -->
	    <link href="css/bootstrap.css" rel="stylesheet">
	    
	    <script type="text/javascript" src="ckeditor/ckeditor.js"></script>
	</head>
	<body>
	<%
		//pId是postid，pageNum是页面数
		int pId = Integer.parseInt(request.getParameter("pId"));
		String temp = request.getParameter("pageNum");
		int pageNum;
		if (temp == null) {
			pageNum = 1;
		} else {
			pageNum = Integer.parseInt(temp);
		}
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
	
	<%
		Session session1 = HibernateSessionFactory.getSession();
		Query postIdFindSmIdQuery = session1.createQuery("from Posts where postid=" + pId);
		List<Posts> postIdFindSmIdList = postIdFindSmIdQuery.list();
		Posts thePost = postIdFindSmIdList.get(0);
	%>
	
	<div class="placeNow">
	    <span>当前位置：</span>
	    <a href="welcome.jsp"><%=thePost.getSmallboard().getBigboard().getBiBoTitle()%></a>
	   	<span>&nbsp;&raquo;&nbsp;</span>
	   	<a href="smallBoard.jsp?aId=<%=thePost.getSmallboard().getSmBoidid()%>"><%=thePost.getSmallboard().getSmBoTitle()%></a>
	   	<span>&nbsp;&raquo;&nbsp;</span>
	   	<a href="post.jsp?pId=<%=pId%>"><%=thePost.getTitle()%></a>
	</div>
	
	<%
		final int NUMPERPAGE = 20;
		Query postIdFindReplyNumQuery = session1.createQuery("select count(*) from Reply where postid=" + pId);
		long howManyReply = (Long) postIdFindReplyNumQuery.uniqueResult();
		int howManyReplies = (int) howManyReply;
		int howManyPage = howManyReplies / NUMPERPAGE + 1;
	%>
	<%
		SimpleDateFormat registersdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat createsdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	%>	
	<nav>
	    <ul class="pagination">
	        <li <%if(pageNum==1) out.print("class=\"disabled\"");%>>    <!--哪一个地方不用就用.disabled，正在用的就是.active-->
	            <a aria-label="Previous" href="post.jsp?pId=<%=pId%>&pageNum=<%if(pageNum!=1) out.print(pageNum-1);else out.print(pageNum);%>">
	                <span aria-hidden="true">&laquo;</span>
	            </a>
	        </li>
	        <li <%if(pageNum==1) out.print("class=\"disabled\"");%>>
	            <a aria-label="Top" href="post.jsp?pId=<%=pId%>">
	                <span aria-hidden="true">首页</span>
	            </a>
	        </li>
	        <%
		        if (howManyPage < 5) {
	        		for(int i = 1; i <= howManyPage; i++) {
	        			if (i == pageNum) {
	        				out.println("<li class=\"active\"><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
	        			} else {
	        				out.println("<li><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
	        			}
	        		}
	        	} else {
	        		//判断pageNum是1,2?还是最后两页
	        		if (pageNum == 1 || pageNum == 2) {
	        			for (int i = 1; i <= 5; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		} else if (pageNum == howManyPage || pageNum == howManyPage - 1) {
	        			for (int i = howManyPage-4; i <= howManyPage; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		} else {
	        			for (int i = pageNum-2; i <= pageNum+2; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		}
	        	}
	        %>
	        <li <%if(pageNum==howManyPage) out.print("class=\"disabled\"");%>>
	            <a href="post.jsp?pId=<%=pId%>&pageNum=<%=howManyPage%>" aria-label="Bottom">
	                <span aria-hidden="true">末页</span>
	            </a>
	        </li>
	        <li <%if(pageNum==howManyPage) out.print("class=\"disabled\"");%>>
	            <a href="post.jsp?pId=<%=pId%>&pageNum=<%if(pageNum!=howManyPage) out.print(pageNum+1);else out.print(pageNum);%>" aria-label="Next">
	                <span aria-hidden="true">&raquo;</span>
	            </a>
	        </li>
	    </ul>
	</nav>
	
	<div class="post">
	    <table class="table table-bordered table-striped table-hover table-condensed">
	        <caption><h3>:: <%=thePost.getTitle()%> ::</h3></caption>
	        <thead>
	            <tr>
	                <th class="col-md-2">AUTHOR</th>
	                <th>CONTENT</th>
	            </tr>
	        </thead>
	        <tbody>
	        
	        <%
	        	int queryNum = (pageNum - 1) * 20;
	        	Query pageNumFindReplyQuery = session1.createQuery("from Reply where postid=" + pId + "order by reply_id");
	        	pageNumFindReplyQuery.setFirstResult(queryNum);
	        	pageNumFindReplyQuery.setMaxResults(20);
	        	List<Reply> pageNumFindReplyList = pageNumFindReplyQuery.list();
	        	if (pageNum == 1) {%>
	        	<tr>
	                <td class="author">
	                    <span class="col-md-8"><%=thePost.getUserinfo().getAdmin()%></span>
	                    <span class="col-md-4">#0</span>
	                    <span class="col-md-12">注册：<%=registersdf.format(thePost.getUserinfo().getRegisterdate())%></span>
	                </td> <!--发布者用户名,要靠左-->
	                <td>
	                	<span class="content-title col-md-10"><%=thePost.getTitle()%></span>
	                    <span class="post-time col-md-2"><%=createsdf.format(thePost.getCreatetime())%></span>
						<span><%=thePost.getContent()%></span>
					</td> <!--内容，垂直居中，靠左-->
	            </tr>
	        	<%}
	        	for (int i = 0; i < pageNumFindReplyList.size(); i++) {
	        		int replyFloor = queryNum + i + 1;
	        		Reply theReply = pageNumFindReplyList.get(i);
	        		out.println("<tr><td class=\"author\"><span class=\"col-md-8\">"+theReply.getUserinfo().getAdmin() + "</span>");
	        		out.println("<span class=\"col-md-4\">#" + replyFloor + "</span>");
	        		out.println("<span class=\"col-md-12\">注册：" + registersdf.format(theReply.getUserinfo().getRegisterdate()) + "</span></td>");
	        		out.println("<td><span class=\"content-title col-md-10\"></span>");
	        		out.println("<span class=\"post-time col-md-2\">" + createsdf.format(theReply.getReplyCreatetime()) + "</span><span>");
	        		out.println(theReply.getReplyContent());
	        		out.println("</span></td></tr>");
	        	}
	        %>
	        </tbody>
	    </table>
	</div>
	
	
	
	<nav>
	    <ul class="pagination">
	        <li <%if(pageNum==1) out.print("class=\"disabled\"");%>>    <!--哪一个地方不用就用.disabled，正在用的就是.active-->
	            <a aria-label="Previous" href="post.jsp?pId=<%=pId%>&pageNum=<%if(pageNum!=1) out.print(pageNum-1);else out.print(pageNum);%>">
	                <span aria-hidden="true">&laquo;</span>
	            </a>
	        </li>
	        <li <%if(pageNum==1) out.print("class=\"disabled\"");%>>
	            <a aria-label="Top" href="post.jsp?pId=<%=pId%>">
	                <span aria-hidden="true">首页</span>
	            </a>
	        </li>
	        <%
		        if (howManyPage < 5) {
	        		for(int i = 1; i <= howManyPage; i++) {
	        			if (i == pageNum) {
	        				out.println("<li class=\"active\"><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
	        			} else {
	        				out.println("<li><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
	        			}
	        		}
	        	} else {
	        		//判断pageNum是1,2?还是最后两页
	        		if (pageNum == 1 || pageNum == 2) {
	        			for (int i = 1; i <= 5; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		} else if (pageNum == howManyPage || pageNum == howManyPage - 1) {
	        			for (int i = howManyPage-4; i <= howManyPage; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		} else {
	        			for (int i = pageNum-2; i <= pageNum+2; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"post.jsp?pId="+ pId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		}
	        	}
	        %>
	        <li <%if(pageNum==howManyPage) out.print("class=\"disabled\"");%>>
	            <a href="post.jsp?pId=<%=pId%>&pageNum=<%=howManyPage%>" aria-label="Bottom">
	                <span aria-hidden="true">末页</span>
	            </a>
	        </li>
	        <li <%if(pageNum==howManyPage) out.print("class=\"disabled\"");%>>
	            <a href="post.jsp?pId=<%=pId%>&pageNum=<%if(pageNum!=howManyPage) out.print(pageNum+1);else out.print(pageNum);%>" aria-label="Next">
	                <span aria-hidden="true">&raquo;</span>
	            </a>
	        </li>
	    </ul>
	</nav>
	
	<div class="placeNow">
	    <span>当前位置：</span>
	    <a href="welcome.jsp"><%=thePost.getSmallboard().getBigboard().getBiBoTitle()%></a>
	   	<span>&nbsp;&raquo;&nbsp;</span>
	   	<a href="smallBoard.jsp?aId=<%=thePost.getSmallboard().getSmBoidid()%>"><%=thePost.getSmallboard().getSmBoTitle()%></a>
	   	<span>&nbsp;&raquo;&nbsp;</span>
	   	<a href="post.jsp?pId=<%=pId%>"><%=thePost.getTitle()%></a>
	</div>
	
	
	<%if (username!=null) { %>
	<div class="container" id="quickreply">
	    <span>..:: 快速回复 ::..</span>
	    <form action="quickreply" method="post" class="form-horizontal">
	    	<input name="postid" type="hidden" value="<%=pId%>"/>
	        <!-- <div class="form-group col-md-12">
	            <label for="title" class="col-md-1 control-label">主题：</label>
	            <div class="col-md-11">
	                <input name="title" id="topic" type="text" class="form-control"/>
	            </div>
	        </div> -->
	        <div class="form-group">
	            <label for="content" class="control-label col-md-1">内容：</label>
	            <div class="col-md-11">
	                <textarea name="content" id="content" class="form-control" rows="8"></textarea>
	                <script type="text/javascript">CKEDITOR.replace('content');</script>
	            </div>
	        </div>
	        <div class="form-group">
	            <div class="col-md-1"></div>
	            <div class="col-md-9">
	                <input type="submit" value="发表回复" id="submit" class="btn-danger"/>
	            </div>
	        </div>
	    </form>
	</div>
	<%} %>
	
	<!-- FOOTER -->
	<footer >
	    <p class="pull-right"><a href="#">Back to top</a></p>
	
	    <p>&copy; SHUBBS · <a href="#">Privacy</a> · <a href="#">Terms</a></p>
	</footer>
	
	<!-- Bootstrap core JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<%session1.close(); %>
	</body>
</html>
