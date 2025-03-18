<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách yêu cầu tiết kiệm</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
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
                border: 5px solid #81c784;
            }
            th, td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }
            .btn {
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-back {
                background-color: #28a745; /* Xanh lá chủ đạo */
                color: white;
                border: none;
                padding: 8px 15px;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-back:hover {
                background-color: #218838; /* Màu xanh đậm hơn khi hover */
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Danh sách yêu cầu tiết kiệm</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Saving Package ID</th>
                        <th>Staff ID</th>
                        <th>Money</th>
                        <th>Saving Approval Status</th>
                        <th>Saving Approval Date</th>
                        <th>Money Approval Status</th>
                        <th>Amount</th>
                        <th>Created At</th>
                        <th>Saving Package Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${list}">
                        <tr>
                            <td>${r.customer_id}</td>
                            <td>${r.saving_package_id}</td>
                            <td>${r.staff_id}</td>
                            <td><fmt:formatNumber value="${r.money}" type="currency"/></td>
                            <td>${r.saving_approval_status}</td>
                            <td>${r.saving_approval_date}</td>
                            <td>${r.money_approval_status}</td>
                            <td><fmt:formatNumber value="${r.amount}" type="currency"/></td>
                            <td>
                                <fmt:parseDate value="${r.created_at}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>${r.saving_package_name}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <h2>Danh sách đã được duyệt yêu cầu nộp tiền</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Saving Package ID</th>
                        <th>Staff ID</th>
                        <th>Money</th>
                        <th>Saving Approval Status</th>
                        <th>Saving Approval Date</th>
                        <th>Money Approval Status</th>
                        <th>Amount</th>
                        <th>Created At</th>
                        <th>Saving Package Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${listP}">
                        <tr>
                            <td>${p.customer_id}</td>
                            <td>${p.saving_package_id}</td>
                            <td>${p.staff_id}</td>
                            <td><fmt:formatNumber value="${p.money}" type="currency"/></td>
                            <td>${p.saving_approval_status}</td>
                            <td>${p.saving_approval_date}</td>
                            <td>${p.money_approval_status}</td>
                            <td><fmt:formatNumber value="${p.amount}" type="currency"/></td>
                            <td>
                                <fmt:parseDate value="${p.created_at}" pattern="yyyy-MM-dd" var="parsedDateP" type="date"/>
                                <fmt:formatDate value="${parsedDateP}" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>${p.saving_package_name}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <button class="btn-back" onclick="window.location.href = 'Home'">Quay Lại</button>
        </div>
    </body>
</html>
