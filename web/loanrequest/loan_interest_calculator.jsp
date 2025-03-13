<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tính Lãi Suất Vay</title>
        <link rel="stylesheet" href="style.css">
        <style>
            /* Định dạng tổng thể */
            body {
                font-family: Arial, sans-serif;
                background: #f4f7f6;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                width: 90%;
                max-width: 500px;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                text-align: center;
            }
            h2 {
                margin-bottom: 20px;
                color: #2c3e50;
            }
            label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
                text-align: left;
            }
            input {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
            }
            button {
                width: 100%;
                padding: 12px;
                margin-top: 20px;
                background: #2980b9;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: 0.3s;
            }
            button:hover {
                background: #1a5276;
            }
            .loan-result {
                margin-top: 20px;
                padding: 15px;
                border-radius: 8px;
                background: #ecf0f1;
            }
            .loan-result p {
                font-size: 18px;
                margin: 8px 0;
            }
            .loan-result h3 {
                color: #e74c3c;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="loan-form">
                <h2>Tính Lãi Suất Vay</h2>
                <label for="amount">💰 Số tiền vay (VND)</label>
                <input type="number" id="amount">

                <label for="interest">📈 Lãi suất (%/năm)</label>
                <input type="number" id="interest" step="0.1">

                <label for="months">📅 Số tháng vay</label>
                <input type="number" id="months">

                <label for="startDate">📆 Ngày giải ngân</label>
                <input type="date" id="startDate">

                <button onclick="calculateLoan()">📊 Tính toán</button>
            </div>

            <div class="loan-result">
                <form action="loan-calculator" method="POST">
                    <h2>📋 Kết Quả Tính Toán</h2>
                    <p>Phương thức vay: <strong>Vay trung/dài hạn</strong></p>
                    <p>📌 <strong>Số tiền trả hàng tháng:</strong> <span id="monthly-payment">0</span> VND</p>
                    <p>💰 <strong>Tổng gốc phải trả:</strong> <span id="total-principal">0</span> VND</p>
                    <p>💸 <strong>Tổng lãi phải trả:</strong> <span id="total-interest">0</span> VND</p>
                    <h3>💳 Tổng số tiền cần trả: <span id="total-payment">0</span> VND</h3>
                </form>

            </div>
            <button onclick="window.location.href = '../Home'">🏠 Trang chủ</button>
        </div>

        <script>
            function calculateLoan() {
                let amount = parseFloat(document.getElementById('amount').value);
                let interest = parseFloat(document.getElementById('interest').value) / 100 / 12;
                let months = parseInt(document.getElementById('months').value);

                let monthlyPayment = (amount * interest) / (1 - Math.pow(1 + interest, -months));
                let totalPayment = monthlyPayment * months;
                let totalInterest = totalPayment - amount;

                document.getElementById('monthly-payment').innerText = monthlyPayment.toLocaleString();
                document.getElementById('total-principal').innerText = amount.toLocaleString();
                document.getElementById('total-interest').innerText = totalInterest.toLocaleString();
                document.getElementById('total-payment').innerText = totalPayment.toLocaleString();
            }
        </script>
    </body>
</html>
