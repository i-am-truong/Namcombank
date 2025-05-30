<%-- 
    Document   : register
    Created on : Jan 23, 2025, 4:22:47 PM
    Author     : lenovo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Thêm thư viện Flatpickr -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

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
                                            <input type="date" class="form-control" name="dobC" id="dob" placeholder="Date of Birth">
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
                                            <input type="address" class="form-control" name="addressC" id="address" placeholder="Address" 
                                                   value="${param.addressC != null ? param.addressC : ''}">
                                            <label for="address" class="form-label">Address</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" name="cicC" id="citizenID" placeholder="Citizen Identification Card" 
                                                   value="${param.cicC != null ? param.cicC : ''}">
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
            var phonenumberRegex = /^(09|03)[0-9]{8}$/; // Phone must start with 09 or 03 and have 10 digits
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
                errorMessage += 'Phone number must start with 09 or 03 and have 10 digits.\n';
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
            } else {
                // Validate that DOB is not today's date
                var today = new Date();
                var dobDate = new Date(dob);
                today.setHours(0, 0, 0, 0); // Reset time to compare only dates

                if (dobDate >= today) {
                    errorMessage += 'Date of birth cannot be today or in the future.\n';
                    isValid = false;
                }
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
