<%--
    Document   : register
    Created on : Jan 23, 2025, 4:22:47 PM
    Author     : lenovo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank || Create New Customer</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/icon.jpg" type="image/gif" sizes="16x16">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/icon.jpg" type="image/gif" sizes="18x18">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/icon.jpg" type="image/gif" sizes="20x20">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/fontawesome.all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/magnific-popup.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css">
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
                            <h2>View Customer Info</h2>
                            <div class="col-12">
                                <div class="d-grid">
                                    <a href="manageCustomerVer2/Search"><button class="btn btn-primary btn-lg">Back to List Customers</button></a>
                                </div>
                            </div>
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

                            <form id="registerForm" action="viewCustomer" method="get">
                                <div class="row gy-3 overflow-hidden">
                                    <input type="hidden" name="customerId" value="${customer.customerId}">
                                    <div class="col-12">
                                        <div class="form-floating mb-3 text-center">
                                            <c:choose>
                                                <c:when test="${empty customer.avatar}">
                                                    <img src="${pageContext.request.contextPath}/assets/img/profile/default-avatar.png"
                                                         alt="Default Avatar"
                                                         width="120"
                                                         height="150"
                                                         style="object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/${customer.avatar}"
                                                         alt="${customer.fullname}'s avatar"
                                                         width="120"
                                                         height="150"
                                                         style="object-fit: cover;">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" name="fullnameC" id="fullname" placeholder="Full Name" value="${customer.fullname}" disabled>
                                            <label for="fullname" class="form-label">Full Name</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" name="usernameC" id="username" placeholder="Username" value="${customer.username}" disabled>
                                            <label for="username" class="form-label">Username</label>
                                        </div>
                                    </div>
                                    <!--                                    <div class="col-12">
                                                                            <div class="form-floating mb-3">
                                                                                <input type="text" class="form-control" name="passwordC" id="password" placeholder="Password" value="${customer.password}" disabled>
                                                                                <label for="password" class="form-label">Password</label>
                                                                            </div>
                                                                        </div>-->
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="email" class="form-control" name="emailC" id="email" placeholder="name@example.com" value="${customer.email}" disabled>
                                            <label for="email" class="form-label">Email</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="date" class="form-control" name="dobC" id="dob" placeholder="Date of Birth" value="${customer.dob}" disabled>
                                            <label for="dob" class="form-label">Date of Birth</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <select class="form-select" name="genderC" id="gender" disabled>
                                                <option value="">Select Gender</option>
                                                <option value="1" ${customer.gender == "1" ? "selected" : ""}>Male</option>
                                                <option value="0" ${customer.gender == "0" ? "selected" : ""}>Female</option>
                                            </select>
                                            <label for="gender" class="form-label">Gender</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="tel" class="form-control" name="phonenumberC" id="phonenumber"
                                                   value="${customer.phonenumber}" disabled>
                                            <label for="phonenumber" class="form-label">Phone Number</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="address" class="form-control" name="addressC" id="address" placeholder="Address"
                                                   value="${customer.address}" disabled>
                                            <label for="address" class="form-label">Address</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" name="cicC" id="citizenID" placeholder="Citizen Identification Card"
                                                   value="${customer.cid}" disabled>
                                            <label for="citizenID" class="form-label">Citizen Identification Card</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" name="balaceC" id="balance" placeholder="Balance" value="${customer.balance}" disabled>
                                            <label for="balance" class="form-label">Balance</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <select class="form-select" name="statusC" id="status" disabled>
                                                <option value="1" ${customer.active == "1" ? "selected" : ""}>Opening</option>
                                                <option value="0" ${customer.active == "0" ? "selected" : ""}>Closed</option>
                                            </select>
                                            <label for="status" class="form-label">Account Status</label>
                                        </div>
                                    </div>
                                </div>
                            </form>
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


</body>
</html>
