<%@ page import="model.LoanPackage" %>
<%@ page import="context.LoanPackageDAO" %>
<%@ page import="java.util.Optional" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create Loan Package</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 text-gray-900">
        <div class="container mx-auto p-6">
            <h1 class="text-3xl font-bold text-center text-blue-600 mb-6">Create Loan Package</h1>

            <div class="max-w-lg mx-auto bg-white p-6 rounded-lg shadow-lg">
                <%
        String packageId = request.getParameter("packageId"); // Lấy packageId từ request
        LoanPackage loanPackage = null;
    
        if (packageId != null) {
            try {
                int id = Integer.parseInt(packageId); // Chuyển đổi từ String sang int
                LoanPackageDAO dao = new LoanPackageDAO();
                loanPackage = dao.getLoanPackageById(id); // Truyền vào kiểu int
            } catch (NumberFormatException e) {
                e.printStackTrace(); // In lỗi ra console để debug
            }
        }
                %>


                <form action="LoanRequestServlet" method="POST" class="space-y-4">
                    <input type="hidden" name="packageId" value="<%= packageId != null ? packageId : "" %>">

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Package Name</label>
                        <input type="text" name="packageName" value="<%= loanPackage != null ? loanPackage.getPackageName() : "" %>" 
                               class="w-full p-2 border rounded-lg" required>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Loan Type</label>
                        <input type="text" name="loanType" value="<%= loanPackage != null ? loanPackage.getLoanType() : "" %>" 
                               class="w-full p-2 border rounded-lg" readonly="" required>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Description</label>
                        <textarea name="description" class="w-full p-2 border rounded-lg" required><%= loanPackage != null ? loanPackage.getDescription() : "" %></textarea>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Interest Rate (%)</label>
                        <input type="number" step="0.01" name="interestRate" value="<%= loanPackage != null ? loanPackage.getInterestRate() : "" %>" 
                               class="w-full p-2 border rounded-lg" required>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Max Amount (VND)</label>
                        <input type="number" name="maxAmount" value="<%= loanPackage != null ? loanPackage.getMaxAmount() : "" %>" 
                               class="w-full p-2 border rounded-lg" required>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Min Amount (VND)</label>
                        <input type="number" name="minAmount" value="<%= loanPackage != null ? loanPackage.getMinAmount() : "" %>" 
                               class="w-full p-2 border rounded-lg" required>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700">Loan Term (months)</label>
                        <input type="number" name="loanTerm" value="<%= loanPackage != null ? loanPackage.getLoanTerm() : "" %>" 
                               class="w-full p-2 border rounded-lg" required>
                    </div>

                    <div class="flex justify-between">
                        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-md shadow-md hover:bg-blue-600 transition">
                            Submit
                        </button>
                        <a href="loanpackage-list.jsp"
                           class="bg-gray-500 text-white px-4 py-2 rounded-md shadow-md hover:bg-gray-600 transition">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
