<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách tiết kiệm của bạn</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 20px;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }
            .btn {
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <a href="Home">Quay Lại</a>
        <div class="container">
            <h2>Danh sách tiết kiệm của bạn</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Mã Tiết Kiệm</th>
                        <th>Số Tiền Gửi</th>
                        <th>Lãi Suất (%)</th>
                        <th>Kỳ Hạn (Tháng)</th>
                        <th>Ngày Mở</th>
                        <th>Trạng Thái</th>
                        <th>Nhân Viên Xử Lý</th>
                        <th>Ngày Nhận Tiền</th> 
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${list}">
                        <tr onclick="postToSavingCustomerActive('${s.savings_id}')" style="cursor: pointer;">
                            <td>${s.savings_id}</td>
                            <td><fmt:formatNumber value="${s.amount}" type="currency"/></td>
                            <td>${s.interest_rate}</td>
                            <td>${s.term_months}</td>
                            <td>
                                <fmt:parseDate value="${s.opened_date}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>${s.status}</td>
                            <td>${s.staff_id}</td>

                            <td>
                                <fmt:parseDate value="${s.money_get_date}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                            </td>
                            
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </body>
</html>
<script>
    function postToSavingCustomerActive(savingsId) {
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "SavingCustomerActive";

        const input = document.createElement("input");
        input.type = "hidden";
        input.name = "savings_id";
        input.value = savingsId;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
</script>
