<%@ page import="model.LoanPackage" %>
<%@ page import="context.LoanPackageDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Lấy packageId từ URL
    String idParam = request.getParameter("id");
    int packageId = 0;
    LoanPackage loanPackage = null;

    try {
        packageId = Integer.parseInt(idParam);
        LoanPackageDAO dao = new LoanPackageDAO();
        loanPackage = dao.getLoanPackageById(packageId);
    } catch (NumberFormatException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Loan Package Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-900">
    <div class="container mx-auto p-6">
        <h1 class="text-4xl font-bold text-center text-blue-600 mb-6">Loan Package Details</h1>

        <%
            if (loanPackage != null) {
        %>
            <div class="max-w-2xl mx-auto bg-white shadow-lg rounded-lg p-6">
                <p class="text-lg"><strong>Package ID:</strong> <%= loanPackage.getPackageId() %></p>
                <p class="text-lg"><strong>Staff ID:</strong> <%= loanPackage.getStaffId() %></p>
                <p class="text-lg"><strong>Package Name:</strong> <%= loanPackage.getPackageName() %></p>
                <p class="text-lg"><strong>Loan Type:</strong> <%= loanPackage.getLoanType() %></p>
                <p class="text-lg"><strong>Description:</strong> <%= loanPackage.getDescription() %></p>
                <p class="text-lg"><strong>Interest Rate:</strong> <%= loanPackage.getInterestRate() %>%</p>
                <p class="text-lg"><strong>Max Amount:</strong> <%= loanPackage.getMaxAmount() %> VND</p>
                <p class="text-lg"><strong>Min Amount:</strong> <%= loanPackage.getMinAmount() %> VND</p>
                <p class="text-lg"><strong>Loan Term:</strong> <%= loanPackage.getLoanTerm() %> months</p>
                <p class="text-lg"><strong>Created Date:</strong> <%= loanPackage.getCreatedDate() %></p>

                <div class="mt-6 text-center">
                    <a href="loanpackage-list.jsp"
                       class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 transition">
                        Back to List
                    </a>
                </div>
            </div>
        <%
            } else {
        %>
            <p class="text-center text-red-500 text-lg">Loan Package not found.</p>
            <div class="mt-6 text-center">
                <a href="loanpackage-list.jsp"
                   class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 transition">
                    Back to List
                </a>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>
