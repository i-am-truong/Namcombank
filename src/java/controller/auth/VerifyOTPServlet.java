package controller.auth;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VerifyOTPServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(VerifyOTPServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (session.getAttribute("account") == null) {
            request.getRequestDispatcher("admin.login/login.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin email từ session hoặc từ đối tượng Staff
        String staffEmail = getStaffEmail(session);
        request.setAttribute("staffEmail", staffEmail);

        // Kiểm tra trạng thái OTP và thiết lập các thuộc tính
        checkOtpStatus(request, session);

        // Chuyển hướng đến trang nhập OTP
        request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String staffEmail = getStaffEmail(session);
        request.setAttribute("staffEmail", staffEmail);

        // Check if this is a resend request
        String action = request.getParameter("action");
        if ("resend".equals(action) || "new".equals(action)) {
            try {
                // Generate new OTP
                String otpValue = generateOTP();

                // Send OTP via email
                sendEmail(staffEmail, otpValue);

                // Store OTP in session with expiry time (1 minute)
                session.setAttribute("otp", otpValue);
                session.setAttribute("otpExpiry", System.currentTimeMillis() + 300000);
                session.setAttribute("otpSent", true);

                // Set success message
                request.setAttribute("success", "Mã OTP mới đã được gửi đến email của bạn.");
                request.setAttribute("otpSent", true);

                // Forward back to the OTP verification page
                request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error sending OTP: " + e.getMessage(), e);
                request.setAttribute("error", "Không thể gửi mã OTP. Vui lòng thử lại sau.");
                request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
                return;
            }
        }

        // If not a resend request, verify the submitted OTP
        String userOtp = request.getParameter("otp");
        if (userOtp == null || userOtp.isEmpty()) {
            // If no OTP provided, check if we need to send a new one
            checkOtpStatus(request, session);
            request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
            return;
        }

        String storedOtp = (String) session.getAttribute("otp");
        Long otpExpiry = (Long) session.getAttribute("otpExpiry");
        String redirectAfterOTP = (String) session.getAttribute("redirectAfterOTP");

        // Check if OTP exists and hasn't expired
        if (storedOtp == null || otpExpiry == null) {
            request.setAttribute("error", "Phiên OTP đã hết hạn. Vui lòng yêu cầu mã OTP mới.");
            request.setAttribute("otpExpired", true);
            request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
            return;
        }

        // Check if OTP has expired
        if (System.currentTimeMillis() > otpExpiry) {
            session.removeAttribute("otp");
            session.removeAttribute("otpExpiry");
            request.setAttribute("error", "Mã OTP đã hết hạn. Vui lòng yêu cầu mã OTP mới.");
            request.setAttribute("otpExpired", true);
            request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
            return;
        }

        // Verify OTP
        if (storedOtp.equals(userOtp)) {
            // OTP verified successfully
            session.setAttribute("otpVerified", true);

            // Clear OTP data
            session.removeAttribute("otp");
            session.removeAttribute("otpExpiry");
            session.removeAttribute("otpSent");


            // Redirect to appropriate page based on role
            if (redirectAfterOTP != null && !redirectAfterOTP.isEmpty()) {
                response.sendRedirect(redirectAfterOTP);
            } else {
                // Default redirect if no specific page
                response.sendRedirect("403.html");
            }
        } else {
            // Invalid OTP
            request.setAttribute("error", "Mã OTP không đúng. Vui lòng thử lại.");
            request.setAttribute("otpSent", true); // OTP sent, show OTP input form
            request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
        }
    }

// Add these methods to VerifyOTPServlet class if they don't exist already
    private String generateOTP() {
        Random rand = new Random();
        StringBuilder otpValue = new StringBuilder(6);
        for (int i = 0; i < 6; i++) {
            otpValue.append(rand.nextInt(10)); // Generate a random digit from 0-9
        }
        return otpValue.toString();
    }

    private void sendEmail(String to, String otpvalue) throws MessagingException {
        // Set up email properties
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        // Email account info
        final String senderEmail = "doanvinhhung369@gmail.com"; // Replace with your email
        final String senderPassword = "typj uudv rlzc yxzq"; // Replace with your app password

        // Create email session with authentication
        Session mailSession = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // Create message
            MimeMessage message = new MimeMessage(mailSession);

            // Set sender
            message.setFrom(new InternetAddress(senderEmail));

            // Set recipient - staff email
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Set subject
            message.setSubject("Namcombank - Xác thực tài khoản", "UTF-8");

            // Tạo nội dung email giống mẫu
            String htmlBody = "<!DOCTYPE html>"
                    + "<html>"
                    + "<head>"
                    + "    <meta charset='UTF-8'>"
                    + "    <style>"
                    + "        body {"
                    + "            font-family: Arial, sans-serif;"
                    + "            line-height: 1.6;"
                    + "            color: #333333;"
                    + "            max-width: 600px;"
                    + "            margin: 0 auto;"
                    + "            padding: 20px;"
                    + "        }"
                    + "        .container {"
                    + "            border: 1px solid #e0e0e0;"
                    + "            border-radius: 5px;"
                    + "            padding: 20px 30px;"
                    + "        }"
                    + "        .header {"
                    + "            text-align: center;"
                    + "            color: #2e7d32;"
                    + "            font-size: 20px;"
                    + "            font-weight: bold;"
                    + "            margin-bottom: 20px;"
                    + "        }"
                    + "        .otp-container {"
                    + "            background-color: #f5f5f5;"
                    + "            padding: 15px;"
                    + "            text-align: center;"
                    + "            margin: 20px 0;"
                    + "            border-radius: 5px;"
                    + "        }"
                    + "        .otp-code {"
                    + "            font-size: 24px;"
                    + "            font-weight: bold;"
                    + "            color: #2e7d32;"
                    + "            letter-spacing: 5px;"
                    + "        }"
                    + "        p {"
                    + "            margin: 10px 0;"
                    + "        }"
                    + "        .footer {"
                    + "            margin-top: 20px;"
                    + "        }"
                    + "    </style>"
                    + "</head>"
                    + "<body>"
                    + "    <div class='container'>"
                    + "        <div class='header'>Namcombank - Xác thực tài khoản</div>"
                    + "        <p>Chào bạn,</p>"
                    + "        <p>Chúng tôi đã nhận được yêu cầu đăng nhập vào hệ thống của Namcombank. Để hoàn tất quá trình đăng nhập, vui lòng sử dụng mã xác thực dưới đây:</p>"
                    + "        <div class='otp-container'>"
                    + "            <div class='otp-code'>" + otpvalue + "</div>"
                    + "        </div>"
                    + "        <p>Mã này sẽ hết hạn sau 5 phút</p>"
                    + "        <p>Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email này hoặc liên hệ với bộ phận hỗ trợ.</p>"
                    + "        <div class='footer'>"
                    + "            <p>Trân trọng,<br>Đội ngũ hỗ trợ Namcombank</p>"
                    + "        </div>"
                    + "    </div>"
                    + "</body>"
                    + "</html>";

            // Thiết lập nội dung HTML
            message.setContent(htmlBody, "text/html; charset=UTF-8");

            // Send email
            Transport.send(message);

            LOGGER.log(Level.INFO, "OTP email sent successfully to {0}", to);
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Error sending email: " + e.getMessage(), e);
            throw e; // Rethrow exception to be handled by caller
        }
    }

    // Phương thức lấy email của nhân viên
    private String getStaffEmail(HttpSession session) {
        String staffEmail = "";

        // Ưu tiên lấy email từ session
        String sessionEmail = (String) session.getAttribute("email");
        if (sessionEmail != null && !sessionEmail.isEmpty()) {
            staffEmail = sessionEmail;
        } // Nếu không có trong session, lấy từ đối tượng Staff
        else {
            model.auth.Staff staff = (model.auth.Staff) session.getAttribute("account");
            if (staff != null && staff.getEmail() != null && !staff.getEmail().isEmpty()) {
                staffEmail = staff.getEmail();
            }
        }

        // Nếu vẫn không có, hiển thị thông báo
        if (staffEmail.isEmpty()) {
            staffEmail = "Email chưa được cấu hình";
        }

        return staffEmail;
    }

    // Phương thức kiểm tra trạng thái OTP
    private void checkOtpStatus(HttpServletRequest request, HttpSession session) {
        // Kiểm tra xem OTP đã được gửi chưa
        boolean otpSent = session.getAttribute("otp") != null;
        request.setAttribute("otpSent", otpSent);

        // Kiểm tra xem OTP có hết hạn chưa
        boolean otpExpired = false;
        if (session.getAttribute("otpExpiry") != null) {
            Long otpExpiry = (Long) session.getAttribute("otpExpiry");
            otpExpired = System.currentTimeMillis() > otpExpiry;

            if (otpExpired) {
                // Nếu OTP đã hết hạn, xóa khỏi session
                session.removeAttribute("otp");
                session.removeAttribute("otpExpiry");
            }
        }
        request.setAttribute("otpExpired", otpExpired);
    }
}
