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
<!--        <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>-->
    </head>
    <body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
        <div class="wrapper">

            <div class="main">

                <main class="content">
                    <div class="container-fluid p-0">

                        <div class="row">

                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <table id="datatables-column-search-text-inputs" class="table table-striped"
                                               style="width:100%">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Phone</th>
                                                    <th>Email</th>
                                                    <th>Username</th>
                                                    <th>Password</th>
                                                    
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${requestScope.customers}" var="c">
                                                    <tr>
                                                        <td>${c.customerId}</td>
                                                        <td>${c.fullname}</td>
                                                        <td>${c.phonenumber}</td>
                                                        <td>${c.email}</td>
                                                        <td>${c.username}</td>
                                                        <td>${c.password}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Phone</th>
                                                    <th>Email</th>
                                                    <th>Username</th>
                                                    <th>Password</th>
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
