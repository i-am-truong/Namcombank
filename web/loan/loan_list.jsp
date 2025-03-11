<%-- 
    Document   : loan_list
    Created on : Mar 7, 2025, 10:43:55 AM
    Author     : lenovo
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Yêu Cầu Vay</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container">
    <h2 class="mt-4">Danh Sách Yêu Cầu Vay</h2>
    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>Gói Vay</th>
                <th>Số Tiền</th>
                <th>Ngày Yêu Cầu</th>
                <th>Trạng Thái</th>
                <th>Chi Tiết</th>
            </tr>
        </thead>
        <tbody>
            <%-- Lặp qua danh sách yêu cầu --%>
            <%-- Dữ liệu cần lấy từ LoanRequestDAO --%>
        </tbody>
    </table>
</body>
</html>
