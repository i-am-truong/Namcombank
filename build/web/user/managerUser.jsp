<%-- 
    Document   : managerUser
    Created on : Jun 16, 2024, 10:00:51 AM
    Author     : chien
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

        <title>Clothes Shop Manager</title>

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
            th {
                position: relative;
                padding-right: 20px; /* Adjust this value to give space for the icon */
            }
            th .fa {
                position: absolute;
                right: 5px; /* Adjust this value to control the distance from the edge */
                top: 50%;
                transform: translateY(-50%);
                font-size: 12px; /* Adjust the size of the icon if needed */
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
                    <div class="container-fluid">
                        <!-- Page Heading -->
                        <h1 class="h3 mb-2 text-gray-800">User List</h1>
                        <a href="addStaff">  <button type="button" style="margin-bottom: 20px" class="btn btn-primary">Add new staff</button></a>
                        <br> 
 <br> 
                        <!-- Search and Filter Form -->
                        <form id="filterForm" name="filterForm" action="managerUser" method="get" onsubmit="return validateForm()">
                            <div class="form-row">
                                <!-- Search properties -->
                                <%
                                    String searchU = request.getParameter("searchU");
     
                                %>
                                <div class="col-md-2 mb-3">
                                    <input type="text" name="searchU" placeholder="Search properties" value="<%= searchU != null ? searchU : "" %>" class="form-control">
                                </div>

                                <!-- Brands Dropdown -->
                                <div class="col-md-2 mb-3">
                                    <select name="role" class="form-select">
                                        <option value="-1">All Role</option>
                                        <c:forEach var="r" items="${listR}">
                                            <option value="${r.rid}" ${requestScope.role == r.rid ? 'selected' : ''}>${r.role}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Genders Dropdown -->
                                <div class="col-md-2 mb-3">
                                    <select name="active" class="form-select">
                                        <option value="-1"  ${requestScope.active == -1 ? 'selected' : ''}>All Active</option>
                                        <option value="0" ${requestScope.active == 0 ? 'selected' : ''}>Close</option>
                                        <option value="1" ${requestScope.active == 1 ? 'selected' : ''}>Open</option>
                                    </select>
                                </div>
                                <!-- Submit Button (hidden) -->
                                <div class="col-md-2 mb-3" style="display: none;">
                                    <button type="submit" class="btn btn-primary btn-block">Search</button>
                                </div>
                                <div class="col-md-1 mb-1">
                                    <input class="form-control" readonly="" value="Total: ${requestScope.countU}">
                                </div>
                            </div>
                        </form>

                        <!-- Product Table -->
                        <div class="card shadow mb-4">

                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>

                                            <th>ID</th>
                                            <th>Name<a href="managerUser?indexU=${currentIndex + 1}&searchU=${param.searchU}&role=${param.role}&active=${param.active}&sortField=fullName&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}"><span class="fa fa-sort"></span></a></th>
                                            <th>Phone<a href="managerUser?indexU=${currentIndex + 1}&searchU=${param.searchU}&role=${param.role}&active=${param.active}&sortField=phone&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}"><span class="fa fa-sort"></span></a></th>
                                            <th>Email<a href="managerUser?indexU=${currentIndex + 1}&searchU=${param.searchU}&role=${param.role}&active=${param.active}&sortField=email&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}"><span class="fa fa-sort"></span></a></th>
                                            <th>Username<a href="managerUser?indexU=${currentIndex + 1}&searchU=${param.searchU}&role=${param.role}&active=${param.active}&sortField=username&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}"><span class="fa fa-sort"></span></a></th>
                                            <th>Role</th>
                                            <th>Active</th>
                                            <th>Ban</th>
                                            <th> UnBan</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.listU}" var="u">
                                            <tr>


                                                <td>${u.uid}</td>
                                                <td>${u.fullName}</td>
                                                <td>${u.phone}</td>
                                                <td>${u.email}</td>
                                                <td>${u.username}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${u.rid == 1}">
                                                            admin
                                                        </c:when>
                                                        <c:when test="${u.rid == 2}">
                                                            staff
                                                        </c:when>
                                                        <c:otherwise>
                                                            customer
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${u.active == 0}">
                                                            close
                                                        </c:when>
                                                        <c:when test="${u.active ==1}">
                                                            open</c:when>
                                                    </c:choose>
                                                </td>
                                                <td><a href="#" onclick="return checkBan('${u.uid}')"><i class="bi bi-ban"></i></a></td>
                                                <td><a href="#" onclick="return checkUnBan('${u.uid}')"><i class="bi bi-unlock"></i></a></td>

                                            </tr>
                                        </c:forEach>
                                    </tbody>

                                </table>

                            </div>
                        </div>

                        <!-- Pagination -->
                        <!--                        <nav aria-label="Page navigation example" class="mt-4">
                                                    <ul class="pagination justify-content-center">
                                                        
                        <c:set var="currentIndex" value="${param.index != null ? param.index : 1}" />
                        <c:forEach begin="1" end="${requestScope.endPage}" var="i">
                            <li>

                                <a class="${i == currentIndex ? 'active' : ''}" href="managerUser?indexU=${i}&searchU=${param.searchU}">${i}</a>


                            </li>
                        </c:forEach>

                    </ul>
                </nav>-->
                        <nav aria-label="Page navigation example" class="mt-4" style="margin-top: 1.5rem;">
                            <ul class="pagination justify-content-center" style="list-style: none; padding: 0; display: flex;">
                                <c:set var="currentIndex" value="${param.indexU != null ? param.indexU : 1}" />

                                <!-- Previous button -->
                                <c:if test="${currentIndex > 2}">
                                    <li style="margin: 0 5px;">
                                        <a href="managerUser?indexU=${currentIndex - 2}&searchU=${param.searchU}&role=${param.role}&active=${param.active}&sortField=${param.sortField != null ? param.sortField : 'uid'}&sortOrder=${param.sortOrder != null ? param.sortOrder : 'asc'}"
                                           style="text-decoration: none; padding: 8px 16px; border: 1px solid #ddd; border-radius: 4px;">
                                              ${currentIndex -2}
                                        </a>
                                    </li>
                                </c:if>

                                <!-- Page links -->
                                <c:forEach begin="${currentIndex > 2 ? currentIndex - 1 : 1}" end="${(currentIndex < endPage - 1) ? currentIndex + 1 : endPage}" var="i">
                                    <li style="margin: 0 5px;">
                                        <a class="${i == currentIndex ? 'active' : ''}" href="managerUser?indexU=${i}&searchU=${param.searchU}&role=${param.role}&active=${param.active}&sortField=${param.sortField != null ? param.sortField : 'uid'}&sortOrder=${param.sortOrder != null ? param.sortOrder : 'asc'}"
                                           style="text-decoration: none; padding: 8px 16px; border: 1px solid #ddd; border-radius: 4px; color: ${i == currentIndex ? '#fff' : '#007bff'}; background-color: ${i == currentIndex ? '#007bff' : '#fff'};">
                                            ${i}
                                        </a>
                                    </li>
                                </c:forEach>

                                <!-- Next button -->
                                <c:if test="${currentIndex +2 <= endPage}">
                                    <li style="margin: 0 5px;">
                                        <a href="managerUser?indexU=${currentIndex + 2}&searchU=${param.searchU}&role=${param.role}&active=${param.active}&sortField=${param.sortField != null ? param.sortField : 'uid'}&sortOrder=${param.sortOrder != null ? param.sortOrder : 'asc'}"
                                           style="text-decoration: none; padding: 8px 16px; border: 1px solid #ddd; border-radius: 4px;">
                                              ${currentIndex + 2 }
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>



                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->
            </div>
            <!-- End of Content Wrapper -->
        </div>
        <!-- End of Page Wrapper -->

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.getElementById("filterForm");
                const elements = form.querySelectorAll('input, select');

                elements.forEach(element => {
                    element.addEventListener('change', function () {
                        form.submit();
                    });
                });
            });
        </script>
        <script>
            function checkBan(uid) {
                // Thêm mã kiểm tra hợp lệ của form nếu cần
                if (confirm("Ban user with uid = " + uid + "?")) {
                    window.location = 'lockUser?type=lock&uid=' + uid;
                }
            }

            function checkUnBan(uid) {
                // Thêm mã kiểm tra hợp lệ của form nếu cần
                if (confirm("Unban with user " + uid + "?")) {
                    window.location = 'lockUser?type=unlock&uid=' + uid;
                }
            }
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
