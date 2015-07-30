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
import org.model.Smallboard;
import org.model.Userinfo;
import org.util.HibernateSessionFactory;

import com.opensymphony.xwork2.ActionSupport;

public class QuickPostAction extends ActionSupport{
	private String title;
	private String content;
	private String smboidid;
	public String getSmboidid() {
		return smboidid;
	}
	public void setSmboidid(String smboidid) {
		this.smboidid = smboidid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
		try {
			Posts post = new Posts();
			Query smboidFindPostIdQuery = session.createQuery("from Posts order by postid desc");
			smboidFindPostIdQuery.setFirstResult(0);
			smboidFindPostIdQuery.setMaxResults(1);
			List<Posts> smboidFindPostIdList = smboidFindPostIdQuery.list();
			int postId;
			if (smboidFindPostIdList.size() != 0) {
				postId = smboidFindPostIdList.get(0).getPostid() + 1;
			} else {
				postId = 1;
			}
			post.setPostid(postId);
			post.setTitle(getTitle());
			Smallboard sm = new Smallboard();
			sm.setSmBoidid(Integer.parseInt(getSmboidid()));
			post.setSmallboard(sm);
			Userinfo ui = new Userinfo();
			ui.setAdmin(username);
			post.setUserinfo(ui);
			
			Date date = new Date();
			Timestamp ts = new Timestamp(date.getTime());
			post.setCreatetime(ts);
			post.setUpdatetime(ts);
			post.setContent(getContent());
			
			post.setGoodcount(0);
			post.setReply(0);
			post.setEssence(0);
			session.save(post);
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			session.close();
		}
		return SUCCESS;
	}
}
