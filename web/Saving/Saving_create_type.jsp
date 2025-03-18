<%@page import="java.util.List"%>
<%@page import="model.SavingPackage_id"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo yêu cầu gửi tiết kiệm</title>
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f4f4f4;
                margin: 0;
            }

            .container {
                width: 65%;
                max-width: 900px;
                min-height: 80vh;
                background: white;
                padding: 50px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
                text-align: center;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            h1 {
                text-align: center;
                margin-bottom: 20px;
                font-size: 28px; /* Chữ to hơn */
            }


            form {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            label {
                font-weight: bold;
                margin-top: 10px;
                text-align: left;
                font-size: 18px; /* Chữ to hơn */
            }

            select, input {
                width: 80%; /* Đảm bảo tất cả các ô có cùng chiều rộng */
                height: 50px; /* Độ cao đồng nhất */
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 18px; /* Chữ to hơn */
                box-sizing: border-box; /* Giữ kích thước đồng nhất */
            }

            button, a {
                display: inline-block;
                width: 150px;  /* Độ rộng cố định */
                height: 30px;  /* Chiều cao cố định */
                font-size: 16px; /* Cỡ chữ vừa phải */
                padding: 10px;
                text-align: center;
                border-radius: 5px;
            }

            button {
                background-color: #28a745; /* Xanh lá cây */
                border: none;
                cursor: pointer;
            }

            button:hover {
                background-color: #218838;
            }

            a {
                background-color: #90EE90; /* Xanh lá nhạt */
                color: black;
                text-decoration: none;
                line-height: 45px; /* Căn giữa chữ theo chiều dọc */
            }

            a:hover {
                background-color: #7cc576;
            }

            .message {
                color: red;
                background: #ffe5e5;
                padding: 12px;
                border-radius: 5px;
                margin-top: 10px;
                font-size: 18px;
            }


        </style>

        <script>
            function updateSavingPackageName() {
                var select = document.getElementById("saving_package_id");
                var selectedOption = select.options[select.selectedIndex];
                var savingPackageNameInput = document.getElementById("saving_package_name");
                savingPackageNameInput.value = selectedOption.getAttribute("data-name");
            }
        </script>
    </head>

    <body>
        <div class="container">

            <h1>Tạo yêu cầu gửi tiết kiệm trực tuyến</h1>
            <form action="Saving_create" method="post">
                <input type="text" name="customer_id" value="${sessionScope.customer_id}" hidden>

                <label>Chọn gói tiết kiệm:</label>
                <select name="saving_package_id" id="saving_package_id" onchange="updateSavingPackageName()">
                    <option value="">-- Chọn gói tiết kiệm --</option>
                    <% 
                        List<SavingPackage_id> list = (List<SavingPackage_id>) request.getAttribute("list");
                        if (list != null) {
                            for (SavingPackage_id sp : list) {
                    %>
                    <option value="<%= sp.getSaving_package_id() %>" 
                            data-name="<%= sp.getSaving_package_name() %>">
                        <%= sp.getSaving_package_name() %> - Lãi suất: <%= sp.getSaving_package_interest_rate() %>%
                    </option>
                    <%  
                            }
                        }
                    %>
                </select>

                <label>Nhập số tiền muốn gửi:</label>
                <input type="number" name="money" required>

                <label>Vui lòng chọn loại tiền:</label>
                <select id="method_money" name="method_money"> 
                    <option value="TRANSFER">Tiền tài khoản</option>
                    <option value="CASH">Thanh toán tại quầy</option>
                </select>

                <input type="text" name="saving_approval_status" value="pending" hidden>
                <input type="text" name="money_approval_status" value="pending" hidden>

                <label>Ngày tạo:</label>
                <input type="date" name="created_at" id="created_at" value="${currentDate}" readonly>

                <button type="submit">Gửi yêu cầu</button>
                <button type="button" onclick="window.location.href = 'Saving_create'" style="background-color: #90EE90; color: black;">
                    Quay Lại
                </button>

                <% String message = (String) request.getAttribute("message");
               if (message != null) { %>
                <p class="message"><%= message %></p>
                <% } %>
            </form>

        </div>
    </body>


</html>
