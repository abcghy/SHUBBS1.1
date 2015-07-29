package org.action;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.model.Smallboard;
import org.util.HibernateSessionFactory;

import com.opensymphony.xwork2.ActionSupport;

public class DeleteModule extends ActionSupport{
	private int smboidid;

	public int getSmboidid() {
		return smboidid;
	}

	public void setSmboidid(int smboidid) {
		this.smboidid = smboidid;
	}

	@Override
	public String execute() throws Exception {
		Session session = HibernateSessionFactory.getSession();
		Query smQuery = session.createQuery("from Smallboard where smboidid=" + getSmboidid());
		List<Smallboard> smList = smQuery.list();
		Smallboard theSM = smList.get(0);
		Transaction trans = session.beginTransaction();
		try {
			session.delete(theSM);
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
