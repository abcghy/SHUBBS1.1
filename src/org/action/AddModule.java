package org.action;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.model.Bigboard;
import org.model.Smallboard;
import org.util.HibernateSessionFactory;

import com.opensymphony.xwork2.ActionSupport;

public class AddModule extends ActionSupport{
	private int biboid;
	private String smbotitle;
	public int getBiboid() {
		return biboid;
	}
	public void setBiboid(int biboid) {
		this.biboid = biboid;
	}
	public String getSmbotitle() {
		return smbotitle;
	}
	public void setSmbotitle(String smbotitle) {
		this.smbotitle = smbotitle;
	}
	@Override
	public String execute() throws Exception {
		Session session = HibernateSessionFactory.getSession();
		Transaction trans = session.beginTransaction();
		Smallboard sb = new Smallboard();
		Bigboard bb = new Bigboard();
		bb.setBiBoid(getBiboid());
		sb.setBigboard(bb);
		sb.setSmBoTitle(getSmbotitle());
		Query lastSmBoIdQuery = session.createQuery("from Smallboard order by smboidid desc");
		lastSmBoIdQuery.setFirstResult(0);
		lastSmBoIdQuery.setMaxResults(1);
		Smallboard theSB = (Smallboard) lastSmBoIdQuery.list().get(0);
		int smboidid = theSB.getSmBoidid() + 1;
		sb.setSmBoidid(smboidid);
		session.save(sb);
		trans.commit();
		session.close();
		return SUCCESS;
	}
}
