package org.util;

import java.sql.Timestamp;
import java.util.Date;

public class Time {
	public static String howLong(Timestamp timestamp) {
		long between = 0;
        try {
            Date begin = timestamp;
            Date end = new Date();
            between = (end.getTime() - begin.getTime());// 得到两者的毫秒数
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        long day = between / (24 * 60 * 60 * 1000);
        long hour = (between / (60 * 60 * 1000) - day * 24);
        long min = ((between / (60 * 1000)) - day * 24 * 60 - hour * 60);
        long s = (between / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
        if (day == 0) {
            if (hour == 0) {
                if (min == 0) {
                    return (s + "秒");
                } else {
                    return (min + "分" + s + "秒");
                }
            } else {
                return (hour + "小时" + min + "分");
            }
        } else {
            return (day + "天" + hour + "小时");
        }
        
        
	}
}
