<%@page import="org.util.Time"%>
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
		org.model.Reply,
		org.model.Userinfo" 
pageEncoding="utf-8"%>
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

    <title>子版块</title>

	<!-- Custom styles for this template -->
    <link href="css/smallBoard.css" rel="stylesheet">
	
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">
    
    <script type="text/javascript" src="ckeditor/ckeditor.js"></script>
</head>

<body>
	<%
		// aId是子版块号，pageNum是页面号
		int aId = Integer.parseInt(request.getParameter("aId"));
		String temp = request.getParameter("pageNum");
		int pageNum;
		if (temp == null) {
			pageNum = 1;
		} else {
			pageNum = Integer.parseInt(temp);
		}
    	Session session1 = HibernateSessionFactory.getSession();
    	Query smFindBigQuery = session1.createQuery("from Smallboard where smboidid=" + aId);
    	List<Smallboard> smFindBiglist = smFindBigQuery.list();
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
	        <%
		        Query findRoleIdQuery = session1.createQuery("from Userinfo where admin='" + username+ "'");
				List<Userinfo> findRoleIdList = findRoleIdQuery.list();
				Userinfo theUser = findRoleIdList.get(0);
				int roleId = theUser.getRoleid();
	        %>
	            <%if(username != null) { %>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="welcome.jsp">Home</a></li>
						<%
							if (roleId == 1) {
						%>
						<li><a href="dashboard.jsp">Dash</a></li>
						<%}%>
						<li><a href="info.jsp"><%=username%></a></li>
						<li><a href="login!logout">Exit</a></li>
					</ul>
				<%} else {%>
					<div class="navbar-form navbar-left">
						<a href="login.jsp#toregister"><button class="btn btn-danger">注册</button></a>
					</div>
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
	
	<div class="placeNow">
	    <span>当前位置：</span>
	    <a href="welcome.jsp"><%=smFindBiglist.get(0).getBigboard().getBiBoTitle()%></a>
	   	<span>&nbsp;&raquo;&nbsp;</span>
	   	<a href="smallBoard.jsp?aId=<%=aId%>"><%=smFindBiglist.get(0).getSmBoTitle()%></a>
	</div>
	
	<%
		final int NUMPERPAGE = 30;
		Query howManyPostQuery = session1.createQuery("select count(*) from Posts where smboidid=" + aId);
		long howManyPost = (Long) howManyPostQuery.uniqueResult();
		int howManyPosts = (int) howManyPost;
		int howManyPage = howManyPosts / NUMPERPAGE + 1;
	%>
	
	<nav>
	    <ul class="pagination">
	        <li <%if(pageNum==1) out.print("class=\"disabled\"");%>>    <!--哪一个地方不用就用.disabled，正在用的就是.active-->
	            <a aria-label="Previous" href="smallBoard.jsp?aId=<%=aId%>&pageNum=<%if(pageNum!=1) out.print(pageNum-1);else out.print(pageNum);%>">
	                <span aria-hidden="true">&laquo;</span>
	            </a>
	        </li>
	        <li <%if(pageNum==1) out.print("class=\"disabled\"");%>>
	            <a aria-label="Top" href="smallBoard.jsp?aId=<%=aId%>">
	                <span aria-hidden="true">首页</span>
	            </a>
	        </li>
	        <%
		        if (howManyPage < 5) {
	        		for(int i = 1; i <= howManyPage; i++) {
	        			if (i == pageNum) {
	        				out.println("<li class=\"active\"><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
	        			} else {
	        				out.println("<li><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
	        			}
	        		}
	        	} else {
	        		//判断pageNum是1,2?还是最后两页
	        		if (pageNum == 1 || pageNum == 2) {
	        			for (int i = 1; i <= 5; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		} else if (pageNum == howManyPage || pageNum == howManyPage - 1) {
	        			for (int i = howManyPage-4; i <= howManyPage; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		} else {
	        			for (int i = pageNum-2; i <= pageNum+2; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		}
	        	}
	        %>
	        <li <%if(pageNum==howManyPage) out.print("class=\"disabled\"");%>>
	            <a href="smallBoard.jsp?aId=<%=aId%>&pageNum=<%=howManyPage%>" aria-label="Bottom">
	                <span aria-hidden="true">末页</span>
	            </a>
	        </li>
	        <li <%if(pageNum==howManyPage) out.print("class=\"disabled\"");%>>
	            <a href="smallBoard.jsp?aId=<%=aId%>&pageNum=<%if(pageNum!=howManyPage) out.print(pageNum+1);else out.print(pageNum);%>" aria-label="Next">
	                <span aria-hidden="true">&raquo;</span>
	            </a>
	        </li>
	    </ul>
	</nav>
	
	<div class="smallBoard">
	    <table class="table table-bordered table-striped table-hover table-condensed">
	        <thead>
	            <tr>
	                <th class="col-md-1">REPLIES</th>
	                <th class="col-md-7">THREAD</th>
	                <th class="col-md-2">STARTER</th>
	                <th class="col-md-2">LAST POST</th>
	            </tr>
	        </thead>
	        <tbody>
            <%
            	int queryNum = (pageNum - 1) * 30;
            	Query pageNumFindPostQuery = session1.createQuery("from Posts where smboidid="+ aId + " order by postid desc");
            	pageNumFindPostQuery.setFirstResult(queryNum);
            	pageNumFindPostQuery.setMaxResults(30);
            	List<Posts> pageNumFindPostList = pageNumFindPostQuery.list();
            	for (int i = 0; i < pageNumFindPostList.size(); i++) {
            		Posts thePost = pageNumFindPostList.get(i);
            		Query postFindReplyNumQuery = session1.createQuery("select count(*) from Reply where postid =" + thePost.getPostid());
            		long replyNum = (Long) postFindReplyNumQuery.uniqueResult();
            		out.print("<tr><td>"+replyNum+"</td><td class=\"thread\"><a href=\"post.jsp?pId="+thePost.getPostid()+"\">"+thePost.getTitle()+"</a>");
            		if(roleId == 1) {
            			out.print("<button class=\"btn btn-danger delpost\">删</button>");
            		}
            		out.print("</td><td>"+thePost.getUserinfo().getAdmin()+"<br/>");
            		out.print(Time.howLong(thePost.getCreatetime()));
            		Query postFindLatestReplyQuery = session1.createQuery("from Reply where postid=" + thePost.getPostid() + " order by reply_id desc");
            		List<Reply> postFindLatestReplyList = postFindLatestReplyQuery.list();
            		if (postFindLatestReplyList.size() == 0) {
            			out.println("前</td><td>"+thePost.getUserinfo().getAdmin()+"<br/>"+Time.howLong(thePost.getCreatetime())+"前</td></tr>");
            		} else {
            			Reply theReply = postFindLatestReplyList.get(0);
                		out.println("前</td><td>"+theReply.getUserinfo().getAdmin()+"<br/>"+Time.howLong(theReply.getReplyCreatetime())+"前</td></tr>");
            		}
            	}
            %>
	        </tbody>
	    </table>
	</div>
	
	<nav>
	    <ul class="pagination">
	        <li <%if(pageNum==1) out.print("class=\"disabled\"");%>>    <!--哪一个地方不用就用.disabled，正在用的就是.active-->
	            <a aria-label="Previous" href="smallBoard.jsp?aId=<%=aId%>&pageNum=<%if(pageNum!=1) out.print(pageNum-1);else out.print(pageNum);%>">
	                <span aria-hidden="true">&laquo;</span>
	            </a>
	        </li>
	        <li <%if(pageNum==1) out.print("class=\"disabled\"");%>>
	            <a aria-label="Top" href="smallBoard.jsp?aId=<%=aId%>">
	                <span aria-hidden="true">首页</span>
	            </a>
	        </li>
	        <%
	        	if (howManyPage < 5) {
	        		for(int i = 1; i <= howManyPage; i++) {
	        			if (i == pageNum) {
	        				out.println("<li class=\"active\"><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
	        			} else {
	        				out.println("<li><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
	        			}
	        		}
	        	} else {
	        		//判断pageNum是1,2?还是最后两页
	        		if (pageNum == 1 || pageNum == 2) {
	        			for (int i = 1; i <= 5; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		} else if (pageNum == howManyPage || pageNum == howManyPage - 1) {
	        			for (int i = howManyPage-4; i <= howManyPage; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		} else {
	        			for (int i = pageNum-2; i <= pageNum+2; i++) {
	        				if (i == pageNum) {
		        				out.println("<li class=\"active\"><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			} else {
		        				out.println("<li><a href=\"smallBoard.jsp?aId="+ aId + "&pageNum=" + i +"\">&nbsp;"+i+"&nbsp;</a></li>");
		        			}
	        			}
	        		}
	        	}
	        %>
	        <li <%if(pageNum==howManyPage) out.print("class=\"disabled\"");%>>
	            <a href="smallBoard.jsp?aId=<%=aId%>&pageNum=<%=howManyPage%>" aria-label="Bottom">
	                <span aria-hidden="true">末页</span>
	            </a>
	        </li>
	        <li <%if(pageNum==howManyPage) out.print("class=\"disabled\"");%>>
	            <a href="smallBoard.jsp?aId=<%=aId%>&pageNum=<%if(pageNum!=howManyPage) out.print(pageNum+1);else out.print(pageNum);%>" aria-label="Next">
	                <span aria-hidden="true">&raquo;</span>
	            </a>
	        </li>
	    </ul>
	</nav>
	
	<div class="placeNow">
	    <span>当前位置：</span>
	    <a href="welcome.jsp"><%=smFindBiglist.get(0).getBigboard().getBiBoTitle()%></a>
	   	<span>&nbsp;&raquo;&nbsp;</span>
	   	<a href="smallBoard.jsp?aId=<%=aId%>"><%=smFindBiglist.get(0).getSmBoTitle()%></a>
	</div>
	
	<%if (username != null) { %>
	<div class="container" id="quickpost">
	    <span>..:: 快速发贴 ::..</span>
	    <form action="quickpost" method="post" class="form-horizontal">
	    	<input name="smboidid" type="hidden" value="<%=aId%>"/>
	        <div class="form-group col-md-12">
	            <label for="title" class="col-md-1 control-label">主题：</label>
	            <div class="col-md-11">
	                <input name="title" id="topic" type="text" class="form-control"/>
	            </div>
	        </div>
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
	                <input type="submit" value="发表新帖" id="submit" class="btn-danger"/>
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
	<script type="text/javascript">
		$(document).ready(function() {
			$(".delpost").click(function() {
				var xmlhttp;
				xmlhttp = new XMLHttpRequest();
				var string = $(this).prev().attr('href');
				var postId = string.slice(13);
				xmlhttp.open("get", "delpost.jsp?postId="+postId, true);
				xmlhttp.send();
				setTimeout(location.reload(true), 2000);
			});
		});
	</script>
	<%session1.close(); %>
	
</body>
</html>
