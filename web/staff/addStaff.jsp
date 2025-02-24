<%-- 
    Document   : addStaff
    Created on : Jun 22, 2024, 10:19:05 PM
    Author     : Asus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>


        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Namcombank </title>

        <!-- Custom fonts for this template -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Custom styles for this page -->
        <link href="adminassets/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">


        <style>
            /* General form styling */
            #registerStaffForm {
                display: flex;
                flex-direction: column; /* Align items vertically */
                gap: 15px; /* Space between form elements */
                margin-left: 30px;
            }

            /* Styling for form inputs */
            #registerStaffForm .form-control {
                margin-bottom: 15px; /* Space between input fields */
            }

            /* Styling for the gender selection */
            #registerStaffForm div {
                display: flex;
                align-items: center;
                gap: 10px; /* Space between gender options */
            }

            /* Specific styling for the gender label */
            #registerStaffForm div:first-of-type {
                margin-bottom: 15px; /* Space before gender selection */
            }

            /* Styling for the submit button */
            #registerStaffForm button {
                margin-bottom: 20px; /* Space below the button */
                width: 250px;
            }
            .role-wrapper {
                margin: 15px 0;
                padding: 10px;
                border: 1px solid #e3e6f0;
                border-radius: 4px;
            }

            .role-title {
                display: block;
                color: black;
                margin-bottom: 10px;
            }

            .role-options {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .role-toggle {
                margin: 0;
                cursor: pointer;
            }

            .role-btn {
                display: inline-block;
                padding: 6px 12px;
                background: #f8f9fc;
                border: 1px solid #e3e6f0;
                border-radius: 4px;
                color: #666;
                font-size: 14px;
                transition: all 0.2s;
            }

            .role-toggle input:checked + .role-btn {
                background: #4e73df;
                color: white;
                border-color: #4e73df;
            }

            .role-btn:hover {
                background: #eaecf4;
            }
        </style>

    </head>

    <body id="page-top">

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <%@include file="../homepage/sidebar_admin.jsp" %>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <!-- Main Content -->
                <div id="content">
                    <!-- Topbar -->
                    <%@include file="../homepage/header_admin.jsp" %>
                    <!-- End of Topbar -->
                    <!-- Begin Page Content -->
                    <div class="container-fluid" >
                        <!-- Page Heading -->
                        <h1>Add staff</h1>
                        <form id="registerStaffForm" action="addStaff" method="post" class="col-8">
                            <input type="text" class="form-control" name="nameS" id="name" placeholder="Enter name" value="${param.nameS != null ? param.nameS : ''}">
                            <input type="text" class="form-control" name="phoneS" id="phone" placeholder="Enter phone number" value="${param.phoneS != null ? param.phoneS : ''}" >
                            <input type="email" class="form-control" name="emailS" id="email" placeholder="Enter your email" value="${param.emailS != null ? param.emailS : ''}">
                            <input type="text" class="form-control" name="cicS" id="cic" placeholder="Enter citizen identification" value="${param.cicS != null ? param.cicS : ''}">
                            <input type="text" class="form-control" name="addressS" id="address" placeholder="Enter address" value="${param.addressS != null ? param.addressS : ''}">
                            <div><label>Date of birth &nbsp;</label> <input type="date" class="form-control" name="dobS" id="dob" ></div>
                            <div style="margin-bottom: 20px; display: flex ">
                                <div style="margin-right: 50px">Choose gender:</div>
                                <div style="display: inline-block; margin-right: 10px">
                                    <input type="radio" name="genderS" id="male" value="1" checked="">
                                    <label for="male">Male</label>
                                </div>
                                <div style="display: inline-block; margin-left: 10px; margin-right: 10px">
                                    <input type="radio" name="genderS" id="female" value="0">
                                    <label for="female">Female</label>
                                </div>
                            </div>
                            <select class="form-control" name="did">
                                <c:forEach var="dept" items="${depts}">
                                    <option value="${dept.id}">${dept.name}</option>
                                </c:forEach>
                            </select>


                            <div class="role-wrapper">
                                <label class="role-title">Select Roles</label>
                                <div class="role-options">
                                    <label class="role-toggle">
                                        <input type="checkbox" name="roleId" value="1" hidden>
                                        <span class="role-btn">Administrator</span>
                                    </label>
                                    <label class="role-toggle">
                                        <input type="checkbox" name="roleId" value="2" hidden>
                                        <span class="role-btn">Staff</span>
                                    </label>
                                    <label class="role-toggle">
                                        <input type="checkbox" name="roleId" value="3" hidden>
                                        <span class="role-btn">Head Of Staff</span>
                                    </label>
                                    <label class="role-toggle">
                                        <input type="checkbox" name="roleId" value="4" hidden>
                                        <span class="role-btn">Accountant</span>
                                    </label>
                                </div>
                            </div>
                            <input type="text" class="form-control" name="usernameS" id="username" placeholder="Enter username" value="${param.usernameS != null ? param.usernameS : ''}">
                            <input type="password" class="form-control" name="passS" id="pass" placeholder="Enter password" value="${param.passS != null ? param.passS : ''}">
                            <input type="password" class="form-control" name="repassS" id="repass" placeholder="Confirm password" value="${param.repassS != null ? param.repassS : ''}">

                            <p style="color: #0061f2;">${requestScope.suc2}</p>

                            <div> <a href="managerUser"><button  type="button" style="margin-bottom: 20px" class="btn btn-primary" >Back</button></a>
                                <button id="resetBtn" type="submit" style="margin-bottom: 20px; margin-left: 50px" class="btn btn-primary">Add Staff</button>
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success">${successMessage}</div>
                                </c:if>
                        </form>
                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->
            </div>
            <!-- End of Content Wrapper -->
        </div>
        <!-- End of Page Wrapper -->

        <script>
            document.getElementById('resetBtn').addEventListener('click', function (event) {
                event.preventDefault(); // Ngăn form gửi nếu có lỗi

                var name = document.getElementById('name').value.trim();
                var phone = document.getElementById('phone').value.trim();
                var email = document.getElementById('email').value.trim();
                var cic = document.getElementById('cic').value.trim();
                var address = document.getElementById('address').value.trim();
                var date = document.getElementById('dob').value.trim();
                var username = document.getElementById('username').value.trim();
                var pass = document.getElementById('pass').value.trim();
                var repass = document.getElementById('repass').value.trim();

                var cicRegex = /^[0-9]{12}$/;
                var phoneRegex = /^0[0-9]{9,10}$/;
                var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                var addressRegex = /^[A-Za-z0-9\s,.'-]{3,}$/;
                var usernameRegex = /^[A-Za-z0-9_\.]+$/;
                var passRegex = /^(?=.*[a-z])(?=.*[A-Z]).{8,}$/;

                var isValid = true;
                var errorMessage = '';

                if (!name) {
                    errorMessage += 'Name cannot be empty\n';
                    isValid = false;
                }
                if (!phone) {
                    errorMessage += 'Phone cannot be empty\n';
                    isValid = false;
                } else if (!phoneRegex.test(phone)) {
                    errorMessage += 'Phone must be 10-11 digits and start with 0\n';
                    isValid = false;
                }
                if (!email) {
                    errorMessage += 'Email cannot be empty\n';
                    isValid = false;
                } else if (!emailRegex.test(email)) {
                    errorMessage += 'Invalid email\n';
                    isValid = false;
                }
                if (!cic) {
                    errorMessage += 'Citizen Identification cannot be empty\n';
                    isValid = false;
                } else if (!cicRegex.test(cic)) {
                    errorMessage += 'Citizen Identification must be 12 digits\n';
                    isValid = false;
                }
                if (!address) {
                    errorMessage += 'Address cannot be empty\n';
                    isValid = false;
                } else if (!addressRegex.test(address)) {
                    errorMessage += 'Invalid address\n';
                    isValid = false;
                }
                if (!date) {
                    errorMessage += 'Date of birth cannot be empty\n';
                    isValid = false;
                }
                if (!username) {
                    errorMessage += 'Username cannot be empty\n';
                    isValid = false;
                } else if (!usernameRegex.test(username)) {
                    errorMessage += 'Invalid username\n';
                    isValid = false;
                }
                if (!pass) {
                    errorMessage += 'Password cannot be empty\n';
                    isValid = false;
                } else if (!passRegex.test(pass)) {
                    errorMessage += 'Password must be at least 8 characters, uppercase and lowercase\n';
                    isValid = false;
                }
                if (!repass) {
                    errorMessage += 'Re-enter password cannot be empty\n';
                    isValid = false;
                } else if (pass !== repass) {
                    errorMessage += 'Passwords do not match\n';
                    isValid = false;
                }

                if (!isValid) {
                    alert(errorMessage);
                } else {
                    document.getElementById('registerStaffForm').submit();
                }
            });

        </script>


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

    </body>

</html>
