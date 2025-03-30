<%--
    Document   : ComponentWarehouse
    Created on : Jan 17, 2025, 8:24:34 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <base href="${pageContext.request.contextPath}/">

        <title>Namcombank</title>

        <!-- Custom styles -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

        <style>
            .table-wrapper {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-top: 20px;
            }

            .search-container {
                display: flex;
                align-items: center;
                gap: 5px;
                margin-bottom: 15px;
            }

            .search-container input[type="search"] {
                flex: 1;
                min-width: 300px;
            }

            .search-container .btn {
                flex-shrink: 0;
            }

            .btn-pagination {
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
            }

            .btn-sort {
                background: none;
                border: none;
                padding: 0;
                cursor: pointer;
            }

            .action-buttons {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
            }

            .customer-img {
                width: 80px;
                height: 100px;
                object-fit: cover;
                border-radius: 4px;
            }

            .badge {
                font-size: 85%;
            }

            .alert {
                margin-top: 15px;
            }

            @media (max-width: 768px) {
                .search-container {
                    flex-direction: column;
                    align-items: stretch;
                }

                .search-container input[type="search"] {
                    min-width: auto;
                    width: 100%;
                }

                .action-buttons {
                    flex-direction: column;
                    gap: 10px;
                }

                .action-buttons .btn {
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
                            <h1 class="h3 mb-2 text-gray-800">List Customers</h1>
                            <p class="mb-4">Manage all customer accounts in the system.</p>

                            <!-- Action Buttons -->
                            <div class="action-buttons">
                                <div>
                                    <form action="addCustomer" method="POST" enctype="multipart/form-data" class="d-inline">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-user-plus"></i> Add New Customer
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/manageCustomerVer2/Search" method="get" class="d-inline">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search"></i> Advanced Search
                                        </button>
                                    </form>
                                </div>

                                <div class="d-flex">
                                    <form action="ExportCustomers" method="get" class="me-2">
                                        <button type="submit" class="btn btn-info">
                                            <i class="fas fa-file-export"></i> Export
                                        </button>
                                    </form>
                                    <form action="ImportCustomers" id="importForm" method="post" enctype="multipart/form-data">
                                        <input type="file" name="file" id="fileInput" style="display: none;" required>
                                        <button type="button" class="btn btn-warning" id="uploadBtn">
                                            <i class="fas fa-file-import"></i> Import
                                        </button>
                                    </form>
                                </div>
                            </div>

                            <!-- Search and Page Size Options -->
                            <form action="manageCustomerVer2" method="get">
                                <div class="row mb-3">
                                    <input type="hidden" name="page" value="${pagination.currentPage}">
                                    <input type="hidden" name="sort" value="${pagination.sort}">
                                    <input type="hidden" name="order" value="${pagination.order}">

                                    <div class="col-md-6 d-flex align-items-center">
                                        <label class="me-2">Show</label>
                                        <select name="page-size" class="form-select form-select-sm" style="width: auto;" onchange="this.form.submit()">
                                            <c:forEach items="${pagination.listPageSize}" var="s">
                                                <option value="${s}" ${pagination.pageSize==s?"selected":""}>${s}</option>
                                            </c:forEach>
                                        </select>
                                        <label class="ms-2">entries</label>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="input-group">
                                            <input type="search"
                                                   name="search"
                                                   class="form-control"
                                                   placeholder="Search"
                                                   value="${pagination.searchValues[0]}"
                                                   aria-label="Search">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <!-- Alert Messages -->
                            <c:if test="${not empty alertImportSuccess}">
                                <div class="alert alert-success alert-dismissible" role="alert">
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    <div class="alert-message">
                                        <strong>${alertImportSuccess}</strong>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${not empty alertImportFail}">
                                <div class="alert alert-warning alert-dismissible" role="alert">
                                    <%-- <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> --%>
                                    <div class="d-flex align-items-center">
                                        <div class="alert-message flex-grow-1">
                                            <strong>${alertImportFail}</strong>
                                        </div>
                                        <%-- <form action="ExportCustomers" method="get">
                                            <input type="hidden" name="type" value="error">
                                            <button type="submit" class="btn btn-sm btn-warning">
                                                <i class="fas fa-download"></i> Download Error Log
                                            </button>
                                        </form> --%>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Customers Table -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover" id="dataTable" width="100%" cellspacing="0">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>
                                                <div class="d-flex align-items-center">
                                                    <form action="manageCustomerVer2" method="get" class="me-1">
                                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                                        <input type="hidden" name="search" value="${pagination.searchValues[0]}" />
                                                        <input type="hidden" name="sort" value="fullname" />
                                                        <input type="hidden" name="order" value="${pagination.sort eq 'fullname' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />
                                                        <button type="submit" class="btn-sort">
                                                            <i class="fas ${pagination.sort eq 'fullname' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}"></i>
                                                        </button>
                                                    </form>
                                                    Full Name
                                                </div>
                                            </th>
                                            <th>Image</th>
                                            <th>Gender</th>
                                            <th>Date Of Birth</th>
                                            <th>
                                                <div class="d-flex align-items-center">
                                                    <form action="manageCustomerVer2" method="get" class="me-1">
                                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                                        <input type="hidden" name="search" value="${pagination.searchValues[0]}" />
                                                        <input type="hidden" name="sort" value="email" />
                                                        <input type="hidden" name="order" value="${pagination.sort eq 'email' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />
                                                        <button type="submit" class="btn-sort">
                                                            <i class="fas ${pagination.sort eq 'email' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}"></i>
                                                        </button>
                                                    </form>
                                                    Email
                                                </div>
                                            </th>
                                            <th>Phone Number</th>
                                            <th>CID</th>
                                            <th>Account Status</th>
                                            <th>
                                                <div class="d-flex align-items-center">
                                                    <form action="manageCustomerVer2" method="get" class="me-1">
                                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                                        <input type="hidden" name="search" value="${pagination.searchValues[0]}" />
                                                        <input type="hidden" name="sort" value="username" />
                                                        <input type="hidden" name="order" value="${pagination.sort eq 'username' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />
                                                        <button type="submit" class="btn-sort">
                                                            <i class="fas ${pagination.sort eq 'username' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}"></i>
                                                        </button>
                                                    </form>
                                                    Username
                                                </div>
                                            </th>
                                            <th>
                                                <div class="d-flex align-items-center">
                                                    <form action="manageCustomerVer2" method="get" class="me-1">
                                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                                        <input type="hidden" name="search" value="${pagination.searchValues[0]}" />
                                                        <input type="hidden" name="sort" value="address" />
                                                        <input type="hidden" name="order" value="${pagination.sort eq 'address' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />
                                                        <button type="submit" class="btn-sort">
                                                            <i class="fas ${pagination.sort eq 'address' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}"></i>
                                                        </button>
                                                    </form>
                                                    Address
                                                </div>
                                            </th>
                                            <th>Balance</th>
                                            <th>
                                                Actions
                                                <a href="manageCustomerVer2?page=${pagination.currentPage}&page-size=${pagination.pageSize}" class="text-primary">
                                                    <i class="fas fa-sync-alt ms-1"></i>
                                                </a>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="customer" items="${customers}" varStatus="status">
                                            <tr class="${status.index % 2 == 0 ? 'table-light' : ''}">
                                                <td>${status.index + 1 + (pagination.currentPage - 1) * pagination.pageSize}</td>
                                                <td>${customer.fullname}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${empty customer.avatar}">
                                                            <c:choose>
                                                                <c:when test="${customer.gender == 1}">
                                                                    <img src="${pageContext.request.contextPath}/assets/img/Male.jpg"
                                                                         alt="Male Avatar"
                                                                         class="customer-img">
                                                                </c:when>
                                                                <c:when test="${customer.gender == 0}">
                                                                    <img src="${pageContext.request.contextPath}/assets/img/Female.jpg"
                                                                         alt="Female Avatar"
                                                                         class="customer-img">
                                                                </c:when>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${customer.avatar}"
                                                                 alt="${customer.fullname}'s avatar"
                                                                 class="customer-img">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${customer.gender == 0}">
                                                            Female
                                                        </c:when>
                                                        <c:when test="${customer.gender == 1}">
                                                            Male
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td><fmt:formatDate value="${customer.dob}" pattern="dd/MM/yyyy"/></td>
                                                <td>${customer.email}</td>
                                                <td>${customer.phonenumber}</td>
                                                <td>${customer.cid}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${customer.active == 0}">
                                                            <span class="badge bg-danger">Closed</span>
                                                        </c:when>
                                                        <c:when test="${customer.active == 1}">
                                                            <span class="badge bg-success">Opening</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${customer.username}</td>
                                                <td>${customer.address}</td>
                                                <td>
                                                    <fmt:formatNumber value="${customer.balance}" pattern="#,##0"></fmt:formatNumber>
                                                </td>
                                            </tr>

                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Empty State -->
                            <c:if test="${totalCustomers==0}">
                                <div class="alert alert-info text-center py-4" role="alert">
                                    <i class="fas fa-info-circle fa-2x mb-3"></i>
                                    <h5>No customers found</h5>
                                    <p class="mb-0">Try adjusting your search criteria or adding new customers.</p>
                                </div>
                            </c:if>

                            <!-- Pagination -->
                            <jsp:include page="../homepage/pagination.jsp" />

                            <!-- Delete Status Alert -->
                            <c:if test="${not empty deleteStatus}">
                                <div class="alert alert-warning alert-dismissible" role="alert">
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    <div class="alert-message">
                                        <strong>${deleteStatus}</strong>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="adminassets/js/sb-admin-2.min.js"></script>

        <script>
            document.getElementById("uploadBtn").addEventListener("click", function () {
                document.getElementById("fileInput").click();
            });

            document.getElementById("fileInput").addEventListener("change", function () {
                if (this.files.length > 0) {
                    document.getElementById("importForm").submit();
                }
            });

            // Initialize Bootstrap components
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl)
            });
        </script>
    </body>
</html>
