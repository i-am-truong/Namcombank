<%@ page import="java.util.ArrayList" %>
<%@ page import="model.LoanRequest" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Loan Requests</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100">
        <div class="container mx-auto p-6">
            <h1 class="text-4xl font-bold text-center text-blue-600 mb-6">Loan Requests</h1>

            <div class="mb-6 flex justify-end">
                <a href="../create-loan-request"
                   class="bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600 transition">
                    New Loan Request
                </a>
            </div>

            <div class="overflow-x-auto bg-white rounded-lg shadow">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Customer</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Staff</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <%
    ArrayList<LoanRequest> loanRequests = (ArrayList<LoanRequest>) request.getAttribute("loanRequests");
    if (loanRequests != null && !loanRequests.isEmpty()) {
        for (LoanRequest loanRequest : loanRequests) {
            String statusColor = "gray";
            if (loanRequest.getApprovalStatus().equals("APPROVED")) statusColor = "green";
            else if (loanRequest.getApprovalStatus().equals("REJECTED")) statusColor = "red";
            else if (loanRequest.getApprovalStatus().equals("PENDING")) statusColor = "yellow";
                        %>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">#<%= loanRequest.getRequestId() %></div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900"><%= loanRequest.getCustomerName() %></div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">
                                    <%= String.format("%,.0f", loanRequest.getLoanAmount()) %> VND
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-<%= statusColor %>-100 text-<%= statusColor %>-800">
                                    <%= loanRequest.getApprovalStatus() %>
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <%= loanRequest.getStaffName() != null ? loanRequest.getStaffName() : "Not assigned" %>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <a href="loan-requests?action=view&id=<%= loanRequest.getRequestId() %>" 
                                   class="text-indigo-600 hover:text-indigo-900">View Details</a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="px-6 py-4 text-center text-gray-500">No loan requests found.</td>
                        </tr>
                        <% } %>

                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
