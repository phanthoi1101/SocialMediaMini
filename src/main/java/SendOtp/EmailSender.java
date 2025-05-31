package SendOtp;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailSender {
	public static void sendOtpEmail(String toEmail, String otpCode) {
        final String fromEmail = "phanthoi1101@gmail.com";
        final String password = "zdjg icvx zvul bzcd";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject("Your OTP Code");
            msg.setText("Your OTP code is: " + otpCode);
            Transport.send(msg);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
