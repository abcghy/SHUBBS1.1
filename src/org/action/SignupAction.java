package org.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.model.Userinfo;
import org.util.HibernateSessionFactory;

import com.opensymphony.xwork2.ActionSupport;

public class SignupAction extends ActionSupport {
	String usernamesignup;
	String emailsignup;
	String passwordsignup;
	String passwordsignup_confirm;

	public String getUsernamesignup() {
		return usernamesignup;
	}

	public void setUsernamesignup(String usernamesignup) {
		this.usernamesignup = usernamesignup;
	}

	public String getEmailsignup() {
		return emailsignup;
	}

	public void setEmailsignup(String emailsignup) {
		this.emailsignup = emailsignup;
	}

	public String getPasswordsignup() {
		return passwordsignup;
	}

	public void setPasswordsignup(String passwordsignup) {
		this.passwordsignup = passwordsignup;
	}

	public String getPasswordsignup_confirm() {
		return passwordsignup_confirm;
	}

	public void setPasswordsignup_confirm(String passwordsignup_confirm) {
		this.passwordsignup_confirm = passwordsignup_confirm;
	}

	@Override
	public String execute() throws Exception {
		int flag = 1;
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from Userinfo");
		List<Userinfo> list = query.list();
		for (int i = 0; i < list.size(); i++) {
			if (usernamesignup.equals(list.get(i).getAdmin().trim())
					|| emailsignup.equals(list.get(i).getEmail().trim())) {
				flag = 0;
			}
		}
		if (!passwordsignup.equals(passwordsignup_confirm)) {
			flag = 2;
		}
		if (flag == 0) {
			return "usererror";
		} else if (flag == 1) {
			Transaction trans = session.beginTransaction();
			try {
				Date date = new Date();
				Timestamp timestamp = new Timestamp(date.getTime());
				Userinfo userinfo = new Userinfo(usernamesignup, passwordsignup,
						emailsignup, 1, timestamp);
				userinfo.setRoleid(0);
				session.save(userinfo);
				trans.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				session.close();
			}
			return SUCCESS;
		} else {
			return "pswderror";
		}
	}

}
