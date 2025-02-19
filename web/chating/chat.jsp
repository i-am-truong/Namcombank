<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chat Trực Tiếp</title>
    <script>
        var username = prompt("Nhập tên của bạn:");
        var ws = new WebSocket("ws://localhost:8080/your_project_name/chat/" + username);

        ws.onmessage = function(event) {
            var chatBox = document.getElementById("chat-box");
            chatBox.innerHTML += "<p>" + event.data + "</p>";
        };

        function sendMessage() {
            var receiver = document.getElementById("receiver").value;
            var message = document.getElementById("message").value;
            ws.send(receiver + ":" + message);
            document.getElementById("message").value = "";
        }
    </script>
</head>
<body>
    <h3>Chat Trực Tiếp</h3>
    <div id="chat-box" style="border:1px solid black; height:200px; overflow:auto;"></div>
    <input type="text" id="receiver" placeholder="Nhập tên người nhận">
    <input type="text" id="message" placeholder="Nhập tin nhắn">
    <button onclick="sendMessage()">Gửi</button>
</body>
</html>
