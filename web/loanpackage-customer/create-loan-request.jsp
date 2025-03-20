<%@ page session="true" %>
<%@ page import="java.sql.*, context.LoanPackageDAO, model.LoanPackage, java.util.*, java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    if (session.getAttribute("customer") == null) {
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
        response.sendRedirect("loanpackage-customer/loan_packages.jsp");
        return;
    }

    if (loan == null) {
        response.sendRedirect("loanpackage-customer/loan_packages.jsp");
        return;
    }

    List<String> errorMessages = (List<String>) request.getAttribute("errorMessages");
    String lastAmount = request.getParameter("amount");

    DecimalFormat formatter = new DecimalFormat("#,###");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Loan Registration</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 flex items-center justify-center h-screen">
        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-lg">
            <h2 class="text-2xl font-bold text-center text-green-600 mb-4">Loan Registration</h2>

            <form action="../loan-request" method="POST" class="space-y-4" onsubmit="return validateAmount()">
                <input type="hidden" name="package_id" value="<%= loan.getPackageId() %>">

                <div class="p-4 border border-gray-300 rounded-lg">
                    <p class="text-lg font-semibold">Loan Package: <span class="text-gray-700"><%= loan.getPackageName() %></span></p>
                    <p class="text-gray-600">Interest Rate: <span class="font-semibold"><%= loan.getInterestRate() %>%</span></p>
                    <p class="text-gray-600">Minimum Amount: <span class="font-semibold"><%= formatter.format(loan.getMinAmount()) %> VND</span></p>
                    <p class="text-gray-600">Maximum Amount: <span class="font-semibold"><%= formatter.format(loan.getMaxAmount()) %> VND</span></p>
                    <p class="text-gray-600">Loan Term: <span class="font-semibold"><%= loan.getLoanTerm() %> months</span></p>
                </div>

                <div>
                    <label for="amount" class="block text-gray-700 font-medium">Enter loan amount:</label>
                    <input type="text" id="amount" name="amount" value="<%= lastAmount != null ? lastAmount : "" %>" 
                           class="w-full mt-2 p-3 border border-gray-300 rounded-lg focus:ring focus:ring-blue-200" 
                           oninput="formatCurrency(this)" required>
                    <p id="error-message" class="text-red-500 text-sm mt-2"></p>
                </div>

                <button type="submit" class="w-full bg-green-500 text-white py-3 rounded-lg text-lg font-bold hover:bg-green-700 transition">
                    Confirm Loan
                </button>

                <% if (errorMessages != null && !errorMessages.isEmpty()) { %>
                <ul class="mt-4 p-4 bg-red-100 text-red-700 rounded-lg">
                    <% for (String message : errorMessages) { %>
                    <li><%= message %></li>
                        <% } %>
                </ul>
                <% } %>
            </form>
        </div>

        <script>
            function formatCurrency(input) {
                let value = input.value.replace(/\D/g, ""); // Remove all non-numeric characters
                value = new Intl.NumberFormat("vi-VN").format(value); // Format as Vietnamese currency
                input.value = value;
            }

            function validateAmount() {
                let amountInput = document.getElementById("amount");
                let errorMessage = document.getElementById("error-message");
                let rawAmount = amountInput.value.replace(/\D/g, ""); // Keep only numbers
                let amount = parseInt(rawAmount);

                let minAmount = <%= loan.getMinAmount() %>;
                let maxAmount = <%= loan.getMaxAmount() %>;

                if (isNaN(amount) || amount <= 0) {
                    errorMessage.textContent = "Invalid loan amount.";
                    return false;
                }
                if (amount < minAmount || amount > maxAmount) {
                    errorMessage.textContent = "Loan amount must be between " + minAmount.toLocaleString("vi-VN") + " and " + maxAmount.toLocaleString("vi-VN") + " VND.";
                    return false;
                }

                errorMessage.textContent = ""; // Clear error if valid
                return true;
            }
        </script>
    </body>
</html>
