<%-- 
    Document   : cart
    Created on : 07/07/2024, 8:28:36 AM
    Author     : ADMIN
--%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  class="no-js" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Clothes Shop</title>
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
        <script type="text/javascript">
            function removeProduct(pid) {
                var result = confirm("Confirm remove this product?");
                var totalAmountElement = document.querySelector('.total-amount');

                var pId = pid;
                var element = document.getElementById(pid);
                if (result) {
                    $.ajax({
                        type: 'POST',
                        data: {pId: pId},
                        url: 'cartView',
                        success: (result) => {
                            element.remove();
                            var totalPrice = result.totalPrice;
                            var productInCart = result.productInCart;
                            $('.counter').text(productInCart);
                            totalAmountElement.textContent = totalPrice + "$";
                        },
                        error: function () {
                            console.log('Remove fail something went wrong');
                        }
                    });
                }
            }

        </script>
    </head>
    <body>
        <div id="preloader" class="preeloader">
            <div class="sk-circle">
                <div class="sk-circle1 sk-child"></div>
                <div class="sk-circle2 sk-child"></div>
                <div class="sk-circle3 sk-child"></div>
                <div class="sk-circle4 sk-child"></div>
                <div class="sk-circle5 sk-child"></div>
                <div class="sk-circle6 sk-child"></div>
                <div class="sk-circle7 sk-child"></div>
                <div class="sk-circle8 sk-child"></div>
                <div class="sk-circle9 sk-child"></div>
                <div class="sk-circle10 sk-child"></div>
                <div class="sk-circle11 sk-child"></div>
                <div class="sk-circle12 sk-child"></div>
            </div>
        </div>
        <div class="off_canvars_overlay"></div>
        <!-- Header -->
        <header class="header">
            <!-- Header Top -->

            <!-- Header Middle -->
            <%@include file="../homepage/header.jsp" %>
            <!-- Header Bottom -->
            <div class="d-flex justify-content-between align-items-center mb-3">

            </div>

        </header>
        <!-- Header -->
        <div class="breadcrumb-area pt-100 pb-100" style="background-image: url('assets/img/breadcrumb.jpg');">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb-content">
                            <h2>Profile</h2>
                            <ul>
                                <li><a href="Home">Home</a></li>
                                <li class="active">User Profile</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container" style="margin-top: 50px; margin-bottom: 100px">
            <div class="main-body">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <c:if test="${sessionScope.user.gender == 0}">
                                    <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="Admin" class="rounded-circle p-1 bg-primary" width="110">
                                    </c:if>
                                    <c:if test="${sessionScope.user.gender == 1}">
                                    <img src="https://bootdey.com/img/Content/avatar/avatar6.png" alt="Admin" class="rounded-circle p-1 bg-primary" width="110">
                                    </c:if>
                                    <div class="mt-3">
                                        <h4>${sessionScope.user.fullName}</h4>
                                               <hr class="my-4">
                                        <button class="btn btn-primary">Follow</button>
                                        <button class="btn btn-outline-primary">Message</button>
                                    </div>
                                </div>
                        

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 container" style="margin-left: 100px">            



                        <form id="profile-form" action="userProfile" method="post">
                            <div class="col-md-9">
                                <label class="labels">Full Name</label>
                                <input 
                                    name="fullName"
                                    required 
                                    type="text" 
                                    class="form-control" 
                                    placeholder="enter full name" 
                                    maxlength="50"
                                    pattern=".+\S+.*" 
                                    title="Full Name cannot be just spaces."
                                    value="${sessionScope.user.fullName}"
                                    >
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Phone Number</label>
                                <input 
                                    name="phoneNumber"
                                    required 
                                    type="text" 
                                    class="form-control" 
                                    placeholder="enter phone number" 
                                    pattern="\d{10}" 
                                    title="Please enter a valid 10-digit phone number"
                                    value="${sessionScope.user.phone}"
                                    >
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Email</label>
                                <input 
                                    name="email"
                                    type="email" 
                                    id="email-input" 
                                    class="form-control" 
                                    placeholder="enter email" 
                                    required
                                    maxlength="50"
                                    value="${sessionScope.user.email}"
                                    >
                                <div id="email-error" style="color: red; display: none;">Please enter a valid email address.</div>
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Address</label>
                                <input 
                                    name="address"
                                    required 
                                    type="text" 
                                    class="form-control" 
                                    placeholder="enter address" 
                                    maxlength="50"
                                    pattern=".+\S+.*" 
                                    title="Address cannot be just spaces."
                                    value="${sessionScope.user.address}"
                                    >
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Gender</label>
                                <c:if test="${sessionScope.user.gender == 1}">
                                    <select name="gender" class="form-control" required>
                                        <option value="" disabled selected>Select gender</option>
                                        <option selected value="male">Male</option>
                                        <option value="female">Female</option>
                                    </select>
                                </c:if>
                                <c:if test="${sessionScope.user.gender == 0}">
                                    <select name="gender" class="form-control" required>
                                        <option value="" disabled selected>Select gender</option>
                                        <option  value="male">Male</option>
                                        <option selected value="female">Female</option>
                                    </select>
                                </c:if>
                                <c:if test="${sessionScope.user.gender != 1 && sessionScope.user.gender != 2} ">
                                    <select name="gender" class="form-control" required>
                                        <option value="" disabled selected>Select gender</option>
                                        <option  value="male">Male</option>
                                        <option  value="female">Female</option>
                                    </select>
                                </c:if>
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Date of birth</label>
                                <input 
                                    name="dateOfBirth"
                                    required 
                                    type="date" 
                                    class="form-control" 
                                    placeholder="enter date of birth" 
                                    max=""
                                    value="${sessionScope.user.dob}"
                                    >
                            </div>

                            <div class="mt-3 text-left" style="display: flex; justify-content: flex-start; align-items: center;">
                                <button class="btn btn-primary profile-button" type="submit" style="margin-right: 10px;">Save Profile</button>
                                <a href="changePass" style="margin-left: 100px" class="btn btn-primary profile-button" type="button">Change Password</a>
                            </div>
                        </form>
                        

                    </div>


                </div>
            </div>
        </div>

        <!-- Start Footer Area -->
        <%@include file="../homepage/footer.jsp" %>

        <!-- End Footer Area -->




        <div class="scroll-area">
            <i class="fa fa-angle-up"></i>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Lấy ngày hiện tại theo định dạng YYYY-MM-DD
                var today = new Date().toISOString().split('T')[0];

                // Cập nhật thuộc tính max của input[type="date"]
                document.querySelector('input[type="date"]').setAttribute('max', today);
            });
            document.getElementById('profile-form').addEventListener('submit', function (event) {

                this.submit();
            });
        </script>

        <!-- Js File -->
        <script src="assets/js/modernizr.min.js"></script>
        <script src="assets/js/jquery-3.5.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/owl.carousel.min.js"></script>
        <script src="assets/js/jquery.nav.min.js"></script>
        <script src="assets/js/jquery.magnific-popup.min.js"></script>
        <script src="assets/js/mixitup.min.js"></script>
        <script src="assets/js/wow.min.js"></script>
        <script src="assets/js/script.js"></script>
        <script src="assets/js/mobile-menu.js"></script>
    </body>
</html>
