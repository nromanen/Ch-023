package net.carting.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DateUtil {
    
    private static final Logger LOG = LoggerFactory.getLogger(DateUtil.class);
    public static int globalYear = Calendar.getInstance().get(Calendar.YEAR);

    private static final ThreadLocal<SimpleDateFormat> dateFormatter = new ThreadLocal<SimpleDateFormat>() {
        @Override
        protected SimpleDateFormat initialValue() {
            return new SimpleDateFormat("yyyy-MM-dd");
        }
    };

    private static final ThreadLocal<SimpleDateFormat> timeFormatter = new ThreadLocal<SimpleDateFormat>() {
        @Override
        protected SimpleDateFormat initialValue() {
            return new SimpleDateFormat("HH:mm");
        }
    };

    public static Date getTimeFromString(String timeInString) {
        Date time = null;
        try {
            time = timeFormatter.get().parse(timeInString);
        } catch (ParseException e) {
            LOG.error("Errors in getTimeFromString method", e);
        }
        return time;
    }

    public static Date getDateFromString(String dateInString) {
        Date date = null;
        try {
            date = dateFormatter.get().parse(dateInString);
        } catch (ParseException e) {
            LOG.error("Errors in getDateFromString method", e);
        }
        return date;
    }
    public static String getTimeStringFromInt(Integer intTime) {
        if(intTime!=null){
        String timeResult = new String();
        long h = TimeUnit.MILLISECONDS.toHours(intTime);
        long m = TimeUnit.MILLISECONDS.toMinutes(intTime) - TimeUnit.HOURS.toMinutes(h);
        long s = TimeUnit.MILLISECONDS.toSeconds(intTime) - TimeUnit.MINUTES.toSeconds(m) - TimeUnit.HOURS.toSeconds(h);
        long S = intTime - TimeUnit.SECONDS.toMillis(s) - TimeUnit.MINUTES.toMillis(m) - TimeUnit.HOURS.toMillis(h);
        if (S>0) {
            int i=3;
        	while (S%10==0) {
        		S = S/10;
        		i--;
        	}
        	if(i>1){
        	    timeResult = String.format("%02d:%02d:%02d,%0"+i+"d",h,m,s,S);
        	} else {
        	    timeResult = String.format("%02d:%02d:%02d,%d",h,m,s,S);
        	}
        } else {
        	timeResult = String.format("%02d:%02d:%02d",h,m,s);
        }
        return timeResult; 
        } else {
            return null;
        }
    }
    
    public static Integer getIntFromTimeString(String timeString) {
        String[]str = timeString.split(":");
        int t = 0;
        switch(str.length) {
        case 1:
           t=getMsFromS(str[0]);
           break;
        case 2:
            t=Integer.parseInt(str[0])*1000*60;
            t=t+getMsFromS(str[1]);
            break;
        case 3:
            t=Integer.parseInt(str[0])*1000*3600;
            t=t+Integer.parseInt(str[1])*1000*60;
            t=t+getMsFromS(str[2]);
            break;
        }
        return t;
    }
    public static int getMsFromS(String s) {
        int t= 0;
        s = s.replace(',', '.');
        String[] milisecs=s.split("\\.");
        if (milisecs.length>1) {
	        if (milisecs[1].length()==3){
	            t=t+Integer.parseInt(milisecs[1]);
	        } else if (milisecs[1].length()==2) {
	            t=t+(Integer.parseInt(milisecs[1])*10);
	        } else if (milisecs[1].length()==1) {
	            t=t+(Integer.parseInt(milisecs[1])*100);
	        }
        }
        t=t+(Integer.parseInt(milisecs[0])*1000);
        return t;
    }

	public int getDaysCount(int year) {
		int daysInYear;
			if (year%4 == 0) {
		        if (year%100 == 0) {
		              daysInYear = (year%400 == 0) ? 366 : 365;
		            } else {
		                daysInYear = 366;
		            }
		        } else {
		            daysInYear = 365;
		        }
		    	return daysInYear;
		   }
	
}
