<%@ page import="model.LoanPackage" %>
<%@ page import="context.LoanPackageDAO" %>
<%@ page import="java.util.Optional" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create Loan Request</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 text-gray-900">
        <div class="container mx-auto p-6">
            <h1 class="text-4xl font-bold text-center text-blue-600 mb-6">Create Loan Request</h1>

            <div class="max-w-lg mx-auto bg-white p-6 rounded-lg shadow-lg">
                <%
    String packageId = request.getParameter("packageId");
    LoanPackage loanPackage = null;
    if (packageId != null) {
        try {
            int id = Integer.parseInt(packageId); // Chuy?n ??i String sang int
            LoanPackageDAO dao = new LoanPackageDAO();
            loanPackage = dao.getLoanPackageById(id);
        } catch (NumberFormatException e) {
            e.printStackTrace(); // In l?i ra console ?? debug
        }
    }
                %>
                <form action="loan-requests" method="POST" class="space-y-4" onsubmit="return validateLoanAmount();">
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="packageId" value="<%= packageId != null ? packageId : "" %>">

                    <div>
                        <label class="block text-gray-700">Package Name</label>
                        <input type="text" name="packageName" class="w-full p-2 border rounded" 
                               value="<%= loanPackage != null ? loanPackage.getPackageName() : "" %>" readonly="" required>
                    </div>
                    <div>
                        <label class="block text-gray-700">Loan Type</label>
                        <input type="text" name="loanType" class="w-full p-2 border rounded" value="<%= loanPackage != null ? loanPackage.getLoanType() : "" %>" readonly="" required>
                    </div>
                    <div>
                        <label class="block text-gray-700">Description</label>
                        <input name="description" class="w-full p-2 border rounded" required value="<%= loanPackage != null ? loanPackage.getDescription() : "" %>" readonly="" required></input>
                    </div>
                    <div>
                        <label class="block text-gray-700">Interest Rate (%)</label>
                        <input type="number" step="0.01" name="interestRate" class="w-full p-2 border rounded" value="<%= loanPackage != null ? loanPackage.getInterestRate() : "" %>" readonly="" required>
                    </div>
                    <div>
                        <label class="block text-gray-700"> Amount (VND)</label>
                        <input type="number" name="amount" class="w-full p-2 border rounded" required>
                    </div>
                    <input type="hidden" id="minAmount" value="<%= loanPackage != null ? loanPackage.getMinAmount() : "0" %>">
                    <input type="hidden" id="maxAmount" value="<%= loanPackage != null ? loanPackage.getMaxAmount() : "1000000000" %>">
                    <div>
                        <label class="block text-gray-700">Loan Term (months)</label>
                        <input type="number" name="loanTerm" class="w-full p-2 border rounded" value="<%= loanPackage != null ? loanPackage.getLoanTerm() : "" %>" readonly="" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-md shadow-md hover:bg-blue-600 transition">
                            Submit Loan Request
                        </button>
                    </div>
                </form>
            </div>

            <div class="mt-6 text-center">
                <a href="../loanpackage/loanpackage-list.jsp" class="bg-gray-500 text-white px-4 py-2 rounded-md shadow-md hover:bg-gray-600 transition">
                    Back to List
                </a>
            </div>
        </div>
        <script>
            function validateLoanAmount() {
                let loanAmount = parseFloat(document.getElementById("loanAmount").value);
                let minAmount = parseFloat(document.getElementById("minAmount").value);
                let maxAmount = parseFloat(document.getElementById("maxAmount").value);

                if (loanAmount < minAmount || loanAmount > maxAmount) {
                    alert("Loan amount must be between " + minAmount + " and " + maxAmount + " VND.");
                    return false;
                }
                return true;
            }
        </script>

    </body>
</html>
