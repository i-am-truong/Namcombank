<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Staff Profile - Namcombank</title>
        <link rel="icon" href="assets/img/icon.png" type="image/gif" sizes="16x16">
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
        <!-- Header -->
        <%@include file="../homepage/header_admin.jsp" %>

        <c:if test="${sessionScope.account == null}">
            <c:redirect url="admin.login"/>
        </c:if>
        <div class="container" style="margin-top: 50px; margin-bottom: 100px">
            <div class="main-body">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <div class="mt-3">
                                        <h4>${sessionScope.account.fullname}</h4>
                                        <button class="btn btn-danger">Follow</button>
                                        <button class="btn btn-outline-danger">Message</button>
                                        <hr class="my-4">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 container" style="margin-left: 100px">
                        <form id="profile-form" action="staffProfile" method="post" enctype="">
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
                                    value="${sessionScope.account.fullname}"
                                    >
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Phone Number</label>
                                <input
                                    name="phoneS"
                                    required
                                    type="text"
                                    class="form-control"
                                    placeholder="enter phone number"
                                    pattern="^0[0-9]{9,10}$"
                                    title="Please enter a valid phone number starting with 0"
                                    value="${sessionScope.account.phonenumber}"
                                    >
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Email</label>
                                <input
                                    name="emailS"
                                    type="email"
                                    class="form-control"
                                    placeholder="enter email"
                                    required
                                    maxlength="50"
                                    value="${sessionScope.account.email}"
                                    >
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Address</label>
                                <input
                                    name="addressS"
                                    required
                                    type="text"
                                    class="form-control"
                                    placeholder="enter address"
                                    maxlength="50"
                                    pattern=".+\S+.*"
                                    title="Address cannot be just spaces."
                                    value="${sessionScope.account.address}"
                                    >
                            </div>

                            <div class="col-md-9">
                                <label class="labels">CIC</label>
                                <input
                                    name="cicS"
                                    required
                                    type="text"
                                    class="form-control"
                                    placeholder="Enter CIC (12 digits)"
                                    maxlength="12"
                                    pattern="^\d{12}$"
                                    title="CIC must be exactly 12 digits."
                                    value="${sessionScope.account.citizenId}"
                                    >
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Gender</label>
                                <select name="genderS" class="form-control" required>
                                    <option value="1" ${sessionScope.account.gender ? "selected" : ""}>Male</option>
                                    <option value="0" ${!sessionScope.account.gender ? "selected" : ""}>Female</option>
                                </select>
                            </div>

                            <div class="col-md-9">
                                <label class="labels">Date of Birth</label>
                                <input
                                    name="dobS"
                                    required
                                    type="date"
                                    class="form-control"
                                    value="${sessionScope.account.dob}"
                                    max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                                    >
                            </div>

                            <!--<div class="col-md-9">
                                <label>Department:</label>
                                <select class="form-control" name="did">
                            <c:forEach var="dept" items="${depts}">
                                <option value="${dept.id}" ${staff.dept.id == dept.id ? 'selected' : ''}>${dept.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="role-wrapper mt-3">
                        <label class="role-title">Roles</label>
                        <div class="role-options">
                            <c:forEach var="role" items="${allRoles}">
                                <div class="form-check">
                                    <input type="checkbox" 
                                           class="form-check-input" 
                                           name="roleIds" 
                                           value="${role.id}"
                                <c:forEach var="staffRole" items="${staff.roles}">
                                    <c:if test="${role.id eq staffRole.id}">checked</c:if>
                                </c:forEach>>
                         <label class="form-check-label">${role.name}</label>
                     </div>
                            </c:forEach>
                        </div>
                    </div>  -->

                            <!-- Upload Avatar Section -->


                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger mt-3">${errorMessage}</div>
                            </c:if>
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success mt-3">${successMessage}</div>
                            </c:if>

                            <div class="mt-3 text-left">
                                <button class="btn btn-primary profile-button" type="submit">Save Profile</button>
                                <a href="staffFilter">Back</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <!-- Footer -->
        <%@include file="../homepage/footer.jsp" %>

        <!-- JS Files -->
        <script src="assets/js/jquery-3.5.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/script.js"></script>
    </body>
</html>
