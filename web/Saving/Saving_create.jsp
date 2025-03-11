
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tao yêu cầu Tiết Kiệm</title>
    </head>

    <body>
        <a href="Home">Quay Lại</a>
        <a>HOME > SAVING > Tạo Gói Tiết Kiệm </a>
        <h1>Tạo yêu cầu gửi tiết kiệm trực tuyến</h1>
        <form action="Saving_create" method="get" id="savingForm">
            <label>Chọn loại gói tiết kiệm:</label>
            <select id="saving_package_withdrawable" name="saving_package_withdrawable" onchange="document.getElementById('savingForm').submit();"> 
                <option value="5">-- Chọn loại gói --</option>
                <option value="1">Gói tiết kiệm Linh Hoạt</option>
                <option value="0">Gói tiết kiệm Không Rút Trước Hạn</option>
            </select>
        </form>
    <c:if test="${not empty errorMessage}">
        <div style="color: red; font-weight: bold;">${errorMessage}</div>
    </c:if>
</body>
</html>
