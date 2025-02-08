<%-- 
    Document   : loanpackage-list
    Created on : Jan 28, 2025, 1:04:45 PM
    Author     : lenovo
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.LoanPackage" %>
<%@ page import="context.LoanPackageDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Loan Package List</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
    </head>
    <body>
        <div class="container mx-auto p-4">
            <h1 class="text-3xl font-bold mb-4">Loan Package List</h1>
            <table class="table-auto w-full text-left border-collapse border border-gray-300">
                <thead>
                    <tr class="bg-gray-200">
                        <th class="border border-gray-300 px-4 py-2">Package ID</th>
                        <th class="border border-gray-300 px-4 py-2">Staff ID</th>
                        <th class="border border-gray-300 px-4 py-2">Package Name</th>
                        <th class="border border-gray-300 px-4 py-2">Loan Type</th>
                        <th class="border border-gray-300 px-4 py-2">Description</th>
                        <th class="border border-gray-300 px-4 py-2">Interest Rate</th>
                        <th class="border border-gray-300 px-4 py-2">Max Amount</th>
                        <th class="border border-gray-300 px-4 py-2">Min Amount</th>
                        <th class="border border-gray-300 px-4 py-2">Loan Term</th>
                        <th class="border border-gray-300 px-4 py-2">Created Date</th>
<!--                        <th class="border border-gray-300 px-4 py-2">Actions</th>-->
                    </tr>
                </thead>
                <tbody>
                    <%
                        LoanPackageDAO dao = new LoanPackageDAO();
                        List<LoanPackage> loanPackages = dao.getAllLoanPackages();
                    
                        for (LoanPackage loanPackage : loanPackages) {
                    %>
                    <tr>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getPackageId() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getStaffId() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getPackageName() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getLoanType() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getDescription() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getInterestRate() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getMaxAmount() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getMinAmount() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getLoanTerm() %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= loanPackage.getCreatedDate() %></td>
                                                <td class="border border-gray-300 px-4 py-2">
                                                    <form action="updateloanpackage" method="post"><a href="loanpackage-update.jsp?id=<%= loanPackage.getPackageId() %>" class="text-blue-500 hover:underline">Edit</a></form> 
                                                    <a href="deleteloanpackage?packageId=<%= loanPackage.getPackageId() %>" 
                                                       class="text-red-500 hover:underline"
                                                       onclick="return confirm('Are you sure you want to delete this package?');">
                                                        Delete
                                                    </a>
                                                </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <!-- comment <div class="mt-4">
            <a href="loanpackage-create.jsp" class="bg-green-500 text-white px-4 py-2 rounded">Create New Loan Package</a>
        </div>
            -->
        </div>
    </body>
</html>

