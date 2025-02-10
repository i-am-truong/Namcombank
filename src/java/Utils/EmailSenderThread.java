/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import jakarta.mail.MessagingException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 *
 * @author duong
 */
public class EmailSenderThread extends Thread{
    private String to;
    private HttpSession session;

    public EmailSenderThread(String to, HttpSession session) {
        this.to = to;
        this.session = session;
    }

    @Override
    public void run() {
        int otp = EmailUtil.sendOTPMail(to);

        // Set expiry time (15 minutes from now)
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE, 15);
        Timestamp expireTime = new Timestamp(calendar.getTimeInMillis());

        session.setAttribute("otp", otp); // Lưu OTP vào session sau khi gửi thành công
        session.setAttribute("otpExpireTime", expireTime); // Lưu thời gian hết hạn OTP vào session
    }
}
