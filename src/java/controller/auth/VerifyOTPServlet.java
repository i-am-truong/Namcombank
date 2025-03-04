package controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
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
            response.sendRedirect("login");
            return;
        }
        
        // Kiểm tra xem OTP đã được gửi chưa
        if (session.getAttribute("otp") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Chuyển hướng đến trang nhập OTP
        request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userOtp = request.getParameter("otp");
        HttpSession session = request.getSession();
        
        String storedOtp = (String) session.getAttribute("otp");
        Long otpExpiry = (Long) session.getAttribute("otpExpiry");
        String redirectAfterOTP = (String) session.getAttribute("redirectAfterOTP");
        
        // Kiểm tra xem OTP có tồn tại và chưa hết hạn không
        if (storedOtp == null || otpExpiry == null) {
            request.setAttribute("error", "Phiên OTP đã hết hạn. Vui lòng yêu cầu mã OTP mới.");
            request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra xem OTP đã hết hạn chưa
        if (System.currentTimeMillis() > otpExpiry) {
            session.removeAttribute("otp");
            session.removeAttribute("otpExpiry");
            request.setAttribute("error", "Mã OTP đã hết hạn. Vui lòng yêu cầu mã OTP mới.");
            request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
            return;
        }
        
        // Xác thực OTP
        if (storedOtp.equals(userOtp)) {
            // OTP đã được xác thực thành công
            session.setAttribute("otpVerified", true);
            
            // Xóa dữ liệu OTP
            session.removeAttribute("otp");
            session.removeAttribute("otpExpiry");
            session.removeAttribute("otpSent");
            
            LOGGER.log(Level.INFO, "OTP xác thực thành công. Chuyển hướng đến {0}", redirectAfterOTP);
            
            // Chuyển hướng đến trang tương ứng dựa trên vai trò
            if (redirectAfterOTP != null && !redirectAfterOTP.isEmpty()) {
                response.sendRedirect(redirectAfterOTP);
            } else {
                // Chuyển hướng mặc định nếu không có trang cụ thể
                response.sendRedirect("dashboard");
            }
        } else {
            // OTP không hợp lệ
            request.setAttribute("error", "Mã OTP không đúng. Vui lòng thử lại.");
            request.getRequestDispatcher("admin.login/two-factor-auth.jsp").forward(request, response);
        }
    }
}
