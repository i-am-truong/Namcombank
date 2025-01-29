<%-- 
    Document   : userProfile
    Created on : 04/07/2024, 9:18:36 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Namcombank</title>

        <!-- Custom fonts for this template -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">

        <!-- Custom styles for this page -->
        <link href="adminassets/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

        <script src="${pageContext.request.contextPath}/assets/js/jquery-3.5.1.min.js" type="text/javascript"></script>

    </head>
    <body>
        <div id="wrapper">
            <%@include file="../homepage/sidebar_admin.jsp" %>
            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <%@include file="../homepage/header_admin.jsp" %>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <div class="p-3 py-5">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="text-right">Profile Settings</h4>
                            </div>

                            <form id="profile-form" action="userProfile" method="post">
                                <div class="col-md-6">
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

                                <div class="col-md-6">
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

                                <div class="col-md-6">
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

                                <div class="col-md-6">
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
                                            
                                <div class="col-md-6">
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
                                    <c:if test="${sessionScope.user.gender != 0 && sessionScope.user.gender != 1} ">
                                    <select name="gender" class="form-control" required>
                                        <option value="" disabled selected>Select gender</option>
                                        <option  value="male">Male</option>
                                        <option  value="female">Female</option>
                                    </select>
                                         </c:if>
                                </div>

                                <div class="col-md-6">
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
                                </div>
                            </form>
                                        <a href="changePass" class="btn btn-primary profile-button" type="button">Change Password</a>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->
            </div>
            <!-- End of Content Wrapper -->

        </div>
        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <!-- Custom scripts for all pages-->
        <script src="adminassets/js/sb-admin-2.min.js"></script>
        <!-- Page level plugins -->
        <script src="adminassets/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="adminassets/vendor/datatables/dataTables.bootstrap4.min.js"></script>
        <!-- Page level custom scripts -->
        <script src="adminassets/js/demo/datatables-demo.js"></script>
          <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Lấy ngày hiện tại theo định dạng YYYY-MM-DD
            var today = new Date().toISOString().split('T')[0];
            
            // Cập nhật thuộc tính max của input[type="date"]
            document.querySelector('input[type="date"]').setAttribute('max', today);
        });
        document.getElementById('profile-form').addEventListener('submit', function(event) {
    
    this.submit();
});
    </script>
    </body>
</html>
