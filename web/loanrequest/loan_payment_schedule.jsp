<%-- 
    Document   : loan_payment_schedule
    Created on : Mar 13, 2025, 10:47:28 AM
    Author     : lenovo
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Trả Nợ</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f7f6;
            text-align: center;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            margin: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #2980b9;
            color: white;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            background: #2980b9;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn:hover {
            background: #1a5276;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Lịch Trả Nợ</h2>
        <p><strong>Số tiền vay:</strong> ${totalLoan} VND</p>
        <p><strong>Tổng tiền lãi:</strong> ${totalInterest} VND</p>
        <p><strong>Tổng tiền phải trả:</strong> ${totalPayment} VND</p>
        
        <table>
            <tr>
                <th>Kỳ hạn</th>
                <th>Ngày trả</th>
                <th>Gốc trả</th>
                <th>Lãi trả</th>
                <th>Tổng trả</th>
                <th>Dư nợ còn lại</th>
            </tr>
            ${schedule}
        </table>
        
        <a href="loan_interest_calculator.jsp" class="btn">🔄 Tính lại</a>
        <a href="../Home" class="btn">🏠 Trang chủ</a>
    </div>
</body>
</html>

