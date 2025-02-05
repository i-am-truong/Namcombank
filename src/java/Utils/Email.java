/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author duong
 */
public class Email extends HttpServlet{
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        HttpSession session = request.getSession();

        String otpvalue = "";

        if (email != null && !email.equals("")) {

            Random rand = new Random();
            int[] otpArray = new int[6]; // Tạo một mảng 6 số nguyên

            // Tạo mỗi chữ số ngẫu nhiên và gán vào mảng
            for (int i = 0; i < 6; i++) {
                otpArray[i] = rand.nextInt(10); // Tạo một chữ số ngẫu nhiên từ 0 đến 9
            }

            // Chuyển đổi mảng thành chuỗi
            StringBuilder otpValue = new StringBuilder(6);
            for (int digit : otpArray) {
                otpValue.append(digit);
            }
            otpvalue = otpValue.toString();
        }
        String to = email;
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getDefaultInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("isp1804cardweb3@gmail.com", "pchn xlef opnr bhca");
            }
        });

        try {
            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress("your-email@gmail.com"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Requires OTP code to activate your account");
            message.setText("Your OTP to activate your account is: " + otpvalue);
            Transport.send(message);
            System.out.println("message sent successfully");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("otp", otpvalue);
        session.setAttribute("email", email);
        response.sendRedirect("enterOTP.jsp");
    }
}
