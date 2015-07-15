package org.action;

import java.text.SimpleDateFormat;
import java.util.Date;
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

import freemarker.core.ParseException;

public class DetailInfoAction extends ActionSupport{
	private String sex;
	private String birthdate;
	private String phonenumber;
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	@Override
	public String execute() throws Exception {
		HttpServletRequest request1 = ServletActionContext.getRequest();
		Cookie[] cookies = request1.getCookies();
		String username = null;
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("username")) {
				username = cookie.getValue();
				break;
			}
		}
		Session session = HibernateSessionFactory.getSession();
		Transaction trans = session.beginTransaction();
		Query query = session.createQuery("from Userinfo where admin=\'" + username + "\'");
		List<Userinfo> list = query.list();
		Userinfo ui = list.get(0);
		ui.setSex(getSex());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		ui.setBirthdate(sdf.parse(getBirthdate()));
		ui.setPhone(getPhonenumber());
		session.update(ui);
		trans.commit();
		session.close();
		return SUCCESS;
	}
	
}
