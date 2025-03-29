<%@ page import="java.util.List" %>
<%@ page import="model.LoanPackage" %>
<%@ page import="context.LoanPackageDAO" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Loan Package List</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 text-gray-900">
        <div class="container mx-auto p-6">
            <h1 class="text-4xl font-bold text-center text-green-700 mb-6">Loan Package List</h1>

            <div class="overflow-x-auto shadow-lg rounded-lg">
                <table class="w-full bg-white rounded-lg shadow-md">
                    <thead>
                        <tr class="bg-green-700 text-white">
                            <th class="px-4 py-3">Package ID</th>
                            <th class="px-4 py-3">Package Name</th>
                            <th class="px-4 py-3">Loan Type</th>
                            <th class="px-4 py-3">Description</th>
                            <th class="px-4 py-3">Interest Rate (%)</th>
                            <th class="px-4 py-3">Max Amount</th>
                            <th class="px-4 py-3">Min Amount</th>
                            <th class="px-4 py-3">Loan Term (months)</th>
                            <th class="px-4 py-3">Created Date</th>
                            <th class="px-4 py-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            LoanPackageDAO dao = new LoanPackageDAO();
                            List<LoanPackage> loanPackages = dao.getAllLoanPackages();
                            for (LoanPackage loanPackage : loanPackages) {
                        %>
                        <tr class="border-b hover:bg-gray-200">
                            <td class="px-4 py-3 text-center"><%= loanPackage.getPackageId() %></td>
                            <td class="px-4 py-3 font-semibold text-green-700"><%= loanPackage.getPackageName() %></td>
                            <td class="px-4 py-3 text-center"><%= loanPackage.getLoanType() %></td>
                            <td class="px-4 py-3"><%= loanPackage.getDescription() %></td>
                            <td class="px-4 py-3 text-center"><%= String.format("%.2f", loanPackage.getInterestRate()) %></td>
                            <td class="px-4 py-3 text-center font-semibold text-green-600">
                                <%= String.format("%,.0f", loanPackage.getMaxAmount()) %> VND
                            </td>
                            <td class="px-4 py-3 text-center font-semibold text-red-600">
                                <%= String.format("%,.0f", loanPackage.getMinAmount()) %> VND
                            </td>
                            <td class="px-4 py-3 text-center"><%= loanPackage.getLoanTerm() %> months</td>
                            <td class="px-4 py-3 text-center"><%= loanPackage.getCreatedDate() %></td>
                            <td class="px-4 py-3 flex flex-col space-y-2">
                                <a href="loanpackage-detail.jsp?id=<%= loanPackage.getPackageId() %>"
                                   class="bg-green-600 text-white px-3 py-1 rounded-md hover:bg-green-700 transition">
                                    View Details
                                </a>    
                                <a href="loanpackage-update.jsp?id=<%= loanPackage.getPackageId() %>"
                                   class="bg-yellow-500 text-white px-3 py-1 rounded-md hover:bg-yellow-600 transition">
                                    Edit
                                </a>
                                <a href="deleteloanpackage?packageId=<%= loanPackage.getPackageId() %>"
                                   class="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600 transition"
                                   onclick="return confirm('Are you sure you want to delete this package?');">
                                    Delete
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <div class="mt-6 text-center">
                <a href="loanpackage-create.jsp"
                   class="bg-green-600 text-white px-4 py-2 rounded-md shadow-md hover:bg-green-700 transition">
                    Create New Loan Package
                </a>
            </div>
            <div class="mt-4 text-center">
                <a href="../staffFilter"
                   class="bg-gray-500 text-white px-4 py-2 rounded-md shadow-md hover:bg-gray-600 transition">
                    Back
                </a> 
            </div>
        </div>
    </body>
</html>
