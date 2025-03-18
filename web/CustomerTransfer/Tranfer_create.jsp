<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transfer</title>
    </head>
    <body>
        <table border="1">
            <tr>
                <th>Customer Name</th>
                <th>Saving Package ID</th>
            </tr>
            <tr>
                <td>${r.fullname}</td>
                <td>${r.balance}</td>
            </tr>
        </table>

        <h1>Thông tin người nhận</h1>

        <form action="TransferCreate" method="post">
            <label>Tên người nhận:</label>
            <input type="text" name="fullname_"  required><br>

            <label>Số điện thoại:</label>
            <input type="text" name="phone_" required><br>

            <h2>Thông tin giao dịch</h2>

            <label>Số tiền:</label>
            <input type="number" name="money" min="5000" required><br>

            <label>Nội dung:</label>
            <input type="text" name="transfer_content"><br>

            <button type="submit">Chuyển tiền</button>
        </form>
    </body>
</html>
