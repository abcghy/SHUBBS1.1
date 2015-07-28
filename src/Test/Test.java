package Test;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.model.Posts;
import org.model.Smallboard;
import org.model.Userinfo;
import org.util.HibernateSessionFactory;

public class Test {

	public static void main(String[] args) {
		Session session1 = HibernateSessionFactory.getSession();
		
		Query findUserQuery = session1.createQuery("from Userinfo where admin='duidui3'");
		List<Userinfo> findUserList = findUserQuery.list();
		Userinfo ui = findUserList.get(0);
		Transaction trans = session1.beginTransaction();
		session1.delete(ui);
		trans.commit();
		session1.clear();
		session1.close();
		
//		for (int i = 0; i < 100; i++) {
//			Transaction trans = session1.beginTransaction();
//			Userinfo ui = new Userinfo();
//			ui.setAdmin("duidui" + i);
//			ui.setPwd("duidui" + i);
//			ui.setEmail("duidui" + i + "@163.com");
//			ui.setUserlevel(1);
//			Timestamp ts = new Timestamp(new Date().getTime());
//			ui.setRegisterdate(ts);
//			session1.save(ui);
//			trans.commit();
//		}
//		session1.close();
		
//		Query query = session1.createQuery("from Userinfo where admin='abc123'");
//		List<Userinfo> list = query.list();
//		Userinfo ui = list.get(0);
//		System.out.println(ui.getSex() == null);
//		Query pageNumFindPostQuery = session1.createQuery("from Posts where smboidid="+ 9 + " order by postid desc");
//		pageNumFindPostQuery.setFirstResult(30);
//		pageNumFindPostQuery.setMaxResults(30);
//    	List<Posts> pageNumFindPostList = pageNumFindPostQuery.list();
//    	for (int i = 0; i < pageNumFindPostList.size(); i++) {
//    		Posts thePost = pageNumFindPostList.get(i);
//    		Query postFindReplyNumQuery = session1.createQuery("select count(*) from Reply where postid =" + thePost.getPostid());
//    		long replyNum = (Long) postFindReplyNumQuery.uniqueResult();
//    		System.out.println("<tr><td>"+replyNum+"</td><td class=\"thread\">"+thePost.getTitle()+"</td><td>"+thePost.getUserinfo().getAdmin()+"<br/>"+thePost.getCreatetime()+"</td><td>"+thePost.getUpdatetime()+"</td></tr>");
//    	}
//		for (int i = 1; i < 200; i++) {
//			Transaction trans = session1.beginTransaction();
//			Posts post = new Posts();
//			Query theHighestIdQuery = session1.createQuery("from Posts where smboidid=9 order by postid desc");
//			theHighestIdQuery.setFirstResult(0);
//			theHighestIdQuery.setMaxResults(1);
//			List<Posts> list = theHighestIdQuery.list();
//			int theHighestId = list.get(0).getPostid() + 1;
//			post.setPostid(theHighestId);
//			post.setTitle("天梯排名第一牌组");
//			Smallboard sb = new Smallboard();
//			sb.setSmBoidid(9);
//			post.setSmallboard(sb);
//			Userinfo ui = new Userinfo();
//			ui.setAdmin("abcghy");
//			post.setUserinfo(ui);
//			post.setContent("此牌组为祖传牌组，请勿告诉他人");
//			Date date = new Date();
//			Timestamp timestamp = new Timestamp(date.getTime());
//			post.setCreatetime(timestamp);
//			post.setUpdatetime(timestamp);
//			session1.save(post);
//			trans.commit();
////		}
//		session1.close();
		
//    	Query smFindBigQuery = session1.createQuery("from Smallboard where smboidid=" + 9);
//    	List<Smallboard> smFindBiglist = smFindBigQuery.list();
//    	System.out.println(smFindBiglist.get(0).getBigboard().getBiBoTitle());
//		int num = 100 / 30 + 1;
//		System.out.println(num);
//		Query query3 = session1.createQuery("from Smallboard where biboid=" + 0 + "order by smboidid desc");
//		List<Smallboard> list3 = query3.list();
//		for (int i = 0; i < list3.size(); i++) {
//			System.out.println(list3.get(i).getSmBoTitle() + '\n');
//		}
//		Query query3 = session1.createQuery("from Smallboard where biboid=" + 1);
//		List<Smallboard> list3 = query3.list();
//		System.out.println(list3.get(1).getSmBoidid());
//		Query query4 = session1.createQuery("select count(*) from Posts where smboidid=" + list3.get(0).getSmBoidid());
//		long postNumber = (Long) query4.uniqueResult();
//		System.out.println("DEBUG SUCCESS!");
//		Query query1 = session1.createQuery("from Bigboard order by biboid");
//		List<Bigboard> list1 = query1.list();
//		for (int i = 0; i < list1.size(); i++) {
//			System.out.println(list1.get(i).getBiBoTitle());
//		}
//		for (int i = 0; i < list.size(); i++) {
//			System.out.println(list.get(i).getAdmin() + '\n');
//			System.out.println(list.get(i).getEmail() + '\n');
//			System.out.println(list.get(i).getRegisterdate().toString() + '\n');
//		}
//		String str = "1994-10-24";
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		Date date = null;
//		try {
//			date = sdf.parse(str);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
//		System.out.println(date);
//		System.out.println(sdf.format(date));
	}
}
