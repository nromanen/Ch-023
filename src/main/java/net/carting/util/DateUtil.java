package net.carting.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.TimeZone;

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
        if (intTime != null) {
            Date date = new Date();
            date.setTime(intTime);
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH:mm:ss.SSS");
            simpleDateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
            String dateAsText = simpleDateFormat.format(date);
            return dateAsText;
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
        return ((new GregorianCalendar()).isLeapYear(year) ? 366 : 365);
    }

}
