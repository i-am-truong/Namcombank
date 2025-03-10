<%@ page import="java.util.List" %>
<%@ page import="model.LoanPackage" %>
<%@ page import="context.LoanPackageDAO" %>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Loan Package List</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 text-gray-900">
        <div class="container mx-auto p-6">
            <h1 class="text-4xl font-bold text-center text-blue-600 mb-6">Loan Package List</h1>

            <!-- Success message if redirected from successful loan request -->
            <% if (request.getParameter("success") != null) { %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
                <strong class="font-bold">Success!</strong>
                <span class="block sm:inline">Your loan request has been submitted successfully.</span>
            </div>
            <% } %>

            <div class="overflow-x-auto shadow-lg rounded-lg">
                <table class="w-full bg-white rounded-lg shadow-md">
                    <thead>
                        <tr class="bg-gradient-to-r from-blue-500 to-blue-700 text-white">
                            <th class="px-4 py-3">Package ID</th>
                            <th class="px-4 py-3">Staff ID</th>
                            <th class="px-4 py-3">Package Name</th>
                            <th class="px-4 py-3">Loan Type</th>
                            <th class="px-4 py-3">Description</th>
                            <th class="px-4 py-3">Interest Rate</th>
                            <th class="px-4 py-3">Max Amount</th>
                            <th class="px-4 py-3">Min Amount</th>
                            <th class="px-4 py-3">Loan Term</th>
                            <th class="px-4 py-3">Created Date</th>
                            <th class="px-4 py-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            LoanPackageDAO dao = new LoanPackageDAO();
                            List<LoanPackage> loanPackages = dao.getAllLoanPackages();

                            Customer customer = (Customer) session.getAttribute("customer"); // Get Customer from Session

                            for (LoanPackage loanPackage : loanPackages) {
                        %>
                        <tr class="border-b hover:bg-gray-100">
                            <td class="px-4 py-3 text-center"><%= loanPackage.getPackageId() %></td>
                            <td class="px-4 py-3 text-center"><%= loanPackage.getStaffId() %></td>
                            <td class="px-4 py-3"><%= loanPackage.getPackageName() %></td>
                            <td class="px-4 py-3 text-center"><%= loanPackage.getLoanType() %></td>
                            <td class="px-4 py-3"><%= loanPackage.getDescription() %></td>
                            <td class="px-4 py-3 text-center"><%= String.format("%.2f", loanPackage.getInterestRate()) %>%</td>
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
                                   class="text-center bg-blue-500 text-white px-3 py-1 rounded-md hover:bg-blue-600 transition">
                                    View Details
                                </a>
                                <% if (customer != null) { %>  
                                <a href="../create-loan-request?packageId=<%= loanPackage.getPackageId() %>&customerId=<%= customer.getCustomerId() %>"
                                   class="text-center bg-green-500 text-white px-3 py-1 rounded-md hover:bg-green-600 transition">
                                    Get a loan
                                </a>
                                <% } else { %>
                                <a href="../login" onclick="alert('Please log in to get a loan.')"
                                   class="text-center bg-gray-400 text-white px-3 py-1 rounded-md cursor-not-allowed">
                                    Get a loan
                                </a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="mt-6 text-center">
                <a href="../Home"
                   class="bg-gray-500 text-white px-4 py-2 rounded-md shadow-md hover:bg-green-600 transition">
                    Back
                </a>
            </div>
        </div>
    </body>
</html>
