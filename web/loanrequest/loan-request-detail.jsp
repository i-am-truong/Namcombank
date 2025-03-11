<%-- 
    Document   : loan-request-detail
    Created on : Mar 5, 2025, 10:37:28 AM
    Author     : lenovo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.LoanRequest" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Loan Request Detail</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto p-6">
        <h2 class="text-2xl font-bold mb-6">Loan Request Details</h2>
        
        <% LoanRequest loanRequest = (LoanRequest) request.getAttribute("loanRequest"); %>
        
        <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
            <div class="grid grid-cols-2 gap-4">
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Request ID</label>
                    <p class="text-gray-900"><%= loanRequest.getRequestId() %></p>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Customer Name</label>
                    <p class="text-gray-900"><%= loanRequest.getCustomerName() %></p>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Loan Amount</label>
                    <p class="text-gray-900">$<%= String.format("%.2f", loanRequest.getLoanAmount()) %></p>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Status</label>
                    <span class="px-2 py-1 rounded-md <%= "Approved".equals(loanRequest.getApprovalStatus()) ? "bg-green-500 text-white" : "bg-yellow-500 text-black" %>">
                        <%= loanRequest.getApprovalStatus() != null ? loanRequest.getApprovalStatus() : "Pending" %>
                    </span>
                </div>
                
                <% if ("Approved".equals(loanRequest.getApprovalStatus())) { %>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Approved By</label>
                    <p class="text-gray-900"><%= loanRequest.getApprovedBy() %></p>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Approval Date</label>
                    <p class="text-gray-900"><%= loanRequest.getApprovalDate() %></p>
                </div>
                <% } %>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Staff Name</label>
                    <p class="text-gray-900"><%= loanRequest.getStaffName() %></p>
                </div>
            </div>
            
            <div class="mt-6">
                <a href="${pageContext.request.contextPath}/loan-request-list" class="btn btn-secondary">Quay lại danh sách</a>
            </div>
        </div>
    </div>
</body>
</html>

