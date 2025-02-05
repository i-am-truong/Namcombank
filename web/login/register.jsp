<%-- 
    Document   : register
    Created on : Jan 23, 2025, 4:22:47 PM
    Author     : chien
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank || Register</title>
        <link rel="icon" href="assets/img/icon.jpg" type="image/gif" sizes="16x16">
        <link rel="icon" href="assets/img/icon.jpg" type="image/gif" sizes="18x18">
        <link rel="icon" href="assets/img/icon.jpg" type="image/gif" sizes="20x20">

        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/normalize.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
        <style>
            /* Nút */
            .button-1 {
                background-color: #28a745; /* Màu xanh lá cây đậm */
                color: #ffffff;
                border: 2px solid #28a745;
            }

            .button-1:hover {
                background-color: #218838; /* Màu xanh lá cây đậm hơn khi hover */
                border-color: #1e7e34;
            }

            /* Tiêu đề */
            h2, h3, h4, .section-headding-1 span {
                color: #28a745; /* Màu xanh lá cây đậm */
            }

            /* Liên kết */
            a {
                color: #28a745; /* Màu xanh lá cây đậm */
            }

            a:hover {
                color: #218838; /* Màu xanh lá cây đậm hơn khi hover */
                text-decoration: underline;
            }

            /* Nền */
            .hero-slider-single {
                background-color: #81c784; /* Màu xanh lá cây nhạt */
            }

            /* Thanh điều hướng */
            .offcanvas_main_menu li a {
                color: #28a745; /* Màu xanh lá cây đậm */
            }

            .offcanvas_main_menu li a:hover {
                color: #218838; /* Màu xanh lá cây đậm hơn khi hover */
            }

        </style>

    </head>
    <body>

        <!--offcanvas menu area end-->
        <!-- End Mobile Menu Area -->
        <!-- Start BreadCrumb Area -->
        <div class="breadcrumb-area pt-50 pb-50" style="background-image: url('assets/img/breadcrumb.png');">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb-content">
                            <h2>Register Account</h2>
                            <ul>
                                <li><a href="login">Login</a></li>
                                <li class="active">Register</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End BreadCrumb Area -->

        <!-- Start Login Register Form -->
        <div class="login-register-form pt-70 pb-70">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 offset-lg-3">
                        <div class="login-register-form-full">

                            <form id="registerForm" action="register" method="post">
                                <div class="row gy-3 overflow-hidden">
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" name="fullnameC" id="fullname" placeholder="Full Name" value="${param.fullnameC != null ? param.fullnameC : ''}" >
                                            <label for="fullname" class="form-label">Full Name</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" name="usernameC" id="username" placeholder="Username" value="${param.usernameC != null ? param.usernameC : ''}" >
                                            <label for="username" class="form-label">Username</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="password" class="form-control" name="passwordC" id="password" placeholder="Password" value="${param.passwordC != null ? param.passwordC : ''}" >
                                            <label for="password" class="form-label">Password</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="password" class="form-control" name="confirmPasswordC" id="confirmPassword" placeholder="Confirm Password" value="${param.confirmPasswordC != null ? param.confirmPasswordC : ''}" >
                                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="email" class="form-control" name="emailC" id="email" placeholder="name@example.com" value="${param.emailC != null ? param.emailC : ''}" >
                                            <label for="email" class="form-label">Email</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="date" class="form-control" name="dobC" id="dob" placeholder="Date of Birth" >
                                            <label for="dob" class="form-label">Date of Birth</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <select class="form-select" name="genderC" id="gender" required>
                                                <option value="">Select Gender</option>
                                                <option value="1" ${param.genderC == "1" ? "selected" : ""}>Male</option>
                                                <option value="2" ${param.genderC == "2" ? "selected" : ""}>Female</option>
                                                <option value="3" ${param.genderC == "3" ? "selected" : ""}>Other</option>

                                            </select>
                                            <label for="gender" class="form-label">Gender</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="tel" class="form-control" name="phonenumberC" id="phonenumber"
                                                   value="${param.phonenumberC != null ? param.phonenumberC : ''}" >
                                            <label for="phonenumber" class="form-label">Phone Number</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="address" class="form-control" name="addressC" id="address" placeholder="Address" >
                                            <label for="address" class="form-label">Address</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" name="cicC" id="citizenID" placeholder="Citizen Identification Card" maxlength="15" >
                                            <label for="citizenID" class="form-label">Citizen Identification Card</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="" name="iAgree" id="iAgree" required>
                                            <label class="form-check-label text-dark" for="iAgree">
                                                I agree to the <a href="#!" class="link-success text-decoration-none">terms and conditions</a>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="d-grid">
                                            <button class="btn btn-success btn-lg" id="resetBtn" type="submit">Sign up</button>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>
                                <c:if test="${not empty suc}">
                                    <div class="alert alert-success">${suc}</div>
                                </c:if>
                            </form>
                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-end mt-4">
                                        <p class="m-0 text-dark text-center">Already have an account? <a href="login" class="link-success text-decoration-none">Sign in</a></p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <p class="mt-4 mb-4" style="text-align: center">Or continue with</p>
                                    <div class="d-flex gap-2 gap-sm-3 justify-content-center">
                                        <a href="#!" class="btn btn-outline-danger bsb-btn-circle bsb-btn-circle-2xl">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16">
                                            <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                                            </svg>
                                        </a>
                                        <a href="#!" class="btn btn-outline-primary bsb-btn-circle bsb-btn-circle-2xl">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-facebook" viewBox="0 0 16 16">
                                            <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z" />
                                            </svg>
                                        </a>
                                        <a href="#!" class="btn btn-outline-dark bsb-btn-circle bsb-btn-circle-2xl">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-apple" viewBox="0 0 16 16">
                                            <path d="M11.182.008C11.148-.03 9.923.023 8.857 1.18c-1.066 1.156-.902 2.482-.878 2.516.024.034 1.52.087 2.475-1.258.955-1.345.762-2.391.728-2.43Zm3.314 11.733c-.048-.096-2.325-1.234-2.113-3.422.212-2.189 1.675-2.789 1.698-2.854.023-.065-.597-.79-1.254-1.157a3.692 3.692 0 0 0-1.563-.434c-.108-.003-.483-.095-1.254.116-.508.139-1.653.589-1.968.607-.316.018-1.256-.522-2.267-.665-.647-.125-1.333.131-1.824.328-.49.196-1.422.754-2.074 2.237-.652 1.482-.311 3.83-.067 4.56.244.729.625 1.924 1.273 2.796.576.984 1.34 1.667 1.659 1.899.319.232 1.219.386 1.843.067.502-.308 1.408-.485 1.766-.472.357.013 1.061.154 1.782.539.571.197 1.111.115 1.652-.105.541-.221 1.324-1.059 2.238-2.758.347-.79.505-1.217.473-1.282Z" />
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>

    <!-- JS File -->
    <script src="assets/js/jquery-3.5.1.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/script.js"></script>

    <script>
        document.getElementById('registerForm').addEventListener('submit', function (event) {
            var fullname = document.getElementById('fullname').value.trim();
            var phonenumber = document.getElementById('phonenumber').value.trim();
            var email = document.getElementById('email').value.trim();
            var address = document.getElementById('address').value.trim();
            var dob = document.getElementById('dob').value.trim();
            var username = document.getElementById('username').value.trim();
            var password = document.getElementById('password').value.trim();
            var confirmPassword = document.getElementById('confirmPassword').value.trim();
            var cic = document.getElementById('citizenID').value.trim();

            // Regex Patterns
            var phonenumberRegex = /^0[0-9]{9,10}$/; // Phone must start with 0 and be 10-11 digits
            var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            var addressRegex = /^[A-Za-z0-9\s,.'-]{3,}$/;
            var usernameRegex = /^[A-Za-z0-9_\.]+$/;
            var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z]).{8,}$/; // At least 1 uppercase, 1 lowercase, min 8 chars
            var cicRegex = /^[0-9]{9,12}$/; // Chỉ cho phép số, 9 hoặc 12 chữ số

            var isValid = true;
            var errorMessage = '';
            if (!fullname) {
                errorMessage += 'Name cannot be empty.\n';
                isValid = false;
            }
            if (!phonenumber) {
                errorMessage += 'Phone number cannot be empty.\n';
                isValid = false;
            } else if (!phonenumberRegex.test(phonenumber)) {
                errorMessage += 'Phone number must be 10-11 digits and start with 0.\n';
                isValid = false;
            }
            if (!email) {
                errorMessage += 'Email cannot be empty.\n';
                isValid = false;
            } else if (!emailRegex.test(email)) {
                errorMessage += 'Invalid email format.\n';
                isValid = false;
            }
            if (!address) {
                errorMessage += 'Address cannot be empty.\n';
                isValid = false;
            } else if (!addressRegex.test(address)) {
                errorMessage += 'Invalid address format.\n';
                isValid = false;
            }
            if (!dob) {
                errorMessage += 'Date of birth cannot be empty.\n';
                isValid = false;
            }
            if (!username) {
                errorMessage += 'Username cannot be empty.\n';
                isValid = false;
            } else if (!usernameRegex.test(username)) {
                errorMessage += 'Username can only contain letters, numbers, dots, and underscores.\n';
                isValid = false;
            }
            if (!password) {
                errorMessage += 'Password cannot be empty.\n';
                isValid = false;
            } else if (!passwordRegex.test(password)) {
                errorMessage += 'Password must have at least 8 characters, including an uppercase and lowercase letter.\n';
                isValid = false;
            }
            if (!confirmPassword) {
                errorMessage += 'Confirm password cannot be empty.\n';
                isValid = false;
            } else if (confirmPassword !== password) {
                errorMessage += 'Confirm password does not match.\n';
                isValid = false;
            }
            if (!cic) {
                errorMessage += 'Citizen Identification Card cannot be empty\n';
                isValid = false;
            } else if (!cicRegex.test(cic)) {
                errorMessage += 'Invalid Citizen Identification Card. It must be 9 or 12 digits.\n';
                isValid = false;
            }

            if (!isValid) {
                event.preventDefault(); // Prevent form submission
                alert(errorMessage);
            }
        });
    </script>



</body>
</html>
