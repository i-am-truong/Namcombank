<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Set" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>

<html>
<head>
    <title>Danh sách khách hàng chờ</title>
</head>
<body>
    <h2>Danh sách khách hàng đang chờ</h2>
    <ul>
        <%
            Set<String> waitingCustomers = (Set<String>) request.getAttribute("waitingCustomers");
            if (waitingCustomers != null && !waitingCustomers.isEmpty()) {
                for (String customerId : waitingCustomers) {
        %>
            <li><a href="chat.jsp?customerId=<%= customerId %>">Chat với <%= customerId %></a></li>
        <%
                }
            } else {
        %>
            <li>Không có khách hàng nào đang chờ</li>
        <%
            }
        %>
    </ul>
</body>
</html>
