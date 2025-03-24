<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Savings Interest Calculator</title>
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
        <h2>Savings Interest Rates</h2>

        <table>
            <tr>
                <th>Term</th>
                <th>VND</th>
                <th>EUR</th>
                <th>USD</th>
            </tr>
            <tr><td>Non-term</td><td>0.10%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>7 days</td><td>0.20%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>14 days</td><td>0.20%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>1 month</td><td>1.60%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>2 months</td><td>1.60%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>3 months</td><td>1.90%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>6 months</td><td>2.90%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>9 months</td><td>2.90%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>12 months</td><td>4.60%</td><td>0.30%</td><td>0.00%</td></tr>
            <tr><td>24 months</td><td>4.70%</td><td>0.30%</td><td>0.00%</td></tr>
        </table>
        <div class="container mt-4">
            <h4>Notes</h4>
            <div style="background: #f8f8f8; padding: 15px; border-radius: 8px;">
                <ul>
                    <li>The above interest rates are for reference only and may change over time.</li>
                    <li>Interest is calculated based on actual days and a 365-day year.</li>
                    <li>The calculations provided are for reference purposes only.</li>
                    <li>For interest rates of other currencies or unlisted terms, please contact the nearest Namcombank branch.</li>
                </ul>
            </div>
        </div>
        <div class="container mt-5">
            <h2>Calculate Savings Interest</h2>
            <div class="row">
                <!-- Khu vực nhập liệu -->
                <div class="col-md-6 calculator">
                    <h5>DEPOSIT AMOUNT</h5>
                    <div class="input-group mb-3">
                        <span class="input-group-text">VND</span>
                        <input type="text" id="amount" class="form-control" placeholder="Enter amount" oninput="formatNumber(this)">
                    </div>

                    <h5>DEPOSIT TERM</h5>
                    <select id="term" class="form-select mb-3" onchange="setRateFromSelect()">
                        <option value="-1">Select deposit term</option>
                        <option value="1">1 month - 1.60%</option>
                        <option value="6">6 months - 2.90%</option>
                        <option value="12">12 months - 4.60%</option>
                        <option value="24">24 months - 4.70%</option>
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
                    <h5>Expected return</h5>
                    <p>Interest Amount: <b id="interest">0 VND</b></p>
                    <p>Total amount: <b id="total">0 VND</b></p>
                    <p>Interest rate: <b id="rate">0%</b></p>
                    <hr>
                    <p>Interest rates are updated at <b id="updateTime"></b></p>
                </div>
            </div>
        </div>
        <a href="../Home" class="btn btn-success mt-3">🏠 Home</a>
        <script>
            // rate theo từng kỳ hạn
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
