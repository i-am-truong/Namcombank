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
                <h2 class="text-center">Customer Saving Requests</h2>
                <table class="table">
                    <thead>
                        <tr>
                            <th>saving_request_id</th>
                            <th>Saving_Package_ID</th>
                            <th>Customer ID</th>
                            <th>Saving Package</th>
                            <th>Money</th>
                            <th>Approval Status</th>
                            <th>Created At</th>
                            <th>Approval Date</th>
                            <!--<th>Saving Date</th>-->
                            <th>Staff ID</th>
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
                                <td>${sr.saving_package_name}</td>
                                <td>${String.format("%.2f", sr.money)}</td>
                                <td>${sr.saving_approval_status}</td>
                                <td>
                                    <fmt:parseDate value="${sr.created_at}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                </td> 
                                <td>
                                    <fmt:parseDate value="${sr.saving_approval_date}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                </td>
                                <!--<td>$/{sr.saving_date}</td>-->
                                <td>${sr.staff_id}</td>
                                <td>${String.format("%.2f", sr.amount)}</td>
                                <td>
                                    <form action="listSaving" method="post" style="display:inline;">
                                        <input type="hidden" name="saving_request_id" value="${sr.saving_request_id}">
                                        <input type="hidden" name="saving_approval_status" value="approved">
                                        <button type="submit" class="btn btn-approve">Chấp nhận</button>
                                    </form>
                                    <form action="listSaving" method="post" style="display:inline;">
                                        <input type="hidden" name="saving_request_id" value="${sr.saving_request_id}">
                                        <input type="hidden" name="saving_approval_status" value="rejected">
                                        <button type="submit" class="btn btn-reject">Từ chối</button>
                                    </form>

                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
    </body>
</html>
