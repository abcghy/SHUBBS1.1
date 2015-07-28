package org.action;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.model.Userinfo;
import org.util.HibernateSessionFactory;

import com.opensymphony.xwork2.ActionSupport;

public class ChangePasswordAction extends ActionSupport{
	private String oldpassword;
	private String newpassword;
	private String newpassword_confirm;
	public String getOldpassword() {
		return oldpassword;
	}
	public void setOldpassword(String oldpassword) {
		this.oldpassword = oldpassword;
	}
	public String getNewpassword() {
		return newpassword;
	}
	public void setNewpassword(String newpassword) {
		this.newpassword = newpassword;
	}
	public String getNewpassword_confirm() {
		return newpassword_confirm;
	}
	public void setNewpassword_confirm(String newpassword_confirm) {
		this.newpassword_confirm = newpassword_confirm;
	}
	@Override
	public String execute() throws Exception {
		int flag = 0;
		HttpServletRequest request1 = ServletActionContext.getRequest();
		Cookie[] cookies = request1.getCookies();
		String username = null;
		String password = null;
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("username")) {
				username = cookie.getValue();
			}
			if (cookie.getName().equals("password")) {
				password = cookie.getValue();
				break;
			}
		}
		if (getOldpassword().equals(password) && getNewpassword().equals(getNewpassword_confirm())) {
			flag = 1;	//Success
		}
		if (!getNewpassword().equals(getNewpassword_confirm())) {
			flag = 2;
		}
		if (!getOldpassword().equals(password)) {
			flag = 0;
		}
		if (flag == 0) {
			return "oldpassworderror";
		} else if (flag == 1) {
			Session session = HibernateSessionFactory.getSession();
			Transaction trans = session.beginTransaction();
			trans.begin();
			Query query = session.createQuery("from Userinfo where admin=\'" + username + "\'");
			List<Userinfo> list = query.list();
			Userinfo ui = list.get(0);
			ui.setPwd(getNewpassword());
			session.update(ui);
			trans.commit();
			session.close();
			return SUCCESS;
		} else {
			return "notequal";
		}
		
	}
}
