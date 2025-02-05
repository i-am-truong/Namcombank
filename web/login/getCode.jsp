<%-- 
    Document   : getCode
    Created on : Jun 13, 2024, 2:52:33 PM
    Author     : lenovo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  class="no-js" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Banking Services System | Register</title>
        <link rel="icon" href="assets/img/icon.png" type="image/gif" sizes="16x16">
        <link rel="icon" href="assets/img/icon.png" type="image/gif" sizes="18x18">
        <link rel="icon" href="assets/img/icon.png" type="image/gif" sizes="20x20">

        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/normalize.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">

    </head>
    <body>




        <!--offcanvas menu area end-->
        <!-- End Mobile Menu Area -->
        <!-- Start BreadCrumb Area -->
        <div class="breadcrumb-area pt-50 pb-50" style="background-image: url('assets/img/breadcrumb.jpg');">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb-content">
                            <h2>Reset Password</h2>
                            <ul>
                                <li><a href="index.html">Home</a></li>
                                <li class="active">Reset Password</li>
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
                            <h3>Reset Password</h3>
                            <form action="getCode">
                                <div class="form-control-range"><input type="email" class="form-control" name="email" placeholder="Your Email"></div>


                                <p style="color: #0061f2; display: none;" id ="pls">Please check your email and enter the code!</p>
                                <input type="password" class="form-control" name="pass" id="code" placeholder="Enter Code" style="display: none">

                                <button class="button-1" id="getCodeBtn" type="submit">Get Code</button>
                                <button class="button-1" id="resetBtn" type="submit" style="display: none">Reset Now</button>
                            </form>

                        </div>
                    </div> 
                </div>
            </div>
        </div>
        <!-- End Login Register Form -->





        <div class="scroll-area">
            <i class="fa fa-angle-up"></i>
        </div>


        <!-- Js File -->
        <script src="assets/js/jquery-3.5.1.min.js"></script>

        <script src="assets/js/script.js"></script>
        <!--        <script>
                    document.getElementById('getCodeBtn').addEventListener('click', function () {
                        document.getElementById('code').style.display = 'block';
                        document.getElementById('getCodeBtn').style.display = 'none';
                        document.getElementById('resetBtn').style.display = 'block';
                        document.getElementById('pls').style.display = 'block';
        
                    });
                </script>-->
        <script>
            function checkEmailValidity() {
                const input = document.getElementById("email");
                const email = input.value.trim();

                if (email === "") {
                    input.setCustomValidity("Please input your email!");
                } else if (!email.endsWith("@gmail.com")) {
                    input.setCustomValidity("Please enter an email ending with @gmail.com");
                } else {
                    input.setCustomValidity("");
                }
            }
        </script>
    </body>
</html>