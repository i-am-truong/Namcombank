package Utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormatter {
    public static String format(Date date, String pattern) {
        if (date == null) {
            return "Unknown Date";
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            // Debug output to check the actual date and time
            System.out.println("Formatting date: " + date + " with pattern: " + pattern);
            return sdf.format(date);
        } catch (Exception e) {
            System.out.println("Error formatting date: " + e.getMessage());
            e.printStackTrace();
            return "Date Error";
        }
    }

    public static String formatDefault(Date date) {
        return format(date, "dd/MM/yyyy, HH:mm");
    }
}
