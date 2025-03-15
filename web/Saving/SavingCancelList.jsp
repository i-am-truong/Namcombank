<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Customer Saving Cancel</title>
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
        </style>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <%@include file="../homepage/sidebar_admin.jsp" %>
            <div id="content-wrapper" class="d-flex flex-column">
                <%@include file="../homepage/header_admin.jsp" %>
                <div class="container">
                    <h2 class="text-center">Customer Saving Cancel</h2>
                    <!-- private int savings_id;
                        private int customer_id;
                        private double amount;
                        private double interest_rate;
                        private int term_months;
                        private String opened_date;
                        private String status;
                        private int saving_request_id;
                        private int staff_id;
                        private String money_get_date;
                        private String customer_name;-->
                    <!-- Danh sách yêu cầu hủy sổ tiết kiệm -->

                    <form action="SavingCancelList" method="post">
                        <label for="customer_name">Nhập tên:</label>
                        <input type="text" id="customer_name" name="customer_name" value="${name_selected}">
                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </form>

                    <c:if test="${not empty listPaging}">
                        <table class="table table-bordered mt-3">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID</th>                                
                                    <th>Customer ID</th>
                                    <th>Customer Name</th>
                                    <th>Amount</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="saving" items="${listPaging}">
                                    <tr>
                                        <td>${saving.savings_id}</td>
                                        <td>${saving.customer_id}</td>
                                        <td>${saving.customer_name}</td>
                                        <td><fmt:formatNumber value="${saving.amount}" type="currency" currencySymbol="VND" /></td>
                                        <td><fmt:parseDate value="${saving.opened_date}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td><fmt:parseDate value="${saving.money_get_date}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <form action="SavingCancel" method="post" style="display: inline;">
                                                <input type="hidden" name="savings_id" value="${saving.savings_id}">
                                                <button type="submit" class="btn btn-approve">Cancel</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>

                        </table>
                    </c:if>
                    <div class="text-center mt-3">
                        <c:forEach begin="1" end="${endPage}" var="i">
                            <a href="SavingCancel?index=${i}&customer_name=${name_selected}" class="btn btn-outline-primary">${i}</a>
                        </c:forEach>
                    </div>
                </div>

            </div>
    </body>
</html>
