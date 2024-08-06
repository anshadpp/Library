package sample.user.dashboard.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com"; // Google's SMTP server
    private static final String SMTP_PORT = "587"; // Port for TLS/STARTTLS
    private static final String SMTP_USER = "otpgenerator069@gmail.com"; // Your email
    private static final String SMTP_PASSWORD = "otpkpynwymyxnxjb"; // Your app-specific password

    public static void sendEmail(String to, String subject, String body) throws MessagingException {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", SMTP_HOST);
        properties.put("mail.smtp.port", SMTP_PORT);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USER, SMTP_PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(SMTP_USER));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(body);

        Transport transport = session.getTransport("smtp");
        transport.connect(SMTP_HOST, SMTP_USER, SMTP_PASSWORD);
        transport.sendMessage(message, message.getAllRecipients());
        transport.close();
    }
}
