package Test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Test {

	public static void main(String[] args) {
//		Session session = HibernateSessionFactory.getSession();
//		Query query = session.createQuery("from Userinfo where admin=\'abcghy\'");
//		List<Userinfo> list = query.list();
//		for (int i = 0; i < list.size(); i++) {
//			System.out.println(list.get(i).getAdmin() + '\n');
//			System.out.println(list.get(i).getEmail() + '\n');
//			System.out.println(list.get(i).getRegisterdate().toString() + '\n');
//		}
		String str = "1994-10-24";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = sdf.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println(date);
//		System.out.println(sdf.format(date));
	}
}
