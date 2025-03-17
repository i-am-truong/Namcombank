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
                font-family: Arial, sans-serif;
                margin: 20px;
                padding: 20px;
                background-color: #f4f4f4;
            }

            h1 {
                color: #333;
            }

            a {
                display: inline-block;
                margin-bottom: 10px;
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
            }

            a:hover {
                text-decoration: underline;
            }

            form {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                max-width: 400px;
            }

            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }

            select, input {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                background-color: #28a745;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
            }

            button:hover {
                background-color: #218838;
            }

            div[style="color: red; font-weight: bold;"] {
                color: red;
                background: #ffe5e5;
                padding: 10px;
                border-radius: 5px;
                margin-top: 10px;
            }

            p {
                color: green;
                font-weight: bold;
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
        <a href="Saving_create">Quay Lại</a>
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
            
            <label>Vui lòng chọn loại tiền tiền:</label>
            <select id="method_money" name="method_money"> 
                <option value="TRANSFER">Tiền tài khoản</option>BALANCE
                <option value="CASH">Thanh toán tại quầy</option>
            </select>
            
            <input type="text" name="saving_approval_status" value="pending" hidden>
            <input type="text" name="money_approval_status" value="pending" hidden>

            <label>Ngày tạo:</label>
            <input type="date" name="created_at" id="created_at" value="${currentDate}" readonly>

            <button type="submit">Gửi yêu cầu</button>

            <%-- In thông báo nếu có --%>
            <% String message = (String) request.getAttribute("message");
               if (message != null) { %>
            <p><%= message %></p>
            <% } %>
        </form>

    <c:if test="${not empty errorMessage}">
        <div>${errorMessage}</div>
    </c:if>
</body>
</html>
