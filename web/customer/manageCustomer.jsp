<%--
    Document   : manageCustomer
    Created on : Feb 7, 2025, 10:23:28 AM
    Author     : TQT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <title>Customer Management</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">
        <link class="js-stylesheet" href="${pageContext.request.contextPath}/adminassets/css/light.css" rel="stylesheet">

    </head>
    <body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
        <div class="wrapper">
            <jsp:include page="../homepage/sidebar_admin.jsp" />

            <div class="main">
                <jsp:include page="../homepage/header_admin.jsp" />

                <main class="content">
                    <div class="container-fluid p-0">

                        <div class="row">

                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <table id="datatables-column-search-text-inputs" class="table table-striped"
                                               style="width:100%">
                                            <div class="d-flex align-items-center justify-content-between mb-3" style="position: relative;">
                                                <a href="addCustomer" class="btn btn-primary">
                                                    Add New Customer
                                                </a>
                                                <h1>List Customers</h1>
                                                <a href="managerUser" class="btn btn-outline-secondary">
                                                    Back to Admin Page
                                                </a>

                                            </div>
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Gender</th>
                                                    <th>Date of Birth</th>
                                                    <th>Phone</th>
                                                    <th>CID</th>
                                                    <th>Email</th>
                                                    <th>Username</th>
                                                    <th>Account Status</th>
                                                    <th>Address</th>
                                                    <th>Balance</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${requestScope.customers}" var="c">
                                                    <tr>
                                                        <td><a href="${pageContext.request.contextPath}/viewCustomer?customerId=${c.customerId}">${c.customerId}</a></td>
                                                        <td>${c.fullname}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${c.gender == 0}">
                                                                    Female
                                                                </c:when>
                                                                <c:when test="${c.gender == 1}">
                                                                    Male
                                                                </c:when>
                                                            </c:choose>
                                                        </td>
                                                        <td>${c.dob}</td>
                                                        <td>${c.phonenumber}</td>
                                                        <td>${c.cid}</td>
                                                        <td>${c.email}</td>
                                                        <td>${c.username}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${c.active == 0}">
                                                                    Closed
                                                                    <a href="javascript:void(0)" onclick="return checkUnBan('${c.customerId}')">
                                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-unlock" viewBox="0 0 16 16">
                                                                        <path d="M11 1a2 2 0 0 0-2 2v4a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h5V3a3 3 0 0 1 6 0v4a.5.5 0 0 1-1 0V3a2 2 0 0 0-2-2M3 8a1 1 0 0 0-1 1v5a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V9a1 1 0 0 0-1-1z"/>
                                                                        </svg>
                                                                    </a>
                                                                </c:when>
                                                                <c:when test="${c.active ==1}">
                                                                    Opening
                                                                    <a href="javascript:void(0)" onclick="return checkBan('${c.customerId}')">
                                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock" viewBox="0 0 16 16">
                                                                        <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2M5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1"/>
                                                                        </svg>
                                                                    </a>
                                                                </c:when>
                                                            </c:choose>
                                                        </td>
                                                        <td>${c.address}</td>
                                                        <td>${c.balance}</td>
                                                        <td>
                                                            <a href="editCustomer?customerId=${c.customerId}">Edit</a>
                                                            <a href="javascript:void(0)" onclick="return checkDeleteCustomer('${c.customerId}')">
                                                                Delete
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Gender</th>
                                                    <th>Date of Birth</th>
                                                    <th>Phone</th>
                                                    <th>CID</th>
                                                    <th>Email</th>
                                                    <th>Username</th>
                                                    <th>Account Status</th>
                                                    <th>Address</th>
                                                    <th>Balance</th>
                                                    <th>Action</th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </main>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/adminassets/js/app.js"></script>
        <script src="${pageContext.request.contextPath}/adminassets/js/datatables.js"></script>

        <script>
                                                                $(document).ready(function () {
                                                                    // Setup - add a text input to each footer cell
                                                                    $('#datatables-column-search-text-inputs tfoot th').each(function () {
                                                                        var title = $(this).text();
                                                                        $(this).html('<input type="text" class="form-control" placeholder="Search ' + title + '" />');
                                                                    });

                                                                    // Initialize DataTable
                                                                    var table = $('#datatables-column-search-text-inputs').DataTable({
                                                                        "pageLength": 1,
                                                                        "lengthMenu": [[1, 5, 10, 25, 50, -1], [1, 5, 10, 25, 50, "All"]]
                                                                    });

                                                                    // Apply the search
                                                                    table.columns().every(function () {
                                                                        var column = this;
                                                                        $('input', this.footer()).on('keyup change', function () {
                                                                            if (column.search() !== this.value) {
                                                                                column
                                                                                        .search(this.value)
                                                                                        .draw();
                                                                            }
                                                                        });
                                                                    });
                                                                });
                                                                function checkBan(cid) {
                                                                    // Thêm mã kiểm tra hợp lệ của form nếu cần
                                                                    if (confirm("Ban customer with customerId = " + cid + "?")) {
                                                                        window.location = 'lockCustomer?type=lock&cid=' + cid;
                                                                    }
                                                                }

                                                                function checkUnBan(cid) {
                                                                    // Thêm mã kiểm tra hợp lệ của form nếu cần
                                                                    if (confirm("Unban customer with customerId = " + cid + "?")) {
                                                                        window.location = 'lockCustomer?type=unlock&cid=' + cid;
                                                                    }
                                                                }

                                                                function checkDeleteCustomer(cid) {
                                                                    if (confirm('Are you sure you want to delete this customer?')) {
                                                                        window.location = 'deleteCustomer?cid=' + cid;
                                                                    }
                                                                }
                                                                // DataTables with Column Search by Select Inputs
//            document.addEventListener("DOMContentLoaded", function () {
//                $("#datatables-column-search-select-inputs").DataTable({
//                    initComplete: function () {
//                        this.api().columns().every(function () {
//                            var column = this;
//                            var select = $("<select class=\"form-control\"><option value=\"\"></option></select>")
//                                    .appendTo($(column.footer()).empty())
//                                    .on("change", function () {
//                                        var val = $.fn.dataTable.util.escapeRegex(
//                                                $(this).val()
//                                                );
//                                        column
//                                                .search(val ? "^" + val + "$" : "", true, false)
//                                                .draw();
//                                    });
//                            column.data().unique().sort().each(function (d, j) {
//                                select.append("<option value=\"" + d + "\">" + d + "</option>")
//                            });
//                        });
//                    }
//                });
//            });

        </script>
    </body>
</html>
