<%-- 
    Document   : login
    Created on : Jan 23, 2025, 7:13:08 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  class="no-js" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank || Login</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/normalize.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <style>
            /* General styles */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            /* Header styles */
            .header {
                background-color: #064420;
                color: #fff;
                padding: 15px;
                text-align: center;
            }

            .header img {
                height: 50px;
            }

            .header h1 {
                margin: 0;
                text-align: center;
            }

            /* Navigation styles */
            nav {
                background-color: #064420;
                padding: 10px 0;
                text-align: center;
            }

            nav a {
                color: #fff;
                text-decoration: none;
                margin: 0 15px;
            }

            nav a:hover {
                text-decoration: underline;
            }

            /* Login form container */
            .login-container {
                width: 300px;
                margin: 50px auto;
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            /* Form styles */
            form {
                display: flex;
                flex-direction: column;
            }

            form input {
                margin-bottom: 15px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            form input:focus {
                border-color: #064420;
                outline: none;
            }

            form button {
                background-color: #064420;
                color: #fff;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
            }

            form button:hover {
                background-color: #04531a;
            }

            /* Footer styles */
            footer {
                text-align: center;
                padding: 10px;
                background-color: #064420;
                color: #fff;
            }


        </style>
    </head>
    <body>


        <div class="breadcrumb-area pt-50 pb-50" style="background-image: url('assets/img/breadcrumb2.png');">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb-content">
                            <h2>Login</h2>
                            <ul>
                                <li><a href="Home">Home</a></li>
                                <li class="active">Login</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Start Login Register Form -->
        <div class="login-register-form pt-60 pb-60" style="justify-content: center ; align-items:center; height: 70vh; ">

            <div class="container">

                <div class="row">
                    <div class="col-lg-5 offset-lg-4 text-center">
                        <div class="login-register-form-full"  style="background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);">
                            <h3 style="margin-bottom: 35px"><img src="assets/img/logo3.png"></h3>
                            <form action="admin.login" method="post">
                                <input type="text" class="form-control" id="email"  value="${username}" name="username" placeholder="Your Username" required>
                                <div id="email-error" class="error"></div>
                                <input type="password" class="form-control"  value="${password}" name="password" placeholder="Your Password" required>
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" ${(cookie.remem eq 'ON')?"checked":""} name="rem" style="transform: scale(0.75);" value="" id="flexCheckDefault">
                                            <label class="form-check-label" >Remember me</label></div>

                                    </div>
<!--                                    <div class="col-6 text-right">
                                        <a href="resetPass">Forgot password?</a>
                                    </div>-->
                                </div>
                                <p style="color: red">${requestScope.err}</p>
                                <button class="button-1" type="submit">Log In</button>
                            </form>
<!--                            <p>Don't Have an Account? <a href="register">Sign up now</a></p>
                        </div>-->
                    </div>
                </div>
            </div>
        </div>
        <!-- End Login Register Form -->





        <!-- Js File -->

        <script src="assets/js/jquery-3.5.1.min.js"></script>

        <script src="assets/js/script.js"></script>
        <script>
//            function checkEmailValidity() {
//                const input = document.getElementById("email");
//                const email = input.value.trim();
//
//                if (email === "") {
//                    input.setCustomValidity("Please input your email!");
//                } else if (!email.endsWith("@gmail.com")) {
//                    input.setCustomValidity("Please enter an email ending with @gmail.com");
//                } else {
//                    input.setCustomValidity("");
//                }
//            }
        </script>
    </body>
</html>