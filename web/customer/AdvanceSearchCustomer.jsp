<%--
    Document   : ComponentWarehouse
    Created on : Jan 17, 2025, 8:24:34 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link href="${pageContext.request.contextPath}/adminassets/css/range-slider.css" rel="stylesheet">

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

            .customer-img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 50%;
            }

            .badge {
                font-size: 85%;
            }

            .alert {
                margin-top: 15px;
            }

            /* Filter section styling */
            .filter-section {
                background: #f8f9fc;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }

            .filter-row {
                margin-bottom: 15px;
            }

            .filter-label {
                font-weight: 600;
                margin-bottom: 5px;
                color: #198754;
            }

            .slider-container {
                margin: 15px 0;
            }

            .price-input {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .price-input .field {
                flex: 1;
            }

            .separator {
                margin: 0 10px;
            }

            /* Table layout fixes */
            .table {
                table-layout: fixed;
                width: 100%;
            }

            /* Column width adjustments */
            .table th.id-col {
                width: 50px;
            }
            .table th.name-col {
                width: 120px;
            }
            .table th.img-col {
                width: 80px;
            }
            .table th.gender-col {
                width: 80px;
            }
            .table th.dob-col {
                width: 100px;
            }
            .table th.email-col {
                width: 150px;
            }
            .table th.phone-col {
                width: 120px;
            }
            .table th.cid-col {
                width: 120px;
            }
            .table th.status-col {
                width: 100px;
            }
            .table th.username-col {
                width: 120px;
            }
            .table th.address-col {
                width: 150px;
            }
            .table th.balance-col {
                width: 120px;
            }
            .table th.actions-col {
                width: 80px;
            }

            /* Text overflow handling */
            .table td {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            /* Make sure action buttons are always visible */
            .table td.actions-cell {
                white-space: nowrap;
                overflow: visible;
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
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div>
                                    <h1 class="h3 mb-0 text-gray-800">Advanced Customer Search</h1>
                                    <p class="mb-0">Filter customers using multiple criteria</p>
                                </div>
                                <a href="manageCustomerVer2" class="btn btn-outline-primary ">
                                    <i class="fas fa-arrow-left "></i> Back to Customer List
                                </a>
                            </div>

                            <!-- Advanced Search Form -->
                            <div class="filter-section">
                                <form action="manageCustomerVer2/Search" method="get" class="mb-0">
                                    <input type="hidden" name="page" value="${pagination.currentPage}" />
                                    <input type="hidden" name="sort" value="${pagination.sort}" />
                                    <input type="hidden" name="order" value="${pagination.order}" />

                                    <!-- Basic Search Fields -->
                                    <div class="row filter-row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="filter-label">Full Name</label>
                                                <input type="search"
                                                       class="form-control"
                                                       placeholder="Search by name"
                                                       name="searchFullName"
                                                       value="${pagination.searchValues[0]}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="filter-label">Username</label>
                                                <input type="search"
                                                       class="form-control"
                                                       placeholder="Search by username"
                                                       name="searchUserName"
                                                       value="${pagination.searchValues[1]}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="filter-label">Gender</label>
                                                <select name="searchGender" class="form-select form-control">
                                                    <option value="">All Genders</option>
                                                    <c:forEach var="gender" items="${genderList}">
                                                        <option value="${gender.gendername}" ${pagination.searchValues[2] eq gender.gendername ? "selected" : ""}>${gender.gendername}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="filter-label">Account Status</label>
                                                <select name="searchAccountStatus" class="form-select form-control">
                                                    <option value="">All Statuses</option>
                                                    <c:forEach var="active" items="${activeList}">
                                                        <option value="${active.activename}" ${pagination.searchValues[3] eq active.activename ? "selected" : ""}>${active.activename}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Contact Information -->
                                    <div class="row filter-row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="filter-label">CID</label>
                                                <input type="search"
                                                       class="form-control"
                                                       placeholder="Citizen ID"
                                                       name="searchCID"
                                                       value="${pagination.searchValues[4]}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="filter-label">Email</label>
                                                <input type="search"
                                                       class="form-control"
                                                       placeholder="Email address"
                                                       name="searchEmail"
                                                       value="${pagination.searchValues[6]}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="filter-label">Phone Number</label>
                                                <input type="search"
                                                       class="form-control"
                                                       placeholder="Phone number"
                                                       name="searchPhoneNumber"
                                                       value="${pagination.searchValues[7]}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="filter-label">Address</label>
                                                <input type="search"
                                                       class="form-control"
                                                       placeholder="Address"
                                                       name="searchAddress"
                                                       value="${pagination.searchValues[5]}">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Range Filters -->
                                    <div class="row filter-row">
                                        <div class="col-md-6">
                                            <label class="filter-label">Balance Range</label>
                                            <div class="slider-container" data-type="balance">
                                                <div class="price-input">
                                                    <div class="field">
                                                        <span>Min</span>
                                                        <input type="text"
                                                               class="form-control input-min format-float"
                                                               name="searchBalanceMin"
                                                               value="${pagination.rangeValues[0]}"
                                                               step="0.01">
                                                    </div>
                                                    <div class="separator">-</div>
                                                    <div class="field">
                                                        <span>Max</span>
                                                        <input type="text"
                                                               class="form-control input-max format-float"
                                                               name="searchBalanceMax"
                                                               value="${pagination.rangeValues[1]==balanceMax?pagination.rangeValues[1]+0.01:pagination.rangeValues[1]}"
                                                               step="0.01">
                                                    </div>
                                                </div>
                                                <div class="slider">
                                                    <div class="progress"></div>
                                                </div>
                                                <div class="range-input">
                                                    <input type="range"
                                                           class="range-min"
                                                           min="0"
                                                           max="${balanceMax + 0.01}"
                                                           value="${pagination.rangeValues[0]}"
                                                           step="0.01">
                                                    <input type="range"
                                                           class="range-max"
                                                           min="0"
                                                           max="${balanceMax + 0.01}"
                                                           value="${pagination.rangeValues[1]==balanceMax?pagination.rangeValues[1]+0.01:pagination.rangeValues[1]}"
                                                           step="0.01">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <label class="filter-label">Date of Birth Range</label>
                                            <div class="price-input">
                                                <div class="field">
                                                    <span>From</span>
                                                    <input type="date"
                                                           class="form-control"
                                                           name="searchDateMin"
                                                           value="${pagination.rangeValues[2]}"
                                                           min="${dateMin}"
                                                           max="${dateMax}">
                                                </div>
                                                <div class="separator">-</div>
                                                <div class="field">
                                                    <span>To</span>
                                                    <input type="date"
                                                           class="form-control"
                                                           name="searchDateMax"
                                                           value="${pagination.rangeValues[3]}"
                                                           min="${dateMin}"
                                                           max="${dateMax}">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="row mt-4">
                                        <div class="col-md-6">
                                            <div class="form-group d-flex align-items-center">
                                                <label class="me-2 mb-0">Show</label>
                                                <select name="page-size" class="form-select form-control" style="width: auto;">
                                                    <c:forEach items="${pagination.listPageSize}" var="s">
                                                        <option value="${s}" ${pagination.pageSize==s?"selected":""}>${s}</option>
                                                    </c:forEach>
                                                </select>
                                                <label class="ms-2 mb-0">entries</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-end">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-search"></i> Search
                                            </button>
                                            <a href="manageCustomerVer2/Search" class="btn btn-secondary ms-2">
                                                <i class="fas fa-undo"></i> Reset Filters
                                            </a>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <!-- Results Table -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover" id="dataTable">
                                    <thead class="thead-light">
                                        <tr>
                                            <th class="id-col">ID</th>
                                            <th class="name-col">
                                                <div class="d-flex align-items-center">
                                                    <form action="manageCustomerVer2/Search" method="get" class="me-1">
                                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                                        <input type="hidden" name="sort" value="fullname" />
                                                        <input type="hidden" name="order" value="${pagination.sort eq 'fullname' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />

                                                        <c:if test="${fn:length(pagination.searchFields) > 0}">
                                                            <c:forEach var="i" begin="0" end="${fn:length(pagination.searchFields) - 1}">
                                                                <input type="hidden" name="${pagination.searchFields[i]}" value="${pagination.searchValues[i]}">
                                                            </c:forEach>
                                                        </c:if>

                                                        <c:if test="${fn:length(pagination.rangeFields) > 0}">
                                                            <c:forEach var="i" begin="0" end="${fn:length(pagination.rangeFields) - 1}">
                                                                <input type="hidden" name="${pagination.rangeFields[i]}" value="${pagination.rangeValues[i]}">
                                                            </c:forEach>
                                                        </c:if>

                                                        <button type="submit" class="btn-sort">
                                                            <i class="fas ${pagination.sort eq 'fullname' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}"></i>
                                                        </button>
                                                    </form>
                                                    Full Name
                                                </div>
                                            </th>
                                            <th class="img-col">Image</th>
                                            <th class="gender-col">Gender</th>
                                            <th class="dob-col">Date of Birth</th>
                                            <th class="email-col">
                                                <div class="d-flex align-items-center">
                                                    <form action="manageCustomerVer2/Search" method="get" class="me-1">
                                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                                        <input type="hidden" name="sort" value="email" />
                                                        <input type="hidden" name="order" value="${pagination.sort eq 'email' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />

                                                        <c:if test="${fn:length(pagination.searchFields) > 0}">
                                                            <c:forEach var="i" begin="0" end="${fn:length(pagination.searchFields) - 1}">
                                                                <input type="hidden" name="${pagination.searchFields[i]}" value="${pagination.searchValues[i]}">
                                                            </c:forEach>
                                                        </c:if>

                                                        <c:if test="${fn:length(pagination.rangeFields) > 0}">
                                                            <c:forEach var="i" begin="0" end="${fn:length(pagination.rangeFields) - 1}">
                                                                <input type="hidden" name="${pagination.rangeFields[i]}" value="${pagination.rangeValues[i]}">
                                                            </c:forEach>
                                                        </c:if>

                                                        <button type="submit" class="btn-sort">
                                                            <i class="fas ${pagination.sort eq 'email' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}"></i>
                                                        </button>
                                                    </form>
                                                    Email
                                                </div>
                                            </th>
                                            <th class="phone-col">Phone</th>
                                            <th class="cid-col">CID</th>
                                            <th class="status-col">Status</th>
                                            <th class="username-col">
                                                <div class="d-flex align-items-center">
                                                    <form action="manageCustomerVer2/Search" method="get" class="me-1">
                                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                                        <input type="hidden" name="sort" value="username" />
                                                        <input type="hidden" name="order" value="${pagination.sort eq 'username' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />

                                                        <c:if test="${fn:length(pagination.searchFields) > 0}">
                                                            <c:forEach var="i" begin="0" end="${fn:length(pagination.searchFields) - 1}">
                                                                <input type="hidden" name="${pagination.searchFields[i]}" value="${pagination.searchValues[i]}">
                                                            </c:forEach>
                                                        </c:if>

                                                        <c:if test="${fn:length(pagination.rangeFields) > 0}">
                                                            <c:forEach var="i" begin="0" end="${fn:length(pagination.rangeFields) - 1}">
                                                                <input type="hidden" name="${pagination.rangeFields[i]}" value="${pagination.rangeValues[i]}">
                                                            </c:forEach>
                                                        </c:if>

                                                        <button type="submit" class="btn-sort">
                                                            <i class="fas ${pagination.sort eq 'username' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}"></i>
                                                        </button>
                                                    </form>
                                                    Username
                                                </div>
                                            </th>
                                            <th class="address-col">
                                                <div class="d-flex align-items-center">
                                                    <form action="manageCustomerVer2/Search" method="get" class="me-1">
                                                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                                                        <input type="hidden" name="page-size" value="${pagination.pageSize}" />
                                                        <input type="hidden" name="sort" value="address" />
                                                        <input type="hidden" name="order" value="${pagination.sort eq 'address' and pagination.order eq 'asc' ? 'desc' : 'asc'}" />

                                                        <c:if test="${fn:length(pagination.searchFields) > 0}">
                                                            <c:forEach var="i" begin="0" end="${fn:length(pagination.searchFields) - 1}">
                                                                <input type="hidden" name="${pagination.searchFields[i]}" value="${pagination.searchValues[i]}">
                                                            </c:forEach>
                                                        </c:if>

                                                        <c:if test="${fn:length(pagination.rangeFields) > 0}">
                                                            <c:forEach var="i" begin="0" end="${fn:length(pagination.rangeFields) - 1}">
                                                                <input type="hidden" name="${pagination.rangeFields[i]}" value="${pagination.rangeValues[i]}">
                                                            </c:forEach>
                                                        </c:if>

                                                        <button type="submit" class="btn-sort">
                                                            <i class="fas ${pagination.sort eq 'address' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}"></i>
                                                        </button>
                                                    </form>
                                                    Address
                                                </div>
                                            </th>
                                            <th class="balance-col">Balance</th>
                                            <th class="actions-col">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    Actions
                                                    <a href="manageCustomerVer2/Search?page=${pagination.currentPage}&page-size=${pagination.pageSize}" class="text-primary">
                                                        <i class="fas fa-sync-alt"></i>
                                                    </a>
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="customer" items="${customers}" varStatus="status">
                                            <tr class="${status.index % 2 == 0 ? 'table-light' : ''}">
                                                <td>
                                                    <a href="viewCustomer?customerId=${customer.customerId}">
                                                        ${status.index+1+(pagination.currentPage-1)*pagination.pageSize}
                                                    </a>
                                                </td>
                                                <td title="${customer.fullname}">${customer.fullname}</td>
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
                                                        <c:when test="${customer.gender == 0}">Female</c:when>
                                                        <c:when test="${customer.gender == 1}">Male</c:when>
                                                    </c:choose>
                                                </td>
                                                <td><fmt:formatDate value="${customer.dob}" pattern="dd/MM/yyyy"/></td>
                                                <td title="${customer.email}">${customer.email}</td>
                                                <td>${customer.phonenumber}</td>
                                                <td>${customer.cid}</td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:choose>
                                                            <c:when test="${customer.active == 0}">
                                                                <span class="badge bg-danger me-2">Closed</span>
                                                                <a href="javascript:void(0)" onclick="return checkUnBan('${customer.customerId}')" title="Unlock account">
                                                                    <i class="fas fa-unlock text-success"></i>
                                                                </a>
                                                            </c:when>
                                                            <c:when test="${customer.active == 1}">
                                                                <span class="badge bg-success me-2">Opening</span>
                                                                <a href="javascript:void(0)" onclick="return checkBan('${customer.customerId}')" title="Lock account">
                                                                    <i class="fas fa-lock text-danger"></i>
                                                                </a>
                                                            </c:when>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                                <td title="${customer.username}">${customer.username}</td>
                                                <td title="${customer.address}">${customer.address}</td>
                                                <td>
                                                    <fmt:formatNumber value="${customer.balance}" pattern="#,##0"></fmt:formatNumber>
                                                </td>
                                                <td class="actions-cell">
                                                    <div class="d-flex">
                                                        <a href="editCustomer?customerId=${customer.customerId}" class="btn btn-primary btn-sm me-1" title="Edit customer">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <button type="button" onclick="return checkDeleteCustomer('${customer.customerId}')" class="btn btn-danger btn-sm" title="Delete customer">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
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
        <script src="${pageContext.request.contextPath}/adminassets/js/range-slider.js"></script>
        <script src="${pageContext.request.contextPath}/adminassets/js/format-input.js"></script>

        <script>
            function checkBan(cid) {
                if (confirm("Are you sure you want to lock this customer account?")) {
                    window.location = 'lockCustomer?type=lock&cid=' + cid;
                }
                return false;
            }

            function checkUnBan(cid) {
                if (confirm("Are you sure you want to unlock this customer account?")) {
                    window.location = 'lockCustomer?type=unlock&cid=' + cid;
                }
                return false;
            }

            function checkDeleteCustomer(cid) {
                if (confirm('Are you sure you want to delete this customer?')) {
                    window.location = 'deleteCustomer?cid=' + cid;
                    return true;
                }
                return false;
            }

// Initialize tooltips
            document.addEventListener('DOMContentLoaded', function () {
                // Check if Bootstrap 5 tooltip functionality exists
                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
                    tooltipTriggerList.map(function (tooltipTriggerEl) {
                        return new bootstrap.Tooltip(tooltipTriggerEl);
                    });
                }
            });

        </script>
    </body>
</html>