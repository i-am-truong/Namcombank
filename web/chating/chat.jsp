<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Live Chat</title>
        <script>
            var customerId = "<%= session.getAttribute("customer_id") != null ? session.getAttribute("customer_id") : "guest" %>";
            var ws = new WebSocket("ws://localhost:8080/YourProject/chat/" + customerId);

            ws.onmessage = function (event) {
                document.getElementById("chat-box").innerHTML += "<div>" + event.data + "</div>";
            };

            function sendMessage() {
                var message = document.getElementById("message").value;
                if (message.trim() !== "") {
                    ws.send(JSON.stringify({ customerId: customerId, message: message }));
                    document.getElementById("chat-box").innerHTML += "<div><b>You:</b> " + message + "</div>";
                    document.getElementById("message").value = "";
                }
            }
        </script>
    </head>
    <body>
        <h3>Live Chat</h3>
        <div id="chat-box" style="border: 1px solid black; width: 300px; height: 200px; overflow-y: scroll;"></div>
        <input type="text" id="message" placeholder="Type a message">
        <button onclick="sendMessage()">Send</button>
    </body>
</html>
