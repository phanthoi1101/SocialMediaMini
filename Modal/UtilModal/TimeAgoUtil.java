package UtilModal;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
public class TimeAgoUtil {
    public String getTimeAgoUtil(Timestamp createdAt) {
        Instant createdInstant = createdAt.toInstant();
        LocalDateTime postTime = LocalDateTime.ofInstant(createdInstant, ZoneId.systemDefault());
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(postTime, now);
        long seconds = duration.getSeconds();
        if (seconds < 60) {
            return "vừa xong";
        } else if (seconds < 3600) {
            long minutes = seconds / 60;
            return minutes + " phút trước";
        } else if (seconds < 86400) {
            long hours = seconds / 3600;
            return hours + " giờ trước";
        } else if (seconds < 30*86400) {
            long days = seconds / 86400;
            return days + " ngày trước";
        } else {
        	 DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
             return postTime.toLocalDate().format(formatter); // hoặc định dạng lại cho đẹp
        }
    }
}
