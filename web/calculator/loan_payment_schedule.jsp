<!DOCTYPE html>
<html lang="en">
    <%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tính Lịch Trả Nợ</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="style.css">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background: #f8f9fa;
                text-align: center;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 800px;
                margin: 30px auto;
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            }
            .form-group {
                margin-bottom: 15px;
                text-align: left;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #005f3b;
            }
            input {
                width: 100%;
                padding: 10px;
                border: 2px solid #ddd;
                border-radius: 8px;
                box-sizing: border-box;
                font-size: 16px;
            }
            button {
                padding: 12px 18px;
                margin: 10px 5px;
                background: #007a33;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s ease-in-out;
            }
            button:hover {
                background: #005f3b;
            }
            button:disabled {
                background: #cccccc;
                cursor: not-allowed;
            }
            .toggle-btn {
                background: #004c8c;
            }
            .toggle-btn:hover {
                background: #003366;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                display: none;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
                font-size: 14px;
            }
            th {
                background: #007a33;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .info-message {
                color: #666;
                font-style: italic;
                font-size: 0.9em;
                margin: 10px 0;
            }
            h2 {
                color: #007a33;
                font-size: 24px;
                margin-bottom: 10px;
            }
            h3 {
                color: #004c8c;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2><i class="fas fa-calculator"></i> Tính Lịch Trả Nợ</h2>
            <div class="info-message" id="info-message">Nhập thông tin để xem kết quả tính toán</div>
            <div class="form-group">
                <label for="loanAmount">Số tiền vay (VND):</label>
                <input type="text" id="loanAmount" placeholder="Ví dụ: 100.000.000" oninput="formatInputCurrency(this); calculateLoan();">
            </div>
            <div class="form-group">
                <label for="interestRate">Lãi suất (%/năm):</label>
                <input type="number" id="interestRate" step="0.1" placeholder="Ví dụ: 7.5" oninput="calculateLoan();">
            </div>
            <div class="form-group">
                <label for="loanTerm">Số tháng vay:</label>
                <input type="number" id="loanTerm" placeholder="Ví dụ: 12, 24, 36, ..." oninput="calculateLoan();">
            </div>
            <div class="form-group">
                <label for="startDate">Ngày giải ngân:</label>
                <input type="date" id="startDate" onchange="calculateLoan();">
            </div>
<!--            <button onclick="calculateLoan()"><i class="fas fa-sync"></i> Tính toán</button>-->
            <button class="toggle-btn" id="toggleBtn" onclick="toggleSchedule()" disabled><i class="fas fa-eye"></i> Xem lịch trả nợ</button>
            <h3>Kết quả</h3>
            <p><strong>Số tiền trả hàng tháng:</strong> <span id="monthly-payment">0</span> VND</p>
            <p><strong>Tổng gốc phải trả:</strong> <span id="total-principal">0</span> VND</p>
            <p><strong>Tổng lãi phải trả:</strong> <span id="total-interest">0</span> VND</p>
            <h3><strong>Tổng số tiền cần trả:</strong> <span id="total-payment">0</span> VND</h3>
            <table id="loanSchedule">
                <thead>
                    <tr>
                        <th>Kỳ hạn</th>
                        <th>Ngày trả nợ</th>
                        <th>Số tiền gốc còn</th>
                        <th>Tiền gốc trả</th>
                        <th>Tiền lãi trả</th>
                        <th>Tổng phải trả</th>
                    </tr>
                </thead>
                <tbody id="schedule-body"></tbody>
                <tfoot>
                    <tr>
                        <th colspan="3">TỔNG</th>
                        <th id="total-principal-footer">0</th>
                        <th id="total-interest-footer">0</th>
                        <th id="total-payment-footer">0</th>
                    </tr>
                </tfoot>
            </table>
            <button class="home-btn" onclick="window.location.href='../Home'">Trang chủ</button>
        </div>

        <script>
            // Biến theo dõi trạng thái hiển thị bảng
            let loanScheduleVisible = false;

            // Hàm định dạng tiền tệ khi nhập
            function formatInputCurrency(input) {
                // Lưu vị trí con trỏ
                const cursorPosition = input.selectionStart;
                const oldValue = input.value;

                // Loại bỏ tất cả ký tự không phải số
                let value = input.value.replace(/\D/g, "");

                // Định dạng số tiền
                if (value) {
                    value = new Intl.NumberFormat("vi-VN").format(value);
                    input.value = value;
                }

                // Điều chỉnh vị trí con trỏ
                if (oldValue.length === cursorPosition) {
                    // Nếu con trỏ ở cuối, giữ ở cuối
                    setTimeout(() => {
                        input.setSelectionRange(input.value.length, input.value.length);
                    }, 0);
                } else {
                    // Nếu con trỏ ở giữa, cố gắng giữ vị trí tương đối
                    const newPosition = cursorPosition + (input.value.length - oldValue.length);
                    setTimeout(() => {
                        input.setSelectionRange(newPosition, newPosition);
                    }, 0);
                }
            }

            // Hàm định dạng tiền tệ cho hiển thị
            function formatCurrency(number) {
                return new Intl.NumberFormat('vi-VN').format(Math.round(number));
            }

            // Hàm tính toán và cập nhật kết quả
            function calculateLoan() {
                // Lấy giá trị từ các trường nhập liệu
                let amount = document.getElementById('loanAmount').value.replace(/\./g, '');
                let interest = document.getElementById('interestRate').value.replace(',', '.');
                let months = document.getElementById('loanTerm').value;
                let startDateStr = document.getElementById('startDate').value;

                // Chuyển đổi giá trị sang số
                amount = amount ? parseFloat(amount) : 0;
                let interestRate = interest ? parseFloat(interest) : 0;
                let interestRatePerMonth = interestRate / 100 / 12;
                months = months ? parseInt(months) : 0;

                // Cập nhật số tiền gốc ngay khi người dùng nhập
                document.getElementById('total-principal').innerText = formatCurrency(amount);

                // Lấy phần tử thông báo
                let infoMessage = document.getElementById('info-message');
                let toggleBtn = document.getElementById('toggleBtn');

                // Kiểm tra các trường và hiển thị thông báo phù hợp
                if (amount <= 0) {
                    infoMessage.textContent = "Vui lòng nhập số tiền vay";
                    resetResults();
                    toggleBtn.disabled = true;
                    return;
                }

                if (interestRate <= 0) {
                    infoMessage.textContent = "Vui lòng nhập lãi suất";
                    resetResults();
                    toggleBtn.disabled = true;
                    return;
                }

                if (months <= 0) {
                    infoMessage.textContent = "Vui lòng nhập số tháng vay";
                    resetResults();
                    toggleBtn.disabled = true;
                    return;
                }

                if (!startDateStr) {
                    infoMessage.textContent = "Vui lòng chọn ngày giải ngân";
                    resetResults();
                    toggleBtn.disabled = true;
                    return;
                }

                // Khi đã có đủ thông tin, tính toán kết quả
                infoMessage.textContent = ""; // Xóa thông báo
                toggleBtn.disabled = false; // Kích hoạt nút xem lịch trả nợ

                // Tính toán khoản vay
                let startDate = new Date(startDateStr);
                let monthlyPrincipal = amount / months;
                let remainingBalance = amount;
                let totalInterest = 0;
                let totalPayment = 0;
                let scheduleHTML = '';

                // Tính toán lịch trả nợ chi tiết
                for (let i = 1; i <= months; i++) {
                    let interestPayment = remainingBalance * interestRatePerMonth;
                    let monthlyPayment = monthlyPrincipal + interestPayment;
                    totalInterest += interestPayment;
                    totalPayment += monthlyPayment;

                    // Tính ngày trả nợ
                    let paymentDate = new Date(startDate);
                    paymentDate.setMonth(paymentDate.getMonth() + i);

                    // Tạo dòng trong bảng - CÁCH SỬA LỖI: Sử dụng cách tạo phần tử DOM thay vì template literals
                    let row = document.createElement('tr');

                    // Cột 1: Kỳ hạn
                    let termCell = document.createElement('td');
                    termCell.textContent = i;
                    row.appendChild(termCell);

                    // Cột 2: Ngày trả nợ
                    let dateCell = document.createElement('td');
                    dateCell.textContent = paymentDate.toLocaleDateString('vi-VN');
                    row.appendChild(dateCell);

                    // Cột 3: Số tiền gốc còn
                    let balanceCell = document.createElement('td');
                    balanceCell.textContent = formatCurrency(remainingBalance);
                    row.appendChild(balanceCell);

                    // Cột 4: Tiền gốc trả
                    let principalCell = document.createElement('td');
                    principalCell.textContent = formatCurrency(monthlyPrincipal);
                    row.appendChild(principalCell);

                    // Cột 5: Tiền lãi trả
                    let interestCell = document.createElement('td');
                    interestCell.textContent = formatCurrency(interestPayment);
                    row.appendChild(interestCell);

                    // Cột 6: Tổng phải trả
                    let paymentCell = document.createElement('td');
                    paymentCell.textContent = formatCurrency(monthlyPayment);
                    row.appendChild(paymentCell);

                    scheduleHTML += row.outerHTML;

                    // Cập nhật số dư còn lại
                    remainingBalance -= monthlyPrincipal;
                }

                // Cập nhật bảng lịch trả nợ
                document.getElementById('schedule-body').innerHTML = scheduleHTML;

                // Cập nhật kết quả tổng quan
                document.getElementById('monthly-payment').innerText = formatCurrency(monthlyPrincipal + (amount * interestRatePerMonth));
                document.getElementById('total-interest').innerText = formatCurrency(totalInterest);
                document.getElementById('total-payment').innerText = formatCurrency(totalPayment);

                // Cập nhật footer của bảng
                document.getElementById('total-principal-footer').innerText = formatCurrency(amount);
                document.getElementById('total-interest-footer').innerText = formatCurrency(totalInterest);
                document.getElementById('total-payment-footer').innerText = formatCurrency(totalPayment);
            }

            // Đặt lại kết quả về 0
            function resetResults() {
                document.getElementById('monthly-payment').innerText = "0";
                document.getElementById('total-interest').innerText = "0";
                document.getElementById('total-payment').innerText = "0";
            }

            // Hiển thị hoặc ẩn lịch trả nợ
            function toggleSchedule() {
                let table = document.getElementById('loanSchedule');
                let button = document.getElementById('toggleBtn');

                if (!loanScheduleVisible) {
                    table.style.display = 'table';
                    button.textContent = 'Ẩn lịch trả nợ';
                } else {
                    table.style.display = 'none';
                    button.textContent = 'Xem lịch trả nợ';
                }

                loanScheduleVisible = !loanScheduleVisible;
            }

            // Tính toán ban đầu khi trang được tải
            document.addEventListener('DOMContentLoaded', function () {
                calculateLoan();
            });
        </script>
    </body>
</html>