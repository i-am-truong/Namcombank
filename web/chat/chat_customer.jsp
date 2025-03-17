<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chat với Nhân Viên</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .chat-container {
                width: 40%;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }
            .chat-header {
                background: #007bff;
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 18px;
                font-weight: bold;
            }
            .chat-box {
                height: 400px;
                overflow-y: auto;
                padding: 15px;
                display: flex;
                flex-direction: column;
            }
            .message {
                max-width: 75%;
                padding: 10px;
                border-radius: 8px;
                margin: 5px 0;
                word-wrap: break-word;
            }
            .customer {
                background: #dcf8c6;
                align-self: flex-end;
                text-align: right;
            }
            .staff {
                background: #f1f0f0;
                align-self: flex-start;
                text-align: left;
            }
            .input-box {
                display: flex;
                padding: 10px;
                border-top: 1px solid #ddd;
                background: white;
            }
            .input-box input {
                flex: 1;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .input-box button {
                background: #007bff;
                color: white;
                border: none;
                padding: 10px 15px;
                margin-left: 5px;
                border-radius: 5px;
                cursor: pointer;
            }
            .input-box button:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="chat-container">
            <div class="chat-header">Trò chuyện với Nhân viên</div>
            <div class="chat-box" id="chatBox"></div>
            <div class="input-box">
                <input type="text" id="messageInput" placeholder="Nhập tin nhắn...">
                <button onclick="sendMessage()">Gửi</button>
            </div>
            <button class="home-btn" style="justify-content: center" onclick="window.location.href='../Home'">Trang chủ</button>
        </div>

        <script>
            function sendMessage() {
                var content = $("#messageInput").val().trim();
                if (content === "")
                    return;
                $.ajax({
                    type: "POST",
                    url: "../CustomerChatServlet",
                    data: {content: content, staff_id: 1},
                    success: function () {
                        $("#messageInput").val("");
                        $("#chatBox").append('<div class="message customer">' + content + '</div>');
                        $("#chatBox").scrollTop($("#chatBox")[0].scrollHeight);
                        loadMessages();
                    }
                });
            }

            function loadMessages() {
                $.ajax({
                    type: "GET",
                    url: "../CustomerChatServlet",
                    success: function (data) {
                        $("#chatBox").html(data);
                        $("#chatBox").scrollTop($("#chatBox")[0].scrollHeight);
                    }
                });
            }

            setInterval(loadMessages, 3000);
        </script>
    </body>
</html>