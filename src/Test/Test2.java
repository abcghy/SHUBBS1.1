package Test;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.model.Posts;
import org.util.HibernateSessionFactory;

public class Test2 {
	public static void main(String[] args) {
		Session session1 = HibernateSessionFactory.getSession();
		Query usernameFindPostIdQuery = session1.createQuery("from Posts where admin='abcghy'");
//		usernameFindPostIdQuery.setFirstResult(0);
//		usernameFindPostIdQuery.setMaxResults(1);
		List<Posts> usernameFindPostIdList = usernameFindPostIdQuery.list();
		Posts thePost = usernameFindPostIdList.get(0);
		int postid = thePost.getPostid();
		System.out.println(postid);
//		Query query = session.createQuery("from Posts where postid=200");
//		List<Posts> list = query.list();
//		Posts thePost = list.get(0);
//		System.out.println(Time.howLong(thePost.getCreatetime()));
//		Query postFindLatestReplyQuery = session.createQuery("from Reply where postid=" + 200 + " order by reply_id desc");
//		List<Reply> postFindLatestReplyList = postFindLatestReplyQuery.list();
//		Reply theReply = postFindLatestReplyList.get(0);
//		System.out.println(theReply.getReplyCreatetime());
		
		
//		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
//        long between = 0;
//        try {
//            java.util.Date begin = dfs.parse("2015-07-20 11:24:49.145");
////            java.util.Date end = dfs.parse("2015-07-20 11:24:49.145");
//            java.util.Date end = new Date();
//            between = (end.getTime() - begin.getTime());// 得到两者的毫秒数
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
//        long day = between / (24 * 60 * 60 * 1000);
//        long hour = (between / (60 * 60 * 1000) - day * 24);
//        long min = ((between / (60 * 1000)) - day * 24 * 60 - hour * 60);
//        long s = (between / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
//
//        if (day == 0) {
//            if (hour == 0) {
//                if (min == 0) {
//                    System.out.println(s + "秒");
//                } else {
//                    System.out.println(min + "分" + s + "秒");
//                }
//            } else {
//                System.out.println(hour + "小时" + min + "分");
//            }
//        } else {
//            System.out.println(day + "天" + hour + "小时");
//        }
	}
}
