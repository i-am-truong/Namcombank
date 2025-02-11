<%-- 
    Document   : listCate2
    Created on : Jun 22, 2024, 10:19:05 PM
    Author     : lenovo
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

        <title>Namcombank</title>

        <!-- Custom fonts for this template -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Custom styles for this page -->
        <link href="${pageContext.request.contextPath}/adminassets/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
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
            .dataTables_wrapper {
                margin-top: 30px; /* Đẩy xuống 30px, có thể chỉnh số lớn hơn */
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
                        <form  action="filterStaff" method="post" >
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Gender</th>
                                        <th>Date of Birth</th>
                                        <th>Phone</th>
                                        <th>CID</th>
                                        <th>Email</th>
                                        <th>Address</th>
                                        <th>Department</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.staff}" var="s">
                                        <tr>
                                            <td>${s.fullname}</td>
                                            <td>${s.gender ? "Male" : "Female"}</td>
                                            <td>${s.dob}</td>
                                            <td>${s.phonenumber}</td>
                                            <td>${s.citizenId}</td>
                                            <td>${s.email}</td>
                                            <td>${s.address}</td>
                                            <td>${s.dept.name}</td>
                                            <td>
                                                <a href="updateStaff?id=${s.id}">Edit</a>
                                                <a onclick="checkDeleteCustomer('${s.id}')" class="btn btn-danger btn-sm">
                                                    Delete
                                                </a>
                                            </td>                                                    
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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
            $(document).ready(function () {
                // Kiểm tra nếu DataTable chưa được khởi tạo
                if (!$.fn.DataTable.isDataTable('#dataTable')) {
                    var table = $('#dataTable').DataTable({
                        "pageLength": 10, // Số bản ghi mặc định trên mỗi trang
                        "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "Tất cả"]]
                    });
                }
            });

            function checkBan(sid) {
                if (confirm("Ban customer with customerId = " + sid + "?")) {
                    window.location = 'lockCustomer?type=lock&cid=' + sid;
                }
            }

            function checkUnBan(sid) {
                if (confirm("Unban customer with customerId = " + sid + "?")) {
                    window.location = 'lockCustomer?type=unlock&cid=' + sid;
                }
            }

            function checkDeleteCustomer(sid) {
                if (confirm('Are you sure you want to delete this staff?')) {
                    window.location = 'staffDelete?id=' + sid;
                }
            }
        </script>

        <!-- Bootstrap core JavaScript -->
        <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">


        <!-- Core plugin JavaScript -->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- DataTables Plugin -->
        <script src="adminassets/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="adminassets/vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!-- Custom scripts -->
        <script src="adminassets/js/sb-admin-2.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminassets/js/app.js"></script>
        <script src="${pageContext.request.contextPath}/adminassets/js/datatables.js"></script>

        <!-- Page level custom scripts -->
        <script src="adminassets/js/demo/datatables-demo.js"></script>


    </body>

</html>
