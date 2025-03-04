<%@ page import="java.math.BigDecimal" %>
<%@ page import="model.LoanPackage" %>
<%@ page import="context.LoanPackageDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Loan Package</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 flex items-center justify-center min-h-screen">
        <div class="bg-white p-6 rounded-lg shadow-lg w-full max-w-lg">
            <h1 class="text-2xl font-bold text-center text-gray-700 mb-6">Update Loan Package</h1>

            <%
                // Lấy packageId từ request
                int packageId = Integer.parseInt(request.getParameter("id"));
                LoanPackageDAO dao = new LoanPackageDAO();
                LoanPackage loanPackage = dao.getLoanPackageById(packageId);

                if (loanPackage == null) {
            %>
            <p class="text-red-500 text-center font-bold">Loan package not found!</p>
            <div class="text-center mt-4">
                <a href="loanpackage-list.jsp" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Back to List</a>
            </div>
            <%
                } else {
            %>

            <form action="updateloanpackage" method="post" class="space-y-4">
                <!-- Hidden Fields -->
                <input type="hidden" name="package_id" value="<%= loanPackage.getPackageId() %>" />
                <input type="hidden" name="staff_id" value="<%= loanPackage.getStaffId() %>" />

                <!-- Package Name -->
                <label class="block text-gray-700 font-medium">Package Name:</label>
                <input type="text" name="packageName" value="<%= loanPackage.getPackageName() %>" required
                       class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />

                <!-- Loan Type -->
                <label class="block text-gray-700 font-medium">Loan Type:</label>
                <input type="text" name="loanType" value="<%= loanPackage.getLoanType() %>" required
                       class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />

                <!-- Description -->
                <label class="block text-gray-700 font-medium">Description:</label>
                <textarea name="description" required
                          class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"><%= loanPackage.getDescription() %></textarea>

                <!-- Interest Rate -->
                <label class="block text-gray-700 font-medium">Interest Rate (%):</label>
                <input type="number" step="0.01" name="interestRate" value="<%= loanPackage.getInterestRate() %>" required
                       class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />

                <!-- Max Amount -->
                <label class="block text-gray-700 font-medium">Max Amount:</label>
                <input type="number" step="0.01" name="maxAmount" value="<%= loanPackage.getMaxAmount() %>" required
                       class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />

                <!-- Min Amount -->
                <label class="block text-gray-700 font-medium">Min Amount:</label>
                <input type="number" step="0.01" name="minAmount" value="<%= loanPackage.getMinAmount() %>" required
                       class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />

                <!-- Loan Term -->
                <label class="block text-gray-700 font-medium">Loan Term (in months):</label>
                <input type="number" name="loanTerm" value="<%= loanPackage.getLoanTerm() %>" required
                       class="w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />

                <!-- Submit Button -->
                <button type="submit" class="w-full bg-blue-500 text-white p-3 rounded-lg hover:bg-blue-600">Update</button>
            </form>

            <div class="text-center mt-4">
                <a href="loanpackage-list.jsp" class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600">Cancel</a>
            </div>

            <%
                } // Kết thúc kiểm tra loanPackage != null
            %>

        </div>
    </body>
</html>
