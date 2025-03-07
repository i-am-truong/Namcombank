<%-- 
    Document   : loan_request
    Created on : Mar 7, 2025, 10:43:48 AM
    Author     : lenovo
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gửi Yêu Cầu Vay</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container">
    <h2 class="mt-4">Gửi Yêu Cầu Vay</h2>
    <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">Yêu cầu vay đã được gửi thành công!</div>
    <% } %>
    <form action="loan-request" method="post" class="mt-3">
        <div class="mb-3">
            <label class="form-label">Chọn Gói Vay:</label>
            <select name="package_id" class="form-control">
                <option value="1">Gói vay A - 5% lãi suất</option>
                <option value="2">Gói vay B - 7% lãi suất</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Số Tiền Vay:</label>
            <input type="number" name="amount" class="form-control" required>
        </div>
        <input type="hidden" name="customer_id" value="${sessionScope.customer_id}">
        <button type="submit" class="btn btn-primary">Gửi Yêu Cầu</button>
    </form>
</body>
</html>