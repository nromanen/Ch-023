package net.carting.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

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
            e.printStackTrace();
        }
        return time;
    }

    public static Date getDateFromString(String dateInString) {
        Date date = null;
        try {
            date = dateFormatter.get().parse(dateInString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

}
