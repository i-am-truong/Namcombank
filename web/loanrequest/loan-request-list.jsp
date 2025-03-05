<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.LoanRequest" %>
<%@ page import="context.LoanRequestDAO" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Loan Request List</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 p-6">
        <div class="container mx-auto bg-white p-6 rounded-lg shadow-md">
            <h2 class="text-2xl font-bold mb-4">Loan Request List</h2>

            <!-- Form tạo yêu cầu vay -->
            <%
                HttpSession sessionObj = request.getSession();
                String selectedPackage = request.getParameter("selectedLoanPackage");
                if (selectedPackage != null) {
                    sessionObj.setAttribute("selectedLoanPackage", selectedPackage);
                }
            %>
            <form action="LoanRequestServlet" method="post" class="mb-4" enctype="multipart/form-data">
                <div class="grid grid-cols-2 gap-4">
                    <input type="text" name="customerName" placeholder="Customer Name" class="border p-2 rounded" required>
                    <input type="number" name="loanAmount" value="<%= sessionObj.getAttribute("selectedLoanPackage") != null ? sessionObj.getAttribute("selectedLoanPackage") : "" %>" placeholder="Loan Amount" class="border p-2 rounded" required>
                    <input type="text" name="staffName" placeholder="Staff Name" class="border p-2 rounded" required>
                    <input type="file" name="collateralImage" class="border p-2 rounded">
                    <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">Create Loan Request</button>
                </div>
            </form>

            <table class="w-full border-collapse border border-gray-300">
                <thead>
                    <tr class="bg-gray-200">
                        <th class="border border-gray-300 px-4 py-2">Request ID</th>
                        <th class="border border-gray-300 px-4 py-2">Customer Name</th>
                        <th class="border border-gray-300 px-4 py-2">Loan Amount</th>
                        <th class="border border-gray-300 px-4 py-2">Staff Name</th>
                        <th class="border border-gray-300 px-4 py-2">Approval Status</th>
                        <th class="border border-gray-300 px-4 py-2">Approval Date</th>
                        <th class="border border-gray-300 px-4 py-2">Approved By</th>
                        <th class="border border-gray-300 px-4 py-2">Collateral Image</th>
                        <th class="border border-gray-300 px-4 py-2">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% LoanRequestDAO dao = new LoanRequestDAO();
                       List<LoanRequest> loanRequests = dao.list();
                       for (LoanRequest loanReq : loanRequests) { %>
                    <tr class="bg-white hover:bg-gray-100">
                        <td class="border border-gray-300 px-4 py-2"><%= loanReq.getRequestId() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanReq.getCustomerName() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanReq.getLoanAmount() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanReq.getStaffName() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanReq.getApprovalStatus() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanReq.getApprovalDate() != null ? loanReq.getApprovalDate() : "N/A" %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanReq.getApprovedBy() != null ? loanReq.getApprovedBy() : "N/A" %></td>
                        <td class="border border-gray-300 px-4 py-2">
                            <% if (loanReq.getCollateralImage() != null && !loanReq.getCollateralImage().isEmpty()) { %>
                            <img src="<%= loanReq.getCollateralImage() %>" alt="Collateral" class="w-24 h-auto rounded-md">
                            <% } else { %>
                            No Image
                            <% } %>
                        </td>
                        <td class="border border-gray-300 px-4 py-2">
                            <a href="LoanRequestServlet?action=edit&id=<%= loanReq.getRequestId() %>" class="text-blue-500">Edit</a> |
                            <a href="LoanRequestServlet?action=delete&id=<%= loanReq.getRequestId() %>" class="text-red-500">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </body>
</html>