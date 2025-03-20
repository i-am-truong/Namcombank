<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Message, context.MessageDAO" %>

<%
    Integer staffId = (Integer) session.getAttribute("staffId");
    if (staffId == null) {
        response.sendRedirect("../admin.login");
        return;
    }

    MessageDAO messageDAO = new MessageDAO();
    List<Integer> customers = messageDAO.getCustomersWithMessages(staffId);
    String selectedCustomerId = request.getParameter("customer_id");
    List<Message> messages = selectedCustomerId != null ? messageDAO.getMessagesBetween(Integer.parseInt(selectedCustomerId), staffId) : null;
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chat với Khách Hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background-color: #f4f4f4;
            }
            .chat-container {
                display: flex;
                height: 100vh;
            }
            .customer-list {
                width: 30%;
                background: white;
                padding: 15px;
                overflow-y: auto;
                border-right: 1px solid #ddd;
            }
            .customer-list a {
                text-decoration: none;
                color: #333;
                display: block;
                padding: 10px;
                border-radius: 5px;
                transition: 0.3s;
            }
            .customer-list a:hover {
                background: #e0e0e0;
            }
            .chat-box {
                border: 1px solid #ddd;
                background: #fafafa;
                border-radius: 10px;
                height: 400px;
                overflow-y: auto;
                padding: 15px;
            }
            .message {
                padding: 10px;
                border-radius: 20px;
                margin: 8px 0;
                max-width: 70%;
                font-size: 14px;
            }
            .customer {
                background-color: #dcf8c6;
                text-align: right;
                float: right;
                clear: both;
            }
            .staff {
                background-color: #f1f0f0;
                text-align: left;
                float: left;
                clear: both;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@include file="../homepage/header_admin.jsp" %>
        <div class="chat-container">
            <!-- Danh sách khách hàng -->
            <div class="customer-list">
                <h3 class="text-center">Customers</h3>
                <ul class="list-group">
                    <% for (Integer customerId : customers) { %>
                    <li class="list-group-item">
                        <a href="chat_staff.jsp?customer_id=<%= customerId %>">Customer #<%= customerId %></a>
                    </li>
                    <% } %>
                </ul>
            </div>

            <!-- Khu vực chat -->
            <div class="container-fluid p-4">
                <h2 class="text-center">Chat</h2>

                <div class="chat-box" id="chatBox">
                    <% if (messages != null) { %>
                    <% for (Message msg : messages) { %>
                    <div class="message <%= msg.getSenderType().equals("staff") ? "customer text-end" : "staff text-start" %>">
                        <%= msg.getContent() %>
                    </div>
                    <% } %>
                    <% } else { %>
                    <p class="text-center text-muted">Select customer to view message</p>
                    <% } %>
                </div>  

                <% if (selectedCustomerId != null) { %>
                <div class="input-group mt-3">
                    <input type="hidden" id="customer_id" value="<%= selectedCustomerId %>">
                    <input type="text" id="messageInput" class="form-control" placeholder="Enter message..." autocomplete="off">
                    <button class="btn btn-success" onclick="sendMessage()">Send</button>
                </div>
                <% } %>
                <div class="back-button" style="text-align: center">
                    <a href="${sessionScope.previousPage != null ? sessionScope.previousPage : '../staffFilter'}" class="btn btn-secondary">Back</a>
                </div>
            </div>

        </div>


        <script>
            function sendMessage() {
                var content = $("#messageInput").val().trim();
                var customerId = $("#customer_id").val();
                if (content === "")
                    return;

                $.ajax({
                    type: "POST",
                    url: "../StaffChatServlet",
                    data: {content: content, customer_id: customerId},
                    success: function () {
                        $("#messageInput").val("");
                        $("#chatBox").append('<div class="message customer text-end">' + content + '</div>');
                        $("#chatBox").scrollTop($("#chatBox")[0].scrollHeight);
                    }
                });
            }

            function loadMessages() {
                $.ajax({
                    type: "GET",
                    url: "../StaffChatServlet",
                    data: {staff_id: $("#staff_id").val()},
                    success: function (data) {
                        $("#chatBox").html(data);
                        $("#chatBox").scrollTop($("#chatBox")[0].scrollHeight);
                    }
                });
            }
            // Bắt sự kiện Enter trong ô nhập tin nhắn
            $("#messageInput").keypress(function (event) {
                if (event.which === 13 && !event.shiftKey) {  // 13 là mã phím Enter
                    event.preventDefault(); // Ngăn chặn xuống dòng mặc định
                    sendMessage();
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
