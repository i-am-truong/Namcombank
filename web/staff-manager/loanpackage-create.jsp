<%-- 
    Document   : loanpackage-create
    Created on : Jan 28, 2025, 1:10:25 PM
    Author     : lenovo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Loan Package</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f9f9f9;
            }
            label {
                display: block;
                margin: 10px 0 5px;
                font-weight: bold;
            }
            input[type="text"],
            input[type="number"],
            textarea {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            button {
                padding: 10px 15px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Create New Loan Package</h1>
            <form action="createloanpackage" method="post">
                <label for="packageName">Package Name</label>
                <input type="text" id="packageName" name="packageName" required maxlength="100">

                <label for="loanType">Loan Type</label>
                <input type="text" id="loanType" name="loanType" required maxlength="50">

                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" required maxlength="500"></textarea>

                <label for="interestRate">Interest Rate (%)</label>
                <input type="number" step="0.01" id="interestRate" name="interestRate" required min="0" max="100">

                <label for="maxAmount">Maximum Loan Amount</label>
                <input type="number" step="0.01" id="maxAmount" name="maxAmount" required min="0">

                <label for="minAmount">Minimum Loan Amount</label>
                <input type="number" step="0.01" id="minAmount" name="minAmount" required min="0">

                <label for="loanTerm">Loan Term (months)</label>
                <input type="number" id="loanTerm" name="loanTerm" required min="1" max="360">

                <button type="submit">Create Loan Package</button>
            </form>
        </div>
    </body>
</html>
