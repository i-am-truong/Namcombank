<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
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
    </style>
</head>

<body id="page-top">
    <div id="wrapper">
        <%@include file="../homepage/sidebar_admin.jsp" %>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
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
                            </div>
                    <!-- /.container-fluid -->
                        </div>
                    </div>
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
    </script>
</body>
</html>
