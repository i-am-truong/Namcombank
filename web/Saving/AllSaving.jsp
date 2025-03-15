<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách Gói Tiết Kiệm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
                text-align: center;
            }
            h1 {
                color: #333;
            }
            .button-container {
                margin-bottom: 20px;
            }
            button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                margin: 5px;
                cursor: pointer;
                font-size: 16px;
                border-radius: 5px;
                transition: 0.3s;
            }
            button:hover {
                background-color: #0056b3;
            }
            .content {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                margin: 20px auto;
                width: 80%;
                display: none;
            }
            .active {
                display: block !important;
            }
        </style>
        <script>
            function showPage(page) {
                document.getElementById("withdrawable").classList.remove("active");
                document.getElementById("nonWithdrawable").classList.remove("active");

                document.getElementById(page).classList.add("active");
            }
        </script>
    </head>
    <body>
        <h1>Danh sách Gói Tiết Kiệm</h1>

        <div class="button-container">    
            <button onclick="showPage('withdrawable')">Gói Không Rút Trước Hạn</button>
            <button onclick="showPage('nonWithdrawable')">Gói Linh Hoạt</button>
        </div>

        <div id="withdrawable" class="content active">
            <%@ include file="WithdrawableSaving.jsp" %>
        </div>

        <div id="nonWithdrawable" class="content">
            <%@ include file="NonWithdrawableSaving.jsp" %>
        </div>

    </body>
</html>
