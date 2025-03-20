<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank</title>

        <!-- Custom styles -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">

        <style>
            .table-wrapper {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-top: 20px;
            }

            .search-filters {
                background: #f8f9fc;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
            }

            .search-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 10px;
                margin-bottom: 15px;
            }

            .action-btn {
                padding: 4px 8px;
                margin: 0 2px;
                border-radius: 4px;
            }

            .search-buttons {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
            }

            @media (max-width: 768px) {
                .search-buttons {
                    flex-direction: column;
                    gap: 10px;
                }

                .search-buttons button {
                    width: 100%;
                }
            }
        </style>
    </head>

    <body id="page-top">
        <div id="wrapper">
            <%@include file="../homepage/sidebar_admin.jsp" %>
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <%@include file="../homepage/header_admin.jsp" %>
                    <div class="container-fluid">
                        <div class="table-wrapper">
                            <!-- Search Filters Form -->
                            <form action="${pageContext.request.contextPath}/staffFilter" method="POST" id="searchForm">
                                <div class="search-filters">
                                    <h4 class="mb-3">Staff Search</h4>

                                    <div class="search-grid">
                                        <!--                                        <div class="form-group">
                                                                                    <label for="staffid">Staff ID</label>
                                                                                    <input type="text" id="staffid" name="staffid" class="form-control" 
                                                                                           value="${requestScope.staffid}" placeholder="Staff ID">
                                                                                </div>-->

                                        <div class="form-group">
                                            <label for="fullname">Full Name</label>
                                            <input type="text" id="fullname" name="fullname" class="form-control" 
                                                   value="${requestScope.fullname}" placeholder="Full Name">
                                        </div>

                                        <div class="form-group">
                                            <label for="gender">Gender</label>
                                            <select id="gender" name="gender" class="form-control">
                                                <option value="-1" ${requestScope.gender == null || requestScope.gender == '-1' ? 'selected' : ''}>All</option>
                                                <option value="true" ${requestScope.gender == 'true' ? 'selected' : ''}>Male</option>
                                                <option value="false" ${requestScope.gender == 'false' ? 'selected' : ''}>Female</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="dob">Date of Birth</label>
                                            <input type="date" id="dob" name="dob" class="form-control" 
                                                   value="${requestScope.dob}">
                                        </div>

                                        <div class="form-group">
                                            <label for="phonenumber">Phone Number</label>
                                            <input type="text" id="phonenumber" name="phonenumber" class="form-control" 
                                                   value="${requestScope.phonenumber}" placeholder="Phone Number">
                                        </div>

                                        <div class="form-group">
                                            <label for="citizen_identification_card">Citizen ID</label>
                                            <input type="text" id="citizen_identification_card" name="citizen_identification_card" 
                                                   class="form-control" value="${requestScope.citizen_identification_card}" 
                                                   placeholder="Citizen ID">
                                        </div>

                                        <div class="form-group">
                                            <label for="email">Email</label>
                                            <input type="text" id="email" name="email" class="form-control" 
                                                   value="${requestScope.email}" placeholder="Email">
                                        </div>

                                        <div class="form-group">
                                            <label for="address">Address</label>
                                            <input type="text" id="address" name="address" class="form-control" 
                                                   value="${requestScope.address}" placeholder="Address">
                                        </div>

                                        <div class="form-group">
                                            <label for="did">Department</label>
                                            <select id="did" name="did" class="form-control">
                                                <option value="-1">All Departments</option>
                                                <c:forEach items="${requestScope.depts}" var="d">
                                                    <option value="${d.id}" ${requestScope.did == d.id ? 'selected' : ''}>${d.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="roleid">Role</label>
                                            <select id="roleid" name="roleid" class="form-control">
                                                <option value="-1">All Roles</option>
                                                <c:forEach items="${requestScope.roles}" var="r">
                                                    <option value="${r.id}" ${requestScope.roleid == r.id ? 'selected' : ''}>${r.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="search-buttons">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search"></i> Search
                                        </button>
                                        <button type="button" id="clearFiltersBtn" class="btn btn-secondary">
                                            <i class="fas fa-undo"></i> Clear Filters
                                        </button>
                                    </div>
                                </div>
                            </form>

                            <!-- Staff Table -->
                            <div class="table-responsive">
                                <table class="table table-bordered" id="staffTable">
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
                                            <th>Role Name</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.staff}" var="s">
                                            <tr>
                                                <td>${s.fullname}</td>
                                                <td>${s.gender ? "Male" : "Female"}</td>
                                                <td><fmt:formatDate value="${s.dob}" pattern="dd/MM/yyyy"/></td>
                                                <td>${s.phonenumber}</td>
                                                <td>${s.citizenId}</td>
                                                <td>${s.email}</td>
                                                <td>${s.address}</td>
                                                <td>${s.dept.name}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty s.roles}">
                                                            <c:forEach items="${s.roles}" var="r" varStatus="loop">
                                                                ${r.name}<c:if test="${!loop.last}">, </c:if>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>None</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="updateStaff?id=${s.id}" class="btn btn-primary btn-sm action-btn">
                                                        <i class="fas fa-edit"></i> Edit
                                                    </a>
                                                    <button onclick="confirmDelete('${s.id}')" 
                                                            class="btn btn-danger btn-sm action-btn">
                                                        <i class="fas fa-trash"></i> Delete
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        <c:if test="${empty requestScope.staff}">
                                            <tr>
                                                <td colspan="10" class="text-center">No staff records found</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="adminassets/js/sb-admin-2.min.js"></script>

        <script>
                                                        // Clear filters functionality
                                                        document.getElementById('clearFiltersBtn').addEventListener('click', function () {
                                                            // Reset all form fields
                                                            document.getElementById('fullname').value = '';
                                                            document.getElementById('gender').value = '-1';
                                                            document.getElementById('dob').value = '';
                                                            document.getElementById('phonenumber').value = '';
                                                            document.getElementById('citizen_identification_card').value = '';
                                                            document.getElementById('email').value = '';
                                                            document.getElementById('address').value = '';
                                                            document.getElementById('did').value = '-1';
                                                            document.getElementById('roleid').value = '-1';

                                                            // Submit the form to reset the search
                                                            document.getElementById('searchForm').submit();
                                                        });

                                                        // Delete confirmation
                                                        function confirmDelete(staffId) {
                                                            if (confirm('Are you sure you want to delete this staff member?')) {
                                                                window.location.href = 'staffDelete?id=' + staffId;
                                                            }
                                                        }
        </script>
    </body>
</html>