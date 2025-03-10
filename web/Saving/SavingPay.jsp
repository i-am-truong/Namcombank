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
        </style>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <%@include file="../homepage/sidebar_admin.jsp" %>

            <div class="container">
                <h2>Danh sách khoản tiết kiệm sắp đến hạn</h2>
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer ID</th>
                            <th>Amount</th>
                            <th>Interest Rate</th>
                            <th>Term (Months)</th>
                            <th>Opened Date</th>
                            <th>Money Get Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="saving" items="${list}">
                            <tr>
                                <td>${saving.savings_id}</td>
                                <td>${saving.customer_id}</td>
                                <td><fmt:formatNumber value="${saving.amount}" type="number" /></td>
                                <td><fmt:formatNumber value="${saving.interest_rate}" type="number" maxFractionDigits="3"/></td>
                                <td>${saving.term_months}</td>
                                <td>${saving.opened_date}</td>
                                <td>${saving.money_get_date}</td>
                                <td>${saving.status}</td>
                                <td>
                                    <form action="SavingPay" method="post">
                                        <input type="hidden" name="savings_id" value="${saving.savings_id}">
                                        <button type="submit" class="btn btn-approve">Paid</button>
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
