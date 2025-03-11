<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="model.LoanPackage" %>
<%@ page import="context.LoanPackageDAO" %>
<%@ page import="model.Customer" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // Kiểm tra người dùng có đăng nhập không
    Customer customer = (Customer) session.getAttribute("customer");
    boolean isLoggedIn = (customer != null);
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Danh sách Gói Vay</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <!-- Thanh điều hướng với nút Home và Xem Yêu Cầu Vay -->
            <div class="d-flex justify-content-between mb-4">
                <div>
                    <a href="../Home" class="btn btn-secondary">🏠 Home</a>
                    <% if (isLoggedIn) { %>
                    <a href="../customer-loan-requests" class="btn btn-info">📄 Xem Yêu Cầu Vay</a>
                    <% } %>
                </div>
                <h2 class="text-center flex-grow-1">Danh sách Gói Vay</h2>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-hover bg-white shadow">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>Tên Gói</th>
                            <th>Loại Vay</th>
                            <th>Mô Tả</th>
                            <th>Lãi Suất (%)</th>
                            <th>Số Tiền Tối Thiểu</th>
                            <th>Số Tiền Tối Đa</th>
                            <th>Thời Hạn Vay</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            LoanPackageDAO dao = new LoanPackageDAO();
                            List<LoanPackage> packages = dao.getAllLoanPackages();
                            for (LoanPackage loan : packages) {
                        %>
                        <tr class="text-center">
                            <td><%= loan.getPackageName() %></td>
                            <td><%= loan.getLoanType() %></td>
                            <td><%= loan.getDescription() %></td>
                            <td><%= loan.getInterestRate() %></td>
                            <td><%= loan.getMinAmount() %></td>
                            <td><%= loan.getMaxAmount() %></td>
                            <td><%= loan.getLoanTerm() %> tháng</td>
                            <td>
                                <% if (isLoggedIn) { %>
                                <!-- Nếu đã đăng nhập, cho phép đăng ký vay -->
                                <form action="create-loan-request.jsp" method="GET">
                                    <input type="hidden" name="package_id" value="<%= loan.getPackageId() %>">
                                    <button type="submit" class="btn btn-primary">Đăng ký vay</button>
                                </form>
                                <% } else { %>
                                <!-- Nếu chưa đăng nhập, yêu cầu đăng nhập trước -->
                                <a href="../login" class="btn btn-warning">Đăng nhập để vay</a>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
