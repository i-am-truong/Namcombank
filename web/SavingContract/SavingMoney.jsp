<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Customer Saving Request</title>
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 20px;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 12px;
                text-align: center;
            }
            .btn {
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
            }
            .btn-approve {
                background-color: #28a745;
                color: white;
            }
            .btn-reject {
                background-color: #dc3545;
                color: white;
            }
            .search-container {
                background-color: #e9ecef;
                padding: 15px;
                border: 1px solid green;
                margin-bottom: 20px;
            }
            .search-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 10px;
            }
        </style>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <%@include file="../homepage/sidebar_admin.jsp" %>

            <div id="content-wrapper" class="d-flex flex-column">
                <%@include file="../homepage/header_admin.jsp" %>
                <div class="container">
                    <h2 class="text-center">Customer Saving Money</h2>
                    <!-- Search Section -->
                    <!--                    <div class="search-container">
                                            <div class="search-grid">
                                                <div class="form-group">
                                                    <label for="customerName">Customer Name</label>
                                                    <input type="text" id="customerName" name="customerName" class="form-control" 
                                                           value="${customerName}" placeholder="Customer name">
                                                </div>
                                                <div class="form-group">
                                                    <label for="packageName">Loan Package</label>
                                                    <input type="text" id="packageName" name="packageName" class="form-control" 
                                                           value="${packageName}" placeholder="Loan package name">
                                                </div>
                                                <div class="form-group">
                                                    <label for="minAmount">Amount From</label>
                                                    <input type="number" id="minAmount" name="minAmount" class="form-control" 
                                                           value="${minAmount}" placeholder="Minimum amount">
                                                </div>
                                                <div class="form-group">
                                                    <label for="maxAmount">Amount To</label>
                                                    <input type="number" id="maxAmount" name="maxAmount" class="form-control" 
                                                           value="${maxAmount}" placeholder="Maximum amount">
                                                </div>
                                            </div>
                                        </div>-->


                    <table class="table">
                        <thead>
                            <tr>
                                <th>saving_request_id</th>
                                <th>Saving_Package_ID</th>
                                <th>Customer ID</th>
                                <th>Customer Name</th>
                                <th>Saving Package</th>
                                <th>Money</th>
                                <!--<th>Approval Status</th>-->
                                <th>Created At</th>
                                <th>Approval Date</th>
                                <!--<th>Saving Date</th>-->
                                <!--<th>Staff ID</th>-->
                                <th>Money status</th>
                                <th>Amount</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="sr" items="${list}">
                                <tr>
                                    <td>${sr.saving_request_id}</td>
                                    <td>${sr.saving_package_id}</td>
                                    <td>${sr.customer_id}</td>
                                    <td>${sr.customer_name}</td>
                                    <td>${sr.saving_package_name}</td>
                                    <td><fmt:formatNumber value="${sr.money}" />VND</td>
                                    <!--<td>$/{sr.saving_approval_status}</td>-->
                                    <td>
                                        <fmt:parseDate value="${sr.created_at}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <fmt:parseDate value="${sr.saving_approval_date}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <!--<td>$/{sr.saving_date}</td>-->
                                    <!--<td>$/{sr.staff_id}</td>-->
                                    <td>${sr.money_approval_status}</td>
                                    <td><fmt:formatNumber value="${sr.amount}" />VND</td>
                                    <td>
                                        <form action="savingMoney" method="post" style="display:inline;">
                                            <input type="hidden" name="saving_request_id" value="${sr.saving_request_id}">
                                            <input type="hidden" name="money_approval_status" value="received">
                                            <button type="submit" class="btn btn-approve">Đã nhận được tiền</button>
                                        </form>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>    
            </div>
    </body>
</html>
