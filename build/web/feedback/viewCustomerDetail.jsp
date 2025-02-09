<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer Detail</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 900px;
                margin: 50px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
                color: #333;
            }
            td {
                color: #555;
            }
            .button {
                display: block;
                width: 200px;
                margin: 30px auto;
                padding: 10px;
                background-color: #6c757d;
                color: white;
                border: none;
                border-radius: 5px;
                text-align: center;
                cursor: pointer;
                font-size: 16px;
            }
            .button:hover {
                background-color: #5a6368;
            }
            .no-detail {
                text-align: center;
                color: #ff6347;
                font-size: 18px;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h1>Customer Detail</h1>

            <c:if test="${not empty customerDetail}">
                <table>
                    <tr>
                        <th>Full Name</th>
                        <td>${customerDetail.fullname}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${customerDetail.email}</td>
                    </tr>
                    <tr>
                        <th>Phone Number</th>
                        <td>${customerDetail.phonenumber}</td>
                    </tr>
                    <tr>
                        <th>Date of Birth</th>
                        <td>${customerDetail.dob}</td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td>${customerDetail.gender == 1 ? 'Male' : 'Female'}</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${customerDetail.address}</td>
                    </tr>
                </table>
            </c:if>

            <c:if test="${empty customerDetail}">
                <p class="no-detail">No customer details found.</p>
            </c:if>

            <button class="button" onclick="window.location.href = 'viewCustomerFeedback'">
                Back
            </button>
        </div>

    </body>
</html>
