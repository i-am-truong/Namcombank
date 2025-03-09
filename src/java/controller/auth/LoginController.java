package controller.auth;

import context.StaffAccountDBContext;
import context.StaffDAO;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.auth.Role;
import model.auth.Staff;

public class LoginController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginController.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String param_user = req.getParameter("username");
        String param_pass = req.getParameter("password");

        StaffAccountDBContext sdao = new StaffAccountDBContext();
        String pass = sdao.toSHA1(param_pass);

        StaffAccountDBContext db = new StaffAccountDBContext();
        model.auth.Staff account = db.get(param_user, pass);

        StaffAccountDBContext dbContext = new StaffAccountDBContext();
        ArrayList<Role> roles = dbContext.getRoles(param_user);

        if (account != null) {
            // Lấy email của nhân viên
            String email = null;
            try {
                // Nếu email trong đối tượng Staff có sẵn và không rỗng
                if (account.getEmail() != null && !account.getEmail().isEmpty()) {
                    email = account.getEmail();
                    LOGGER.log(Level.INFO, "Email lấy từ đối tượng Staff: {0}", email);
                } else {
                    // Nếu không, lấy từ cơ sở dữ liệu
                    email = dbContext.getStaffEmailByUsername(param_user);
                    LOGGER.log(Level.INFO, "Email lấy từ cơ sở dữ liệu: {0}", email);

                    // Cập nhật email vào đối tượng Staff nếu cần
                    if (email != null && !email.isEmpty()) {
                        account.setEmail(email);
                    }
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Lỗi khi lấy email cho người dùng: " + param_user, e);
            }

            // Kiểm tra xem có email không
            if (email == null || email.isEmpty()) {
                req.setAttribute("err", "Không tìm thấy email cho tài khoản này. Vui lòng liên hệ quản trị viên.");
                req.getRequestDispatcher("admin.login/login.jsp").forward(req, resp);
                return;
            }

            // Lưu tài khoản và email vào session
            HttpSession session = req.getSession();
            session.setAttribute("account", account);
            session.setAttribute("email", email);

            // Thêm staffId vào session
            session.setAttribute("staffId", account.getId());

            boolean hasValidRole = false;
            Integer roleId = null;
            String redirectAfterOTP = null;

            // Xác định vai trò và đường dẫn chuyển hướng sau khi xác thực OTP
            for (Role role : roles) {
                if ("Staff".equalsIgnoreCase(role.getName())) {
                    roleId = role.getId();
                    redirectAfterOTP = "contractApproval";
                    hasValidRole = true;
                    break;
                } else if (role.getId() == 1) { // Admin Role
                    roleId = role.getId();
                    redirectAfterOTP = "staffFilter";
                    hasValidRole = true;
                    break;
                } else if (role.getId() == 3) { // Head of Staff
                    roleId = role.getId();
                    redirectAfterOTP = "contractApproval";
                    hasValidRole = true;
                    break;
                } else if (role.getId() == 4) { // Accountant
                    roleId = role.getId();
                    redirectAfterOTP = "contractApproval";
                    hasValidRole = true;
                    break;
                }
            }

            if (hasValidRole) {
                // Lưu thông tin vai trò và đường dẫn chuyển hướng vào session
                session.setAttribute("roleId", roleId);
                session.setAttribute("redirectAfterOTP", redirectAfterOTP);

                // Tạo và gửi OTP ngay sau khi đăng nhập thành công
                try {
                    // Tạo OTP
                    String otpValue = generateOTP();

                    // Gửi OTP qua email
                    sendEmail(email, otpValue);

                    // Lưu OTP vào session
                    session.setAttribute("otp", otpValue);
                    session.setAttribute("otpExpiry", System.currentTimeMillis() + 300000); // 5 phút

                    // Chuyển hướng đến trang nhập OTP
                    resp.sendRedirect("verifyotp");

                } catch (MessagingException e) {
                    LOGGER.log(Level.SEVERE, "Lỗi khi gửi email OTP: " + e.getMessage(), e);
                    req.setAttribute("err", "Không thể gửi mã OTP. Vui lòng thử lại sau.");
                    req.getRequestDispatcher("admin.login/login.jsp").forward(req, resp);
                }
            } else {
                resp.sendRedirect("403.html");
            }
        } else {
            req.setAttribute("err", "Tên đăng nhập hoặc mật khẩu không đúng!");
            req.getRequestDispatcher("admin.login/login.jsp").forward(req, resp);
        }
    }

    // Phương thức tạo OTP
    private String generateOTP() {
        Random rand = new Random();
        StringBuilder otpValue = new StringBuilder(6);
        for (int i = 0; i < 6; i++) {
            otpValue.append(rand.nextInt(10)); // Tạo một chữ số ngẫu nhiên từ 0-9
        }
        return otpValue.toString();
    }

    // Phương thức gửi email OTP
    private void sendEmail(String to, String otpvalue) throws MessagingException {
        // Thiết lập thuộc tính email
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        // Thông tin tài khoản email gửi
        final String senderEmail = "doanvinhhung369@gmail.com"; // Thay bằng email của bạn
        final String senderPassword = "typj uudv rlzc yxzq"; // Thay bằng mật khẩu ứng dụng

        // Tạo phiên email với xác thực
        Session mailSession = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // Tạo thông điệp
            MimeMessage message = new MimeMessage(mailSession);

            // Thiết lập người gửi
            message.setFrom(new InternetAddress(senderEmail));

            // Thiết lập người nhận - email của nhân viên
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

            // Gửi email
            Transport.send(message);

            LOGGER.log(Level.INFO, "Email OTP đã được gửi thành công tới {0}", to);
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi gửi email: " + e.getMessage(), e);
            throw e; // Ném lại ngoại lệ để xử lý ở hàm gọi
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("admin.login/login.jsp").forward(req, resp);
    }
}
