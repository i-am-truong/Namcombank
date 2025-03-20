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
        <style>
            /* Màu nền toàn trang */
            body {
                background-color: #D0E5D4; /* Xanh nhạt */
            }

            /* Container */
            .container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            }

            /* Nút Home */
            .btn-secondary {
                background-color: #005A3C !important; /* Xanh đậm */
                border-color: #005A3C !important;
                color: white !important;
            }

            .btn-secondary:hover {
                background-color: #00432A !important; /* Xanh đậm hơn */
                border-color: #00432A !important;
            }

            /* Nút Xem Yêu Cầu Vay */
            .btn-info {
                background-color: #007A4E !important; /* Xanh đậm */
                border-color: #007A4E !important;
                color: white !important;
            }

            .btn-info:hover {
                background-color: #005A3C !important;
                border-color: #005A3C !important;
            }

            /* Nút Đăng ký vay */
            .btn-success {
                background-color: #006A4E !important; /* Xanh Vietcombank */
                border-color: #006A4E !important;
                color: white !important;
            }

            .btn-success:hover {
                background-color: #004D38 !important;
                border-color: #004D38 !important;
            }

            /* Nút Đăng nhập */
            .btn-warning {
                background-color: #FF8C00 !important; /* Cam đậm hơn */
                border-color: #FF8C00 !important;
                color: white !important;
            }

            .btn-warning:hover {
                background-color: #E07B00 !important;
                border-color: #E07B00 !important;
            }

            /* Tiêu đề trang */
            h2 {
                color: #005A3C; /* Xanh đậm */
                font-weight: bold;
            }

            /* Bảng danh sách gói vay */
            .table {
                border: 2px solid #005A3C;
            }

            .table thead {
                background-color: #005A3C !important; /* Xanh Vietcombank */
                color: white !important;
            }

            .table tbody tr {
                background-color: #E8F5E9; /* Xanh nhạt hơn */
            }

            .table tbody tr:hover {
                background-color: #C3E6CB !important; /* Xanh đậm hơn khi hover */
            }
        </style>

    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <!-- Thanh điều hướng với nút Home và Xem Yêu Cầu Vay -->
            <div class="d-flex justify-content-between mb-4">
                <div>
                    <a href="../Home" class="btn btn-warning">🏠 Home</a>
                    <% if (isLoggedIn) { %>
                    <a href="../customer-loan-requests" class="btn btn-info">📄 View Loan Request</a>
                    <% } %>
                </div>
                <h2 class="text-center flex-grow-1">List of Loan Packages</h2>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-hover bg-green shadow">
                    <thead class="table-success text-center">
                        <tr>
                            <th>Loan Package Name</th>
                            <th>Loan Type</th>
                            <th>Description</th>
                            <th>Interest Rate (%)</th>
                            <th>Min Amount</th>
                            <th>Max Amount</th>
                            <th>Loan Term</th>
                            <th>Actions</th>
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
                            <td>
                                <%= (loan.getMinAmount() != null) ? String.format("%,.0f", loan.getMinAmount().doubleValue()).replace(',', '.') : "N/A" %>
                            </td>
                            <td>
                                <%= (loan.getMaxAmount() != null) ? String.format("%,.0f", loan.getMaxAmount().doubleValue()).replace(',', '.') : "N/A" %>
                            </td>

                            <td><%= loan.getLoanTerm() %> months</td>
                            <td>
                                <% if (isLoggedIn) { %>
                                <!-- Nếu đã đăng nhập, cho phép đăng ký vay -->
                                <form action="create-loan-request.jsp" method="GET">
                                    <input type="hidden" name="package_id" value="<%= loan.getPackageId() %>">
                                    <button type="submit" class="btn btn-success">Apply for a loan</button>
                                </form>
                                <% } else { %>
                                <!-- Nếu chưa đăng nhập, yêu cầu đăng nhập trước -->
                                <a href="../login" class="btn btn-warning">You must be login</a>
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
