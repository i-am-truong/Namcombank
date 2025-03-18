<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo yêu cầu Tiết Kiệm</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                width: 500px;
                max-width: 90%;
            }
            h1 {
                color: #28a745;
                margin-bottom: 20px;
            }
            select {
                width: 100%;
                padding: 12px;
                border: 2px solid #28a745;
                border-radius: 5px;
                margin-top: 10px;
                font-size: 16px;
            }
            a {
                display: inline-block; /* Giúp nút chỉ chiếm diện tích theo nội dung */
                max-width: 120px; /* Giới hạn chiều rộng tối đa */
                padding: 8px 12px; /* Giảm padding để nút nhỏ hơn */
                font-size: 14px;
                text-decoration: none;
                color: white;
                background-color: #28a745;
                border-radius: 5px;
                text-align: center;
            }

            a:hover {
                background-color: #218838;
            }


            .message {
                color: red;
                font-weight: bold;
                margin-top: 15px;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }


            .container {
                width: 500px;
                height: 700px; /* Chiều cao cố định, giống khổ giấy A4 */
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                justify-content: center;
            }



            h2 {
                text-align: center;
            }

            .form-label {
                font-weight: bold;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .btn-success {
                width: 100%;
                padding: 10px;
                margin-top: 15px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
            }

            .btn-success:hover {
                background-color: #218838;
            }

        </style>
    </head>

    <body>
        <div class="container">

            <p>HOME > SAVING > Tạo Gói Tiết Kiệm</p>
            <h1>Tạo yêu cầu gửi tiết kiệm trực tuyến</h1>
            <form action="Saving_create" method="get" id="savingForm">
                <label>Chọn loại gói tiết kiệm:</label>
                <select id="saving_package_withdrawable" name="saving_package_withdrawable" onchange="document.getElementById('savingForm').submit();"> 
                    <option value="5">-- Chọn loại gói --</option>
                    <option value="1">Gói tiết kiệm Linh Hoạt</option>
                    <option value="0">Gói tiết kiệm Không Rút Trước Hạn</option>
                </select>
            </form>
            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <br>
            <br>
            <a href="Home">Quay Lại</a>
        </div>
    </body>
</html>
