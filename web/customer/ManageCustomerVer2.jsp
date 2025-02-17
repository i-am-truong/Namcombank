<%--
    Document   : ComponentWarehouse
    Created on : Jan 17, 2025, 8:24:34 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
        <meta name="author" content="AdminKit">
        <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
        <base href="${pageContext.request.contextPath}/">

        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="shortcut icon" href="img/icons/icon-48x48.png" />

        <link rel="canonical" href="https://demo-basic.adminkit.io/" />

        <title>Namcombank</title>

        <link href="${pageContext.request.contextPath}/adminassets/css/light.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
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

        </style>
    </head>

    <body>
        <div class="wrapper">
            <jsp:include page="../homepage/sidebar_admin.jsp" />

            <div class="main">

                <jsp:include page="../homepage/header_admin.jsp" />
                <main class="content">
                    <h2>List Customers</h2>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <form action="addCustomer" method="POST" enctype="multipart/form-data" style="display: inline;">
                            <button type="submit" class="btn btn-success"><i class="fas fa-add"></i> Add New Customer</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/manageCustomerVer2/Search" method="get" style="display: inline;">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Advanced Search</button>
                        </form>
                    </div>
                    <form action="manageCustomerVer2" method="get" class="row align-items-center">
                        <input type="hidden" name="page" value="${pagination.currentPage}">
                        <input type="hidden" name="sort" value="${pagination.sort}">
                        <input type="hidden" name="order" value="${pagination.order}">
                        <div class="col-sm-6 col-md-6">
                            <label>Show
                                <select name="page-size" class="form-select form-select-sm d-inline-block" style="width: auto;" onchange="this.form.submit()">
                                    <c:forEach items="${pagination.listPageSize}" var="s">
                                        <option value="${s}" ${pagination.pageSize==s?"selected":""}>${s}</option>
                                    </c:forEach>
                                </select>
                                entries
                            </label>
                        </div>
                        <div class="col-sm-6 col-md-6 text-end">
                            <div class="col-md-3 input-group d-flex justify-content-end">
                                <input type="search" style="flex: 0.5 1 auto" name="search" class="form-control form-control-md" placeholder="Search" value="${pagination.searchValues[0]}" aria-controls="datatables-column-search-text-inputs">
                                <button type="submit" class="btn btn-primary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search align-middle"><circle cx="11" cx="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                </button>
                            </div>
                        </div>
                    </form>
                    <table class="table table-hover my-0">
                        <thead>
                            <tr>
                                <th style="width:3%">ID</th>
                                <th style="width:13%">
                                    <form action="manageCustomerVer2" method="get">
                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                        <input type="hidden" name="search" value="${pagination.searchValues[0]}" />
                                        <input type="hidden" name="sort" value="fullname" />
                                        <input type="hidden" name="order" value="${pagination.sort eq 'fullname' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />
                                        <button type="submit" class="btn-sort">
                                            <i class="align-middle fas fa-fw
                                               ${pagination.sort eq 'fullname' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}">
                                            </i>
                                        </button>
                                        Full Name
                                    </form>
                                </th>
                                <th>
                                    Gender
                                </th>
                                <th>
                                    Date Of Birth
                                </th>

                                <th style="width:30%">
                                    <form action="manageCustomerVer2" method="get">
                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                        <input type="hidden" name="search" value="${pagination.searchValues[0]}" />
                                        <input type="hidden" name="sort" value="email" />
                                        <input type="hidden" name="order" value="${pagination.sort eq 'email' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />
                                        <button type="submit" class="btn-sort">
                                            <i class="align-middle fas fa-fw
                                               ${pagination.sort eq 'email' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}">
                                            </i>
                                        </button>
                                        Email
                                    </form>
                                </th>

                                <th style="width:15%">
                                    <form action="manageCustomerVer2" method="get">
                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                        <input type="hidden" name="search" value="${pagination.searchValues[0]}" />
                                        <input type="hidden" name="sort" value="username" />
                                        <input type="hidden" name="order" value="${pagination.sort eq 'username' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />
                                        <button type="submit" class="btn-sort">
                                            <i class="align-middle fas fa-fw
                                               ${pagination.sort eq 'username' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}">
                                            </i>
                                        </button>
                                        Username
                                    </form>
                                </th>

                                <th style="width:15%">
                                    <form action="manageCustomerVer2" method="get">
                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                        <input type="hidden" name="search" value="${pagination.searchValues[0]}" />
                                        <input type="hidden" name="sort" value="address" />
                                        <input type="hidden" name="order" value="${pagination.sort eq 'address' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />
                                        <button type="submit" class="btn-sort">
                                            <i class="align-middle fas fa-fw
                                               ${pagination.sort eq 'address' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}">
                                            </i>
                                        </button>
                                        Address
                                    </form>
                                </th>

                                <th style="width:8%">Action<a href="manageCustomerVer2?page=${pagination.currentPage}&page-size=${pagination.pageSize}"><i class="fa fa-refresh ms-2"></i></a></th>
                            </tr>
                        </thead>
                        <tbody>
                            <!--                        varStatus để lấy trạng thái của vòng lặp-->
                            <c:forEach var="customer" items="${customers}" varStatus="status">
                                <tr class="${status.index % 2 == 0 ? 'table-primary' : ''}">
                                    <td><a href="viewCustomer?customerId=${customer.customerId}">${status.index + 1 + (pagination.currentPage - 1) * pagination.pageSize}</a></td>
                                    <td>${customer.fullname}</td>
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
                                    <td>${customer.dob}</td>
                                    <td>${customer.email}</td>
                                    <td>${customer.username}</td>
                                    <td>${customer.address}</td>
                                    <td class="table-action">
                                        <a href="ComponentWarehouse/Detail?ID=${customer.customerId}&from=warehouse">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit-2 align-middle">
                                            <path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path>
                                            </svg>
                                        </a>
                                        <a data-bs-toggle="modal" data-bs-target="#centeredModalPrimary_${customer.customerId}">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash align-middle">
                                            <polyline points="3 6 5 6 21 6"></polyline>
                                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                            </svg>
                                        </a>
                                    </td>
                                </tr>

                                <!-- Modal for each component -->
                            <div class="modal fade" id="centeredModalPrimary_${customer.customerId}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Delete Confirmation</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body m-3">
                                            <p class="mb-0">Confirm your action. Really want to delete?</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <a href="ComponentWarehouse/Delete?ID=${customer.customerId}&page=${pagination.currentPage}&page-size=${pagination.pageSize}&search=${pagination.searchValues[0]}&sort=${pagination.sort}&order=${pagination.order}" class="btn btn-primary">Delete</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>


                        </tbody>
                    </table>
                    <c:if test="${totalCustomers==0}">
                        <div class="alert alert-primary alert-dismissible" role="alert">
                            <div class="alert-message text-center">
                                <strong style="font-size:1.6rem">No suitable card in the filter</strong>
                            </div>
                        </div>

                    </c:if>
                    <jsp:include page="../homepage/pagination.jsp" />

                    <c:if test="${not empty deleteStatus}">
                        <div class="alert alert-warning alert-dismissible" role="alert">
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            <div class="alert-message">
                                <strong>${deleteStatus}</strong>
                            </div>
                        </div>
                    </c:if>
            </div>

        </main>
        <%--<jsp:include page="../../includes/footer.jsp" />--%>
    </div>

</div>

<script src="${pageContext.request.contextPath}/adminassets/js/app.js"></script>
<script src="${pageContext.request.contextPath}/adminassets/js/format-input.js"></script>

</body>

</html>