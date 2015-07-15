package org.action;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.hibernate.Session;
import org.model.Userinfo;
import org.util.HibernateSessionFactory;

import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport{
	private String username;
	private String password;
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String login() {
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
					return SUCCESS;
				}
			}
			return ERROR;
		} else {
			return ERROR;
		}
		
	}
	
	public String logout() {
		HttpServletRequest reqeust = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		Cookie[] cookies = reqeust.getCookies();
		for (Cookie cookie : cookies) {
			cookie.setValue("");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		return ERROR;
	}
	
	@Override
	public String execute() throws Exception {
		int flag = 0;
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from Userinfo");
		List<Userinfo> list = query.list();
		for (int i = 0; i < list.size(); i++) {
			if (username.equals(list.get(i).getAdmin().trim()) && password.equals(list.get(i).getPwd().trim())) {
				flag = 1;
			}
		}
		session.close();
		if (flag == 0) {
			return "loginerror";
		} else {
			Cookie usernameCookie = new Cookie("username", getUsername());
			usernameCookie.setMaxAge(60 * 60);
			Cookie passwordCookie = new Cookie("password", getPassword());
			passwordCookie.setMaxAge(60 * 60);
			HttpServletResponse response = ServletActionContext.getResponse();
			response.addCookie(usernameCookie);
			response.addCookie(passwordCookie);
			return SUCCESS;
		}
	}
	
	
}
