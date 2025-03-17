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
        <a href="SavingCustomerActive">Quay Lại</a>
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
                        <th>Tên Khách Hàng</th>
                        <th>Phương thức nhận tiền</th>
                        <th>Phản Hồi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${list}">

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
                    <td>${s.customer_name}</td>
                    <td>
                        <form action="SavingCustomerDetail" method="post">
                            <input name="savings_id" value="${s.savings_id}">
                            <select name="payment_method" onchange="confirmPaymentMethod(this)">
                                <c:choose>
                                    <c:when test="${empty s.payment_method}">
                                        <option value="" selected>-- Chọn phương thức --</option>
                                    </c:when>
                                </c:choose>
                                <option value="CASH" ${s.payment_method == 'CASH' ? 'selected' : ''}>CASH</option>
                                <option value="TRANSFER" ${s.payment_method == 'TRANSFER' ? 'selected' : ''}>TRANSFER</option>
                            </select>
                        </form>
                    </td>

                    <td>
                        <form action="SavingFeedback" method="get">
                            <input type="hidden" name="savings_id" value="${s.savings_id}">
                            <button type="submit" class="btn btn-success">Gửi phản hồi</button>
                        </form>
                        <a href="SavingFeedbackAnswerCustomer?savings_id=${s.savings_id}">xem phản hồi</a>
                    </td>

                </c:forEach>
                </tbody>
            </table>

        </div>
    </body>
</html>
<script>
    function confirmPaymentMethod(selectElement) {
        if (selectElement.value) {
            const confirmChange = confirm("Bạn có chắc muốn chọn phương thức: " + selectElement.value + "?");
            if (!confirmChange) {
                selectElement.value = "";
            }
        }
    }
</script>