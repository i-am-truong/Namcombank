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
        <title>Namcombank || Edit Customer Info</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/icon.jpg" type="image/gif" sizes="16x16">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/icon.jpg" type="image/gif" sizes="18x18">
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/icon.jpg" type="image/gif" sizes="20x20">

        <!-- CSS Files -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/normalize.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">

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

            /* Flex container for admin layout */
            .admin-container {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar styling */
            .sidebar {
                width: 200px;
                background-color: #28a745;
                color: white;
                min-height: 100vh;
                position: fixed;
                left: 0;
                top: 0;
                bottom: 0;
            }

            /* Main content area */
            .main-content {
                margin-left: 200px;
                width: calc(100% - 200px);
                padding: 20px;
            }

            /* Header styling */
            .admin-header {
                background-color: #f8f9fa;
                margin-left: 5px;
                margin-top: -20px;
                margin-right: -20px;
                margin-bottom: 5px;
                border-bottom: 1px solid #e3e6f0;
            }

            /* Form container */
            .form-container {
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                padding: 2rem;
                margin-top: 2rem;
            }
            
            /* Avatar styling */
            .avatar-container {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }
            
            .avatar-image {
                width: 120px;
                height: 150px;
                object-fit: cover;
                border-radius: 5px;
                border: 1px solid #ddd;
            }
        </style>
    </head>
    <body>
        <div class="admin-container">
            <!-- Sidebar -->
            <div class="sidebar">
                <jsp:include page="../homepage/sidebar_admin.jsp" />
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="admin-header">
                    <jsp:include page="../homepage/header_admin.jsp" />
                </div>

                <!-- Page Content -->
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="breadcrumb-content text-center">
                                <h2 class="mb-4">Edit Customer Info</h2>
                                <div class="col-12 d-flex justify-content-center">
                                    <a href="manageCustomerVer2/Search">
                                        <button class="btn btn-primary btn-lg">Back to List Customers</button>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Form Area -->
                <div class="login-register-form pt-4 pb-4">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-6 offset-lg-3">
                                <div class="form-container">
                                    <form id="editCustomer" action="editCustomer" method="post">
                                        <div class="row gy-3 overflow-hidden">
                                            <input type="hidden" name="customerId" value="${customer.customerId}">
                                            <input type="hidden" name="avatar" value="${customer.avatar}">
                                            
                                            <!-- Avatar Display -->
                                            <div class="col-12">
                                                <div class="avatar-container">
                                                    <c:choose>
                                                        <c:when test="${empty customer.avatar}">
                                                            <c:choose>
                                                                <c:when test="${customer.gender == 1}">
                                                                    <img src="${pageContext.request.contextPath}/assets/img/Male.jpg"
                                                                         alt="Male Avatar"
                                                                         class="avatar-image">
                                                                </c:when>
                                                                <c:when test="${customer.gender == 0}">
                                                                    <img src="${pageContext.request.contextPath}/assets/img/Female.jpg"
                                                                         alt="Female Avatar"
                                                                         class="avatar-image">
                                                                </c:when>
                                                            </c:choose>   
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/assets/img/Unknown.jpg"
                                                                 alt="${customer.fullname}'s avatar"
                                                                 class="avatar-image">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <input type="text" class="form-control" name="fullnameC" id="fullname" placeholder="Full Name" value="${customer.fullname}" readonly>
                                                    <label for="fullname" class="form-label">Full Name</label>
                                                </div>
                                            </div>
                                            
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <input type="text" class="form-control" name="citizenIdC" id="citizenID" placeholder="Citizen Identification Card"
                                                           value="${customer.cid}" required maxlength="12">
                                                    <label for="citizenID" class="form-label">Citizen Identification Card</label>
                                                </div>
                                            </div>
                                            
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <input type="tel" class="form-control" name="phonenumberC" id="phonenumber"
                                                           value="${customer.phonenumber}" required maxlength="10">
                                                    <label for="phonenumber" class="form-label">Phone Number</label>
                                                </div>
                                            </div>
                                            
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <input type="email" class="form-control" name="emailC" id="email" placeholder="name@example.com" value="${customer.email}" required>
                                                    <label for="email" class="form-label">Email</label>
                                                </div>
                                            </div>
                                            
                                            <div class="col-12">
                                                <div class="form-floating mb-3">
                                                    <input type="text" class="form-control" name="addressC" id="address" placeholder="Address"
                                                           value="${customer.address}" required>
                                                    <label for="address" class="form-label">Address</label>
                                                </div>
                                            </div>
                                            
                                            <div class="col-12 mt-3">
                                                <div class="d-grid">
                                                    <button type="submit" class="btn btn-success btn-lg">Update Customer</button>
                                                </div>
                                            </div>
                                            
                                            <!-- Add status messages -->
                                            <c:if test="${not empty error}">
                                                <div class="alert alert-danger mt-3">${error}</div>
                                            </c:if>
                                            <c:if test="${not empty success}">
                                                <div class="alert alert-success mt-3">${success}</div>
                                            </c:if>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JS Files -->
        <script src="assets/js/jquery-3.5.1.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/script.js"></script>
    </body>
</html>