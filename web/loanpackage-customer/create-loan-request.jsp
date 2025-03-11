<%@ page session="true" %>
<%@ page import="java.sql.*, context.LoanPackageDAO, model.LoanPackage" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    if (session.getAttribute("customer_id") == null) {
        response.sendRedirect("login");
        return;
    }
    
    String packageIdParam = request.getParameter("package_id");
    int packageId = 0;
    LoanPackage loan = null;
    
    try {
        packageId = Integer.parseInt(packageIdParam);
        LoanPackageDAO dao = new LoanPackageDAO();
        loan = dao.getLoanPackageById(packageId);
    } catch (NumberFormatException e) {
        response.sendRedirect("loan-list"); // Chuyển hướng nếu package_id không hợp lệ
        return;
    }

    if (loan == null) {
        response.sendRedirect("loan-list"); // Chuyển hướng nếu không tìm thấy gói vay
        return;
    }

    int customerId = (int) session.getAttribute("customer_id"); // Lấy ID khách hàng từ session
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Đăng ký khoản vay</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 flex items-center justify-center h-screen">
        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-lg">
            <h2 class="text-2xl font-bold text-center text-blue-600 mb-4">Đăng ký khoản vay</h2>

            <form action="../loan-request" method="POST" class="space-y-4">
                <input type="hidden" name="package_id" value="<%= loan.getPackageId() %>">
                <input type="hidden" name="customer_id" value="<%= customerId %>">

                <div class="p-4 border border-gray-300 rounded-lg">
                    <p class="text-lg font-semibold">Tên gói vay: <span class="text-gray-700"><%= loan.getPackageName() %></span></p>
                    <p class="text-gray-600">Lãi suất: <span class="font-semibold"><%= loan.getInterestRate() %>%</span></p>
                    <p class="text-gray-600">Số tiền tối thiểu: <span class="font-semibold"><%= loan.getMinAmount() %></span></p>
                    <p class="text-gray-600">Số tiền tối đa: <span class="font-semibold"><%= loan.getMaxAmount() %></span></p>
                    <p class="text-gray-600">Thời hạn vay: <span class="font-semibold"><%= loan.getLoanTerm() %> months</span></p>
                </div>

                <div>
                    <label for="amount" class="block text-gray-700 font-medium">Nhập số tiền muốn vay:</label>
                    <input type="number" name="amount" min="<%= loan.getMinAmount() %>" max="<%= loan.getMaxAmount() %>" required
                           class="w-full mt-2 p-3 border border-gray-300 rounded-lg focus:ring focus:ring-blue-200">
                </div>

                <button type="submit"
                        class="w-full bg-blue-500 text-white py-3 rounded-lg text-lg font-bold hover:bg-blue-700 transition">
                    Xác nhận vay
                </button>
            </form>
        </div>
    </body>
</html>
