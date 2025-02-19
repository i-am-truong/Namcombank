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

                                <div class="form-group">
                                    <label for="fullnameC">Full Name</label>
                                    <input type="text" class="form-control" id="fullnameC" name="fullnameC"
                                           value="${customer.fullname}" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="cidC">Citizen Identification Card</label>
                                    <input type="text" class="form-control" id="cidC" name="citizenIdC"
                                           value="${customer.cid}" required pattern="^0\d{11}$"  title="Citizen ID must be exactly 12 digits and start with 0" maxlength="12">
                                </div>

                                <div class="form-group">
                                    <label for="phonenumberC">Phone Number</label>
                                    <input type="tel" class="form-control" id="phonenumberC" name="phonenumberC"
                                           value="${customer.phonenumber}" required pattern="^0[0-9]{9}$" title="Phone number must start with 0 and have exactly 10 digits." maxlength="10">
                                </div>

                                <div class="form-group">
                                    <label for="emailC">Email</label>
                                    <input type="email" class="form-control" id="emailC" name="emailC"
                                           value="${customer.email}" required pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Enter a valid email.">
                                </div>

                                <div class="form-group">
                                    <label for="addressC">Address</label>
                                    <input type="text" class="form-control" id="addressC" name="addressC"
                                           value="${customer.address}" required>
                                </div>

                                <div class="form-group">
                                    <label for="dobC">Date of Birth</label>
                                    <input type="date" class="form-control" id="dobC" name="dobC"
                                           value="${customer.dob}">
                                </div>

                                <div class="form-group">
                                    <label for="genderC">Gender</label>
                                    <select class="form-control" id="genderC" name="genderC" required>
                                        <option value="1" ${customer.gender == 1 ? 'selected' : ''}>Male</option>
                                        <option value="0" ${customer.gender == 0 ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-success btn-lg">Update Customer</button>
                                    </div>
                                </div>
                            </form>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>
                            <c:if test="${not empty success}">
                                <div class="alert alert-success">${success}</div>
                            </c:if>
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
        document.getElementById('editCustomer').addEventListener('submit', function (event) {
            // Always prevent default form submission first
            event.preventDefault();

            // Get form values
            var phone = document.getElementById('phonenumberC').value.trim();
            var email = document.getElementById('emailC').value.trim();
            var cid = document.getElementById('cidC').value.trim();
            var dob = document.getElementById('dobC').value.trim();

            // Regular expressions for validation
            var phoneRegex = /^(09|08|03)[0-9]{8}$/;
            var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            var cidRegex = /^0\d{11}$/;

            var errors = [];

            // Validate phone number
            if (!phoneRegex.test(phone)) {
                errors.push('Phone number must start with 09 or 08 or 03 and have exactly 10 digits');
            }

            // Validate email
            if (!emailRegex.test(email)) {
                errors.push('Invalid email format');
            }

            // Validate CIC
            if (!cidRegex.test(cid)) {
                errors.push('Citizen ID must start with 0 and have exactly 12 digits');
            }

            // Validate date of birth
            var dobDate = new Date(dob);
            var today = new Date();
            today.setHours(0, 0, 0, 0); // Reset time portion

            // Calculate age
            var age = today.getFullYear() - dobDate.getFullYear();
            var month = today.getMonth() - dobDate.getMonth();
            if (month < 0 || (month === 0 && today.getDate() < dobDate.getDate())) {
                age--;
            }

            if (dobDate >= today) {
                errors.push('Date of birth cannot be today or in the future');
            } else if (age < 18) {
                errors.push('Customer must be at least 18 years old');
            } else if (age > 100) {
                errors.push('Invalid date of birth (age cannot exceed 100 years)');
            }

            // If there are any validation errors
            if (errors.length > 0) {
                alert(errors.join('\n'));
                return false; // Prevent form submission
            }

            // If all validations pass, submit the form
            this.submit();
        });
    </script>

</body>
</html>
