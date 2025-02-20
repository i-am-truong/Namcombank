<%--
    Document   : ComponentWarehouse
    Created on : Jan 17, 2025, 8:24:34 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link href="${pageContext.request.contextPath}/adminassets/css/range-slider.css" rel="stylesheet">
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

            <div class="main">
                <jsp:include page="../homepage/header_admin.jsp" />

                <main class="content">
                    <a href="manageCustomerVer2" class="btn btn-primary  d-flex align-items-center justify-content-center" style="transform:translate(-30%,-60%); height: 2.5rem; width: 5.2rem"><i class="fas fa-arrow-left fa-4"></i> <span class="ms-2">Back</span> </a>
                    <h2>Advanced Search</h2>
                    <form action="manageCustomerVer2/Search" method="get" class="row align-items-center">
                        <input type="hidden" name="page" value="${pagination.currentPage}" />
                        <input type="hidden" name="sort" value="${pagination.sort}" />
                        <input type="hidden" name="order" value="${pagination.order}" />
                        <div class="col-md-3 input-group d-flex justify-content-end">
                            <input type="search" style="flex: 1 1 auto"
                                   class="form-control form-control-md"
                                   placeholder="Username"
                                   name="searchUserName"
                                   value="${pagination.searchValues[1]}" />
                            <select name="searchGender" class="form-select form-select-md" style="flex: 1 1 auto;">
                                <option value="">Gender</option>
                                <c:forEach var="gender" items="${genderList}">
                                    <option value="${gender.gendername}" ${pagination.searchValues[2] eq gender.gendername ? "selected" : ""}>${gender.gendername}</option>
                                </c:forEach>
                            </select>

                            <select name="searchAccountStatus" class="form-select form-select-md" style="flex: 1 1 auto;">
                                <option value="">Account Status</option>
                                <c:forEach var="active" items="${activeList}">
                                    <option value="${active.activename}" ${pagination.searchValues[3]  eq active.activename ? "selected" : ""}>${active.activename}</option>
                                </c:forEach>
                            </select>
                            <input type="search" style="flex: 1 1 auto"
                                   class="form-control form-control-md"
                                   placeholder="Fullname"
                                   name="searchFullName"
                                   value="${pagination.searchValues[0]}" />
                            <button type="submit" class="btn btn-primary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search align-middle"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                            </button>
                        </div>
                        <div class="row">
                            <div class="col-md-3 input-group d-flex justify-content-end">
                                <input type="search" style="flex: 1 1 auto"
                                       class="form-control form-control-md"
                                       placeholder="Citizen Identification Card"
                                       name="searchCID"
                                       value="${pagination.searchValues[4]}" />
                                <input type="search" style="flex: 1 1 auto"
                                       class="form-control form-control-md"
                                       placeholder="Address"
                                       name="searchAddress"
                                       value="${pagination.searchValues[5]}" />
                                <input type="search" style="flex: 1 1 auto"
                                       class="form-control form-control-md"
                                       placeholder="Email"
                                       name="searchEmail"
                                       value="${pagination.searchValues[6]}" />
                                <input type="search" style="flex: 1 1 auto"
                                       class="form-control form-control-md"
                                       placeholder="Phone Number"
                                       name="searchPhoneNumber"
                                       value="${pagination.searchValues[7]}" />
                            </div>
                        </div>
                        <!--                        <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="slider-container" data-type="quantity">
                                                            <div class="price-input">
                                                                <div class="field">
                                                                    <span>Quantity</span>
                                                                    <input type="text" class="input-min format-int" name="searchQuantityMin" value="${pagination.rangeValues[2]}" step="1">
                                                                </div>
                                                                <div class="separator">-</div>
                                                                <div class="field">
                                                                    <input type="text" class="input-max format-int" name="searchQuantityMax" value="${pagination.rangeValues[3]}" step="1">
                                                                </div>
                                                            </div>
                                                            <div class="slider">
                                                                <div class="progress"></div>
                                                            </div>
                                                            <div class="range-input">
                                                                <input type="range" class="range-min" min="0" max="${quantityMax}" value="${pagination.rangeValues[2]}" step="1">
                                                                <input type="range" class="range-max" min="0" max="${quantityMax}" value="${pagination.rangeValues[3]}" step="1">
                                                            </div>
                                                        </div>
                                                    </div>

                        -->
                    <div class="row">
                            <div class="col-md-6">
                                <div class="slider-container" data-type="balance">
                                    <div class="price-input">
                                        <div class="field">
                                            <span>Balance</span>
                                            <input type="text"
                                                  class="input-min format-float"
                                                  name="searchBalanceMin"
                                                  value="${pagination.rangeValues[0]}"
                                                  step="0.01">
                                        </div>
                                        <div class="separator">-</div>
                                        <div class="field">
                                            <input type="text"
                                                  class="input-max format-float"
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
                        </div>
                        <!--
                                                </div>-->




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
                    </form>
                    <table class="table table-hover my-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>
                                    <form action="manageCustomerVer2/Search" method="get">
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
                                            <i class="align-middle fas fa-fw
                                               ${pagination.sort eq 'fullname' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}">
                                            </i>
                                        </button>
                                        Full Name
                                    </form>
                                </th>
                                <th>Gender</th>
                                <th>Date of Birth</th>
                                <th>
                                    <form action="manageCustomerVer2/Search" method="get">
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
                                                <input type="hidden" name="${pagination.rangeFields[i]}" value="${pagination.searchValues[i]}">
                                            </c:forEach>
                                        </c:if>
                                        <button type="submit" class="btn-sort">
                                            <i class="align-middle fas fa-fw
                                               ${pagination.sort eq 'email' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}">
                                            </i>
                                        </button>
                                        Email
                                    </form>
                                </th>

                                <th>CID</th>

                                <th>Status</th>

                                <th>
                                    <form action="manageCustomerVer2/Search" method="get">
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
                                                <input type="hidden" name="${pagination.rangeFields[i]}" value="${pagination.searchValues[i]}">
                                            </c:forEach>
                                        </c:if>
                                        <button type="submit" class="btn-sort">
                                            <i class="align-middle fas fa-fw
                                               ${pagination.sort eq 'username' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}">
                                            </i>
                                        </button>
                                        Username
                                    </form>
                                </th>

                                <th>
                                    <form action="manageCustomerVer2/Search" method="get">
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
                                                <input type="hidden" name="${pagination.rangeFields[i]}" value="${pagination.searchValues[i]}">
                                            </c:forEach>
                                        </c:if>
                                        <button type="submit" class="btn-sort">
                                            <i class="align-middle fas fa-fw
                                               ${pagination.sort eq 'address' ? (pagination.order eq 'asc' ? 'fa-sort-up' : 'fa-sort-down') : 'fa-sort'}">
                                            </i>
                                        </button>
                                        Address
                                    </form>
                                </th>

                                <th>Balance</th>


                                <th>Action<a href="manageCustomerVer2/Search?page=${pagination.currentPage}&page-size=${pagination.pageSize}"><i class="fa fa-refresh ms-2"></i></a></th>
                            </tr>
                        </thead>
                        <!--                        varStatus để lấy trạng thái của vòng lặp-->
                        <c:forEach var="customer" items="${customers}" varStatus="status">
                            <tr class="${status.index % 2 == 0 ? 'table-primary' : ''}">
                                <td><a href="viewCustomer?customerId=${customer.customerId}">${status.index+1+(pagination.currentPage-1)*pagination.pageSize}</a></td>
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
                                <td>${customer.cid}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${customer.active == 0}">
                                            <span class="badge bg-danger">Closed</span>
                                            <a href="javascript:void(0)" onclick="return checkUnBan('${customer.customerId}')">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-unlock" viewBox="0 0 16 16">
                                                <path d="M11 1a2 2 0 0 0-2 2v4a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h5V3a3 3 0 0 1 6 0v4a.5.5 0 0 1-1 0V3a2 2 0 0 0-2-2M3 8a1 1 0 0 0-1 1v5a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V9a1 1 0 0 0-1-1z"/>
                                                </svg>
                                            </a>
                                        </c:when>
                                        <c:when test="${customer.active == 1}">
                                            <span class="badge bg-success">Opening</span>
                                            <a href="javascript:void(0)" onclick="return checkBan('${customer.customerId}')">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock" viewBox="0 0 16 16">
                                                <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2M5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1"/>
                                                </svg>
                                            </a>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>${customer.username}</td>
                                <td>${customer.address}</td>
                                <td>${customer.balance}</td>
                                <td class="table-action">
                                    <a href="editCustomer?customerId=${customer.customerId}"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit-2 align-middle"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path></svg></a>
                                    <a href="javascript:void(0)" onclick="return checkDeleteCustomer('${customer.customerId}')"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash align-middle"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg></a>
                                </td>
                            </tr>
<!--                            <div class="modal fade" id="centeredModalPrimary_${component.componentID}" tabindex="-1" style="display: none;" aria-hidden="true">
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
                                            <a href="ComponentWarehouse/Delete?ID=${component.componentID}&page=${pagination.currentPage}&page-size=${pagination.pageSize}&searchCode=${pagination.searchValues[1]}&searchName=${pagination.searchValues[0]}&sort=${sort}&order=${order}&searchType=${pagination.searchValues[2]}&searchBrand=${pagination.searchValues[3]}&searchQuantityMin=${pagination.rangeValues[2]}&searchQuantityMax=${pagination.rangeValues[3]}&searchPriceMin=${pagination.rangeValues[0]}&searchPriceMax=${pagination.rangeValues[1]}" type="button" class="btn btn-primary">Delete</a>
                                        </div>
                                    </div>
                                </div>
                            </div>-->
                        </c:forEach>
                        <tbody>

                        </tbody>
                    </table>
                    <c:if test="${totalCustomers==0}">
                        <div class="alert alert-primary alert-dismissible" role="alert">
                            <div class="alert-message text-center">
                                <strong style="font-size:1.6rem">No customer found in the filter</strong>
                            </div>
                        </div>

                    </c:if>
                    <jsp:include page="../homepage/pagination.jsp" />

                    <!--<c:if test="${not empty deleteStatus}">
                        <div class="alert alert-warning alert-dismissible" role="alert">
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            <div class="alert-message">
                                <strong>${deleteStatus}</strong>
                            </div>
                        </div>
                    </c:if> -->
            </div>
        </main>
        <%--<jsp:include page="../../includes/footer.jsp" />--%>
    </div>

</div>

<script src="${pageContext.request.contextPath}/adminassets/js/app.js"></script>
<script src="${pageContext.request.contextPath}/adminassets/js/range-slider.js"></script>
<script src="${pageContext.request.contextPath}/adminassets/js/format-input.js"></script>

<script>
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
</script>



</body>

</html>

