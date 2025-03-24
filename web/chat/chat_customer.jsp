<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Integer customerId = (Integer) session.getAttribute("customer_id"); // Get customer ID from session
    if (customerId == null) {
        response.sendRedirect("../login"); // Redirect to login page
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chat with Staff</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #F0F8F5; /* Light background color */
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .chat-container {
                width: 40%;
                background: white;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }
            .chat-header {
                background: #007A33; /* Vietcombank primary color */
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
                background: #F0F8F5;
            }
            .message {
                max-width: 75%;
                padding: 10px;
                border-radius: 8px;
                margin: 5px 0;
                word-wrap: break-word;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            }
            .customer {
                background: #D4EDDA; /* Light green */
                align-self: flex-end;
                text-align: right;
            }
            .staff {
                background: #F1F0F0;
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
                background: #007A33;
                color: white;
                border: none;
                padding: 10px 15px;
                margin-left: 5px;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
            }
            .input-box button:hover {
                background: #005922;
            }
            .home-btn {
                width: 100%;
                padding: 10px;
                background: #007A33;
                color: white;
                border: none;
                cursor: pointer;
                text-align: center;
                font-size: 16px;
                border-radius: 0 0 10px 10px;
            }
            .home-btn:hover {
                background: #005922;
            }
        </style>
    </head>
    <body>
        <div class="chat-container">
            <div class="chat-header">Chat with Admin</div>
            <div class="chat-box" id="chatBox"></div>
            <div class="input-box">
                <input type="text" id="messageInput" placeholder="Enter your message...">
                <button onclick="sendMessage()">Send</button>
            </div>
            <button class="home-btn" style="justify-content: center" onclick="window.location.href = '../Home'">Home</button>
        </div>

        <script>
            function sendMessage() {
                var content = $("#messageInput").val().trim(); // lấy nội dung tin nhắn và loại bỏ khung trắng thừa
                if (content === "") // nếu tin nhắn rỗng thì k gửi
                    return;
                
                // gửi tin nhắn bằng AJAX tới CustomerChatServlet
                $.ajax({
                    type: "POST",
                    url: "../CustomerChatServlet",
                    data: {content: content, staff_id: 1}, // dữ liệu gửi đi gồm nội dung tin nhắn và ID của staff = 1
                    success: function () {
                        $("#messageInput").val(""); // xóa nội dung trong ô nhập tin nhắn khi đã gửi đi
                        $("#chatBox").append('<div class="message customer">' + content + '</div>'); // thêm tin nhắn vào khung chat của khách hàng
                        $("#chatBox").scrollTop($("#chatBox")[0].scrollHeight); 
                        loadMessages(); 
                    }
                });
            }
            
            // load tin nhắn 
            function loadMessages() {
                $.ajax({
                    type: "GET",
                    url: "../CustomerChatServlet",
                    success: function (data) {
                        $("#chatBox").html(data); // ghi đè nội dung hộp chat bằng tin nhắn mới nhất từ servlet
                        $("#chatBox").scrollTop($("#chatBox")[0].scrollHeight);
                    }
                });
            }
            // Capture Enter key press in message input box
            $("#messageInput").keypress(function (event) {
                if (event.which === 13 && !event.shiftKey) {  // 13 là mã phím Enter
                    event.preventDefault(); // Ngăn chặn xuống dòng mặc định
                    sendMessage();
                }
            });

            setInterval(loadMessages, 1000);
        </script>
    </body>
</html>