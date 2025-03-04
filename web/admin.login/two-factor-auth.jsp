<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Namcombank || Xác thực hai lớp</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/normalize.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        /* CSS styles remain the same */
        /* ... */
    </style>
</head>
<body>
    <div class="breadcrumb-area pt-50 pb-50" style="background-image: url('assets/img/breadcrumb2.png');">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-content">
                        <h2>Xác thực hai lớp</h2>
                        <ul>
                            <li><a href="Home">Home</a></li>
                            <li class="active">Xác thực</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Start Two-Factor Authentication Form -->
    <div class="login-register-form pt-60 pb-60" style="justify-content: center; align-items:center; min-height: 70vh;">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3 text-center">
                    <div class="login-register-form-full" style="background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);">
                        <div class="logo-container">
                            <img src="assets/img/logo3.png" alt="Namcombank Logo">
                        </div>
                        
                        <h3>Xác thực bảo mật</h3>
                        
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="error-message" style="color: #e74c3c; margin: 10px 0; padding: 10px; background-color: #fde8e8; border-left: 4px solid #e74c3c; border-radius: 4px;">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        
                        <% if(request.getAttribute("success") != null) { %>
                            <div class="success-message" style="color: #2ecc71; margin: 10px 0; padding: 10px; background-color: #e8f8f0; border-left: 4px solid #2ecc71; border-radius: 4px;">
                                <%= request.getAttribute("success") %>
                            </div>
                        <% } %>
                        
                        <% 
                            // Lấy đối tượng Staff từ session
                            model.auth.Staff staff = (model.auth.Staff)session.getAttribute("account");
                            String staffEmail = "";
                            
                            // Ưu tiên lấy email từ session
                            String sessionEmail = (String)session.getAttribute("email");
                            if (sessionEmail != null && !sessionEmail.isEmpty()) {
                                staffEmail = sessionEmail;
                            }
                            // Nếu không có trong session, lấy từ đối tượng Staff
                            else if (staff != null && staff.getEmail() != null && !staff.getEmail().isEmpty()) {
                                staffEmail = staff.getEmail();
                            }
                            
                            // Nếu vẫn không có, hiển thị thông báo
                            if (staffEmail.isEmpty()) {
                                staffEmail = "Email chưa được cấu hình";
                            }
                            
                            // Kiểm tra xem OTP đã được gửi chưa
                            boolean otpSent = session.getAttribute("otp") != null;
                            
                            // Kiểm tra xem OTP có hết hạn chưa
                            boolean otpExpired = false;
                            if (session.getAttribute("otpExpiry") != null) {
                                Long otpExpiry = (Long) session.getAttribute("otpExpiry");
                                otpExpired = System.currentTimeMillis() > otpExpiry;
                            }
                        %>
                        
                        <div class="email-display" style="background-color: #f9f9f9; padding: 10px; border: 1px solid #ddd; border-radius: 5px; margin-bottom: 15px; font-size: 14px;">
                            <strong style="color: #064420;">Email xác thực:</strong> <%= staffEmail %>
                        </div>
                        
                        <% if (otpExpired) { %>
                            <div class="warning-message" style="color: #f39c12; margin: 15px 0; padding: 10px; background-color: #fef5e7; border-left: 4px solid #f39c12; border-radius: 4px;">
                                Mã OTP đã hết hạn. Vui lòng yêu cầu mã OTP mới.
                            </div>
                            <form action="sendotp" method="post">
                                <button class="button-1" style="background-color: #064420; color: #fff; border: none; padding: 12px; border-radius: 5px; cursor: pointer; margin-bottom: 10px; font-weight: bold; width: 100%;" type="submit">Gửi mã OTP mới</button>
                            </form>
                        <% } else if (otpSent) { %>
                            <div class="info-message" style="color: #3498db; margin: 15px 0; padding: 10px; background-color: #e8f4fd; border-left: 4px solid #3498db; border-radius: 4px;">
                                Mã OTP đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư đến.
                                <br><small>Mã OTP có hiệu lực trong 5 phút.</small>
                            </div>
                            
                            <form action="verifyotp" method="post">
                                <input type="text" class="form-control" id="otp" name="otp" placeholder="Nhập mã OTP 6 số" required maxlength="6" pattern="[0-9]{6}" style="margin-bottom: 15px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; width: 100%;" autofocus>
                                <button class="button-1" style="background-color: #064420; color: #fff; border: none; padding: 12px; border-radius: 5px; cursor: pointer; margin-bottom: 10px; font-weight: bold; width: 100%;" type="submit">Xác thực</button>
                            </form>
                            
                            <form action="sendotp" method="post">
                                <button class="button-1 resend-button" style="background-color: #2196F3; color: #fff; border: none; padding: 12px; border-radius: 5px; cursor: pointer; margin-bottom: 10px; font-weight: bold; width: 100%;" type="submit">Gửi lại OTP</button>
                            </form>
                        <% } else { %>
                            <div class="info-message" style="color: #3498db; margin: 15px 0; padding: 10px; background-color: #e8f4fd; border-left: 4px solid #3498db; border-radius: 4px;">
                                Hệ thống sẽ gửi mã OTP đến email của bạn. Vui lòng đợi trong giây lát...
                            </div>
                            <form action="sendotp" method="post">
                                <button class="button-1" style="background-color: #064420; color: #fff; border: none; padding: 12px; border-radius: 5px; cursor: pointer; margin-bottom: 10px; font-weight: bold; width: 100%;" type="submit">Gửi mã OTP</button>
                            </form>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Two-Factor Authentication Form -->

    <!-- Js File -->
    <script src="assets/js/jquery-3.5.1.min.js"></script>
    <script src="assets/js/script.js"></script>
</body>
</html>
