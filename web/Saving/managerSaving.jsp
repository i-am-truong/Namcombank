<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            <div id="content-wrapper" class="d-flex flex-column">
                <%@include file="../homepage/header_admin.jsp" %>
                <div class="container">
                    <h2 class="text-center">Manager Saving Package</h2>
                    <a href="createSavingPackage">Tạo mới</a>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Staff ID</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Interest Rate</th>
                                <th>Term (months)</th>
                                <th>Min Deposit</th>
                                <th>Max Deposit</th>
                                <th>Status</th>
                                <th>Approval Status</th>
                                <th>Withdrawable</th>
                                <th>Created At</th>
                                <th>Updated At</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="sp" items="${list}">
                                <tr>
                                    <td>${sp.saving_package_id}</td>
                                    <td>${sp.staff_id}</td>
                                    <td>${sp.saving_package_name}</td>
                                    <td>${sp.saving_package_description}</td>
                                    <td>${sp.saving_package_interest_rate}</td>
                                    <td>${sp.saving_package_term_months}</td>
                                    <td><fmt:formatNumber value="${sp.saving_package_min_deposit}" pattern="#,##0" /></td>
                                    <td><fmt:formatNumber value="${sp.saving_package_max_deposit}" pattern="#,##0" /></td>
                                    <td>${sp.saving_package_status}</td>
                                    <td>${sp.saving_package_approval_status}</td>
                                    <td>${sp.saving_withdrawable ? '1' : '0'}</td>
                                    <td>
                                        <fmt:parseDate value="${sp.saving_package_created_at}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                    </td> 
                                    <td>
                                        <fmt:parseDate value="${sp.saving_package_updated_at}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                    </td> 
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
    </body>
</html>
