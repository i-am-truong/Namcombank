<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tính lãi suất tiết kiệm</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8fdf3;
            }
            .calculator {
                background: #ecf8e5;
                padding: 20px;
                border-radius: 10px;
            }
            .result-box {
                background: white;
                padding: 20px;
                border-radius: 10px;
            }
            .term-btn {
                background: white;
                border: 1px solid #ccc;
                border-radius: 20px;
                padding: 5px 15px;
                cursor: pointer;
                margin: 5px;
            }
            .term-btn.selected {
                background: #c3e6cb;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                text-align: center;
            }
            table {
                width: 80%;
                margin: auto;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #89A83B;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
        </style>
    </head>
    <body>
        <h2>Lãi Suất Tiết Kiệm</h2>

        <table>
            <tr>
                <th>Kỳ hạn</th>
                <th>VND</th>
                <th>EUR</th>
                <th>USD</th>
            </tr>
            <tr><td>Không kỳ hạn</td><td>0.10%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>7 ngày</td><td>0.20%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>14 ngày</td><td>0.20%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>1 tháng</td><td>1.60%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>2 tháng</td><td>1.60%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>3 tháng</td><td>1.90%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>6 tháng</td><td>2.90%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>9 tháng</td><td>2.90%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>12 tháng</td><td>4.60%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>24 tháng</td><td>4.70%</td><td>0.30%</td><td>0.00%</td></tr>
        </table>
        <div class="container mt-4">
            <h4>Ghi chú</h4>
            <div style="background: #f8f8f8; padding: 15px; border-radius: 8px;">
                <ul>
                    <li>Lãi suất trên chỉ mang tính tham khảo và có thể thay đổi theo từng thời điểm.</li>
                    <li>Lãi được tính trên số ngày thực tế và cơ sở tính lãi là 365 ngày.</li>
                    <li>Bảng tính toán chỉ mang tính chất tham khảo.</li>
                    <li>Lãi suất các loại ngoại tệ khác hoặc các kỳ hạn không niêm yết, Quý khách liên hệ Vietcombank gần nhất để được hỗ trợ.</li>
                </ul>
            </div>
        </div>
        <div class="container mt-5">
            <h2>Tính Lãi Tiết Kiệm</h2>
            <div class="row">
                <!-- Khu vực nhập liệu -->
                <div class="col-md-6 calculator">
                    <h5>SỐ TIỀN GỬI</h5>
                    <div class="input-group mb-3">
                        <span class="input-group-text">VND</span>
                        <input type="text" id="amount" class="form-control" placeholder="Nhập số tiền" oninput="formatNumber(this)">
                    </div>

                    <h5>KỲ HẠN GỬI</h5>
                    <select id="term" class="form-select mb-3" onchange="setRateFromSelect()">
                        <option value="-1">Chọn kỳ hạn gửi</option>
                        <option value="1">1 tháng - 1.60%</option>
                        <option value="6">6 tháng - 2.90%</option>
                        <option value="12">12 tháng - 4.60%</option>
                        <option value="24">24 tháng - 4.70%</option>
                    </select>

                    <div>
                        <button class="term-btn" onclick="setTerm(1, this)">1 tháng</button>
                        <button class="term-btn" onclick="setTerm(6, this)">6 tháng</button>
                        <button class="term-btn" onclick="setTerm(12, this)">12 tháng</button>
                        <button class="term-btn" onclick="setTerm(24, this)">24 tháng</button>
                    </div>
                </div>

                <!-- Khu vực hiển thị kết quả -->
                <div class="col-md-6 result-box">
                    <h5>Tiền lãi dự tính</h5>
                    <p>Số tiền lãi: <b id="interest">0 VND</b></p>
                    <p>Tổng tiền: <b id="total">0 VND</b></p>
                    <p>Lãi suất: <b id="rate">0%</b></p>
                    <hr>
                    <p>Lãi suất được cập nhật lúc <b id="updateTime"></b></p>
                </div>
            </div>
        </div>
        <a href="../Home" class="btn btn-success mt-3">🏠 Trang Chủ</a>
        <script>
            const rates = {1: 0.016, 6: 0.029, 12: 0.046, 24: 0.047};

            function calculate() {
                let amountStr = document.getElementById("amount").value.replace(/[,.]/g, '');
                let amount = parseFloat(amountStr) || 0;
                let term = parseInt(document.getElementById("term").value);
                let rate = rates[term];

                // Hiển thị số tiền nhập vào ngay lập tức
                document.getElementById("total").innerText = amount.toLocaleString("vi-VN") + " VND";

                if (!rate || amount <= 0) {
                    document.getElementById("interest").innerText = "0 VND";
                    document.getElementById("rate").innerText = "0%";
                    return;
                }

                let interest = amount * rate;
                let total = amount + interest;

                document.getElementById("interest").innerText = interest.toLocaleString("vi-VN") + " VND";
                document.getElementById("total").innerText = total.toLocaleString("vi-VN") + " VND";
                document.getElementById("rate").innerText = (rate * 100).toFixed(2) + "%";
                document.getElementById("updateTime").innerText = new Date().toLocaleTimeString("vi-VN");
            }

            function formatNumber(input) {
                let value = input.value.replace(/[^\d]/g, '');
                input.value = parseInt(value || 0).toLocaleString("vi-VN");
                calculate();
            }

            function setTerm(months, button) {
                document.getElementById("term").value = months;
                document.querySelectorAll('.term-btn').forEach(btn => btn.classList.remove("selected"));
                button.classList.add("selected");

                // Cập nhật lãi suất ngay lập tức
                document.getElementById("rate").innerText = (rates[months] * 100).toFixed(2) + "%";

                calculate();
            }

            function setRateFromSelect() {
                let term = parseInt(document.getElementById("term").value);
                let buttons = document.querySelectorAll('.term-btn');
                buttons.forEach(btn => {
                    if (btn.innerText.includes(term + " tháng")) {
                        btn.classList.add("selected");
                    } else {
                        btn.classList.remove("selected");
                    }
                });

                // Cập nhật lãi suất ngay lập tức khi chọn kỳ hạn
                if (rates[term]) {
                    document.getElementById("rate").innerText = (rates[term] * 100).toFixed(2) + "%";
                } else {
                    document.getElementById("rate").innerText = "0%";
                }

                calculate();
            }

            // Lắng nghe nhập số tiền và kỳ hạn
            document.getElementById("amount").addEventListener("input", formatNumber);
            document.getElementById("term").addEventListener("change", setRateFromSelect);
            window.onload = calculate;

        </script>
    </body>
</html>
