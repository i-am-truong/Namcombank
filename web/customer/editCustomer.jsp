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
                            <h2>Edit Customer Info</h2>
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

                            <form id="editCustomer" action="editCustomer" method="post">
                                <input type="hidden" name="customerId" value="${customer.customerId}">
                                <input type="hidden" name="avatar" value="${customer.avatar}">
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <div class="text-center">
                                           <c:choose>
                                        <c:when test="${empty customer.avatar}">
                                            <c:choose>
                                                <c:when test="${customer.gender == 1}">
                                                    <img src="${pageContext.request.contextPath}/assets/img/Male.jpg"
                                                         alt="Male Avatar"
                                                         width="120"
                                                         height="150">
                                                </c:when>
                                                <c:when test="${customer.gender == 0}">
                                                    <img src="${pageContext.request.contextPath}/assets/img/Female.jpg"
                                                         alt="Female Avatar"
                                                         width="120"
                                                         height="150">
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/${customer.avatar}"
                                                 alt="${customer.fullname}'s avatar"
                                                 width="120"
                                                 height="150">
                                        </c:otherwise>
                                    </c:choose>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="fullnameC">Full Name</label>
                                    <input type="text" class="form-control" id="fullnameC" name="fullnameC"
                                           value="${customer.fullname}" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="cidC">Citizen Identification Card</label>
                                    <input type="text" class="form-control" id="cidC" name="citizenIdC" maxlength="12"
                                           value="${customer.cid}" required>
                                </div>

                                <div class="form-group">
                                    <label for="phonenumberC">Phone Number</label>
                                    <input type="tel" class="form-control" id="phonenumberC" name="phonenumberC" maxlength="10"
                                           value="${customer.phonenumber}" required>
                                </div>

                                <div class="form-group">
                                    <label for="emailC">Email</label>
                                    <input type="email" class="form-control" id="emailC" name="emailC"
                                           value="${customer.email}" required>
                                </div>

                                <div class="form-group">
                                    <label for="addressC">Address</label>
                                    <input type="text" class="form-control" id="addressC" name="addressC"
                                           value="${customer.address}" required>
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
<!-- Add this JavaScript code before closing </body> tag -->

</body>
<html>
