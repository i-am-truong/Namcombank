<%-- 
    Document   : changePass
    Created on : Jun 21, 2024, 11:14:44 AM
    Author     : chien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BulkShop - Electronics Shop HTML Template | Register</title>
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
    <!-- Start BreadCrumb Area -->
    <div class="breadcrumb-area pt-50 pb-50" style="background-image: url('assets/img/breadcrumb.jpg');">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-content">
                        <h2>Change Password</h2>
                        <ul>
                            <li><a href="login">Login</a></li>
                            <li class="active">Change Password</li>
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
                        <form action="changePass" method="post" onsubmit="return validateResetForm()">
                            <p style="color: #0061f2;">${requestScope.eee}</p>
                            <input type="text" class="form-control" name="username" id="username" value="${sessionScope.user.fullName}" readonly="">
                            <input type="password" class="form-control" name="oldpass" id="oldpass" placeholder="Enter old password">
                            <input type="password" class="form-control" name="pass" id="newpass" placeholder="Enter new password">
                            <input type="password" class="form-control" name="repass" id="repass" placeholder="Confirm password">
                            <p style="color: #0061f2;">${requestScope.err}</p>
                            <button class="button-1" id="resetBtn" type="submit">Reset Now</button>
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
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/script.js"></script>
    <script>
        function validateResetForm() {
            var pass = document.getElementById('newpass').value.trim();
            var repass = document.getElementById('repass').value.trim();
            var passRegex = /^(?=.*[a-z])(?=.*[A-Z]).{8,}$/;

            if (!passRegex.test(pass)) {
                alert('Password must be at least 8 characters, uppercase and lowercase');
                return false;
            } else if (!repass) {
                alert('Re-enter password cannot be empty');
                return false;
            } else if (pass !== repass) {
                alert('Passwords do not match');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
