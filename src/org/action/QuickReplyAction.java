package org.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.model.Posts;
import org.model.Reply;
import org.model.Userinfo;
import org.util.HibernateSessionFactory;

import com.opensymphony.xwork2.ActionSupport;

public class QuickReplyAction extends ActionSupport{
	private String content;
	private String postid;
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPostid() {
		return postid;
	}
	public void setPostid(String postid) {
		this.postid = postid;
	}
	@Override
	public String execute() throws Exception {
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
		
		Session session = HibernateSessionFactory.getSession();
		Transaction trans = session.beginTransaction();
		trans.begin();
		Reply reply = new Reply();
		Query postidFindReplyIdQuery = session.createQuery("from Reply order by reply_id desc");
		postidFindReplyIdQuery.setFirstResult(0);
		postidFindReplyIdQuery.setMaxResults(1);
		List<Reply> postidFindReplyIdList = postidFindReplyIdQuery.list();
		Reply theReply = postidFindReplyIdList.get(0);
		long replyid = theReply.getReplyId() + 1;
		reply.setReplyId(replyid);
		Userinfo ui = new Userinfo();
		ui.setAdmin(username);
		reply.setUserinfo(ui);
		Posts post = new Posts();
		post.setPostid(Integer.parseInt(postid));
		reply.setPosts(post);
		reply.setReplyContent(getContent());
		
		Date date = new Date();
		Timestamp ts = new Timestamp(date.getTime());
		reply.setReplyCreatetime(ts);
		
		session.save(reply);
		trans.commit();
		session.close();
		return SUCCESS;
	}
}
