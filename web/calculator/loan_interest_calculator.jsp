<!DOCTYPE html>
<html lang="en">
    <%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tính Lãi Suất Vay</title>
        <link rel="stylesheet" href="style.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f4f7f6;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .header {
                width: 100%;
                background: linear-gradient(to right, #d4eac7, #f0f5e9);
                text-align: center;
                padding: 80px 0;
                font-size: 24px;
                color: #1b5e20;
                font-weight: bold;
            }
            .container {
                display: flex;
                justify-content: space-between;
                max-width: 900px;
                width: 100%;
                margin-top: 20px;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }
            .form-section, .result-section {
                width: 48%;
                padding-right: 20px;
                margin: 10px;
            }
            label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
            }
            input {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            button {
                width: 100%;
                padding: 12px;
                margin-top: 20px;
                background: #2e7d32;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
            }
            button:hover {
                background: #1b5e20;
            }
            .result-section {
                background: #f0f5e9;
                padding: 15px;
                border-radius: 8px;
            }
            .result-section h3 {
                color: #388e3c;
            }
            .loan-result h3 {
                color: #e74c3c;
            }
            .home-btn{
                display: inline-block;
                width: auto;
                padding: 10px 15px;
                text-decoration: none;
            }
        </style>
    </head>

    <body>
        <div class="header">Tính Lãi Suất Vay</div>

        <div class="container">
            <div class="form-section">
                <h3>Nhập thông tin khoản vay</h3>
                <label for="amount">Số tiền muốn vay (VND)</label>
                <input type="text" id="amount" oninput="formatCurrency(this); calculateLoan()">
                <label for="interest">Lãi suất (%/năm)</label>
                <input type="number" id="interest" step="0.1" oninput="calculateLoan()">
                <label for="months">Số tháng vay</label>
                <input type="number" id="months" oninput="calculateLoan()">
                <label for="startDate">Ngày giải ngân</label>
                <input type="date" id="startDate" onchange="calculateLoan()">
                <!-- Giữ lại nút tính toán làm phương án dự phòng -->
<!--                <button onclick="calculateLoan()">Tính toán</button>-->
            </div>

            <div class="result-section">
                <h3>Kết quả</h3>
                <p>Phương thức vay: <strong>Dư nợ giảm dần</strong></p>
                <p><strong>Số tiền trả hàng tháng:</strong> <span id="monthly-payment">0</span> VND</p>
                <p><strong>Tổng gốc phải trả:</strong> <span id="total-principal">0</span> VND</p>
                <p><strong>Tổng lãi phải trả:</strong> <span id="total-interest">0</span> VND</p>
                <h3><strong>Tổng số tiền cần trả:</strong> <span id="total-payment">0</span> VND</h3>
            </div>
        </div>

        <script>
            function formatCurrency(input) {
                // Lưu vị trí con trỏ trước khi định dạng
                const cursorPosition = input.selectionStart;
                const oldLength = input.value.length;

                let value = input.value.replace(/\D/g, ""); // Loại bỏ tất cả ký tự không phải số
                value = new Intl.NumberFormat("vi-VN").format(value); // Định dạng số tiền Việt Nam
                input.value = value;

                // Điều chỉnh vị trí con trỏ sau khi định dạng
                const newLength = input.value.length;
                const positionChange = newLength - oldLength;

                // Đặt lại vị trí con trỏ
                setTimeout(() => {
                    input.setSelectionRange(cursorPosition + positionChange, cursorPosition + positionChange);
                }, 0);
            }

            function calculateLoan() {
                let amount = document.getElementById('amount').value.replace(/[,.]/g, '');
                let interest = document.getElementById('interest').value.replace(',', '.');
                let months = document.getElementById('months').value;

                if (!amount || !interest || !months) {
                    // Hiển thị giá trị mặc định khi trường chưa có đủ dữ liệu
                    document.getElementById('monthly-payment').innerText = "0";
                    document.getElementById('total-principal').innerText = amount ? parseFloat(amount).toLocaleString('vi-VN') : "0";
                    document.getElementById('total-interest').innerText = "0";
                    document.getElementById('total-payment').innerText = "0";
                    return;
                }

                amount = parseFloat(amount);
                interest = parseFloat(interest) / 100 / 12;
                months = parseInt(months);

                if (isNaN(amount) || isNaN(interest) || isNaN(months) || months <= 0) {
                    return; // Nếu dữ liệu không hợp lệ, không cập nhật kết quả
                }

                let monthlyPayment = (amount * interest) / (1 - Math.pow(1 + interest, -months));
                let totalPayment = monthlyPayment * months;
                let totalInterest = totalPayment - amount;

                document.getElementById('monthly-payment').innerText = monthlyPayment.toLocaleString('vi-VN');
                document.getElementById('total-principal').innerText = amount.toLocaleString('vi-VN');
                document.getElementById('total-interest').innerText = totalInterest.toLocaleString('vi-VN');
                document.getElementById('total-payment').innerText = totalPayment.toLocaleString('vi-VN');
            }

            function goHome() {
                window.location.href = '../Home';
            }
        </script>
        <button class="home-btn" onclick="goHome()">🏠 Trang Chủ</button>
    </body>
</html>