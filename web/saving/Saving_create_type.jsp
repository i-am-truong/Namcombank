<%@page import="java.util.List"%>
<%@page import="model.SavingPackage_id"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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

            <input type="text" name="saving_approval_status" value="pending" hidden>
            <input type="text" name="money_approval_status" value="pending" hidden>

            <input type="date" name="created_at" id="created_at" value="${currentDate}" readonly>

            <input type="text" id="saving_package_name" name="saving_package_name" hidden>

            <button type="submit">Gửi yêu cầu</button>

            <%-- In thông báo nếu có --%>
            <% String message = (String) request.getAttribute("message");
       if (message != null) { %>
            <p style="color: green;"><%= message %></p>
            <% } %>
        </form>
    </body>
</html>
