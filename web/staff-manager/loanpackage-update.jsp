<%-- 
    Document   : loanpackage-update
    Created on : Jan 28, 2025, 1:10:39 PM
    Author     : lenovo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.LoanPackage" %>
<%@ page import="context.LoanPackageDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Loan Package</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 600px;
                margin: 50px auto;
                background: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }
            input, textarea {
                width: 100%;
                padding: 10px;
                border-radius: 4px;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }
            textarea {
                min-height: 100px;
                max-width: 100%;
            }
            button {
                background: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                width: 100%;
            }
            button:hover {
                background: #0056b3;
            }
            .error {
                color: red;
                font-size: 14px;
                margin-top: -10px;
                margin-bottom: 10px;
            }
            h1 {
                text-align: center;
                color: #333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Update Loan Package</h1>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorMessage}">
                <p class="error">${errorMessage}</p>
            </c:if>

            <form action="updateloanpackage" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="packageId" value="${loanPackage.packageId}" />
                <input type="hidden" name="staffId" value="${loanPackage.staffId}" />

                <div class="form-group">
                    <label for="packageName">Package Name:</label>
                    <input type="text" id="packageName" name="packageName" value="${loanPackage.packageName}" required />
                </div>

                <div class="form-group">
                    <label for="loanType">Loan Type:</label>
                    <input type="text" id="loanType" name="loanType" value="${loanPackage.loanType}" required />
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" required>${loanPackage.description}</textarea>
                </div>

                <div class="form-group">
                    <label for="interestRate">Interest Rate (%):</label>
                    <input type="number" id="interestRate" step="0.01" name="interestRate" value="${loanPackage.interestRate}" required />
                </div>

                <div class="form-group">
                    <label for="maxAmount">Max Amount:</label>
                    <input type="number" id="maxAmount" step="0.01" name="maxAmount" value="${loanPackage.maxAmount}" required />
                </div>

                <div class="form-group">
                    <label for="minAmount">Min Amount:</label>
                    <input type="number" id="minAmount" step="0.01" name="minAmount" value="${loanPackage.minAmount}" required />
                </div>

                <div class="form-group">
                    <label for="loanTerm">Loan Term (in months):</label>
                    <input type="number" id="loanTerm" name="loanTerm" value="${loanPackage.loanTerm}" required />
                </div>

                <button type="submit">Update</button>
            </form>

            <script>
                function validateForm() {
                    var maxAmount = parseFloat(document.getElementById('maxAmount').value);
                    var minAmount = parseFloat(document.getElementById('minAmount').value);
                    if (minAmount > maxAmount) {
                        alert("Minimum amount cannot be greater than Maximum amount.");
                        return false;
                    }
                    return true;
                }
            </script>

        </div>
    </body>
</html>
