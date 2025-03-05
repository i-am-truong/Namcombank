<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Gói Tiết Kiệm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 20px;
                padding: 20px;
            }

            a {
                display: inline-block;
                padding: 8px 12px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            a:hover {
                background-color: #0056b3;
            }

            h2 {
                color: #333;
                margin-bottom: 15px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #007bff;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            form {
                background: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                width: fit-content;
                margin-top: 15px;
            }

            label {
                font-weight: bold;
            }

            input[type="number"] {
                padding: 8px;
                width: 150px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-left: 10px;
            }

            button {
                padding: 8px 12px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-left: 10px;
            }

            button:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>

        <a href="Home">HOME</a>

        <h2>Gói Tiết Kiệm Linh Hoạt</h2>
        <table>
            <tr>
                <th>Tên Gói</th>
                <th>Lãi Suất</th>
                <th>Kỳ Hạn (tháng)</th>
                <th>Trạng Thái</th>
            </tr>
            <c:forEach var="saving" items="${nonWithdrawableList}">
                <tr>
                    <td>${saving.saving_package_name}</td>
                    <td>${saving.saving_package_interest_rate}%</td>
                    <td>${saving.saving_package_term_months}</td>
                    <td>${saving.saving_package_status}</td>
                </tr>
            </c:forEach>
        </table>

        <h2>Tính lãi suất</h2>
        <form action="" method="get">
            <label for="amount">Số tiền gửi:</label>
            <input type="number" id="amount" name="amount" required min="1000000">
            <button type="submit">Tính</button>
        </form>

        <c:if test="${not empty param.amount}">
            <h2>Kết Quả Tính Toán</h2>
            <table>
                <tr>
                    <th>Tên Gói</th>
                    <th>Kỳ Hạn (tháng)</th>
                    <th>Số Tiền Gửi</th>
                    <th>Lãi Suất</th>
                    <th>Tiền Lãi</th>
                    <th>Tổng Nhận</th>
                </tr>
                <c:forEach var="saving" items="${nonWithdrawableList}">
                    <c:set var="deposit" value="${param.amount}" />
                    <c:set var="interestRate" value="${saving.saving_package_interest_rate / 100}" />
                    <c:set var="months" value="${saving.saving_package_term_months}" />
                    <c:set var="interest" value="${deposit * interestRate * (months / 12)}" />
                    <tr>
                        <td>${saving.saving_package_name}</td>
                        <td>${saving.saving_package_term_months} tháng</td>
                        <td><fmt:formatNumber value="${deposit}" type="currency" currencyCode="VND"/></td>
                        <td>${saving.saving_package_interest_rate}%</td>
                        <td><fmt:formatNumber value="${interest}" type="currency" currencyCode="VND"/></td>
                        <td><fmt:formatNumber value="${deposit + interest}" type="currency" currencyCode="VND"/></td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

    </body>
</html>
