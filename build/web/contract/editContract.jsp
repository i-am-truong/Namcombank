<%-- 
    Document   : editContract
    Created on : Feb 9, 2025, 2:28:11 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Contract</title>
    </head>
    <h2>Edit Contract</h2>
    <% Contract contract = (Contract) request.getAttribute("contract"); %>
    <form action="editContract" method="post">
        <input type="hidden" name="id" value="<%= contract.getId() %>">
        <label>Customer Name:</label>
        <input type="text" name="customerName" value="<%= contract.getCustomerName() %>" required><br>
        <label>Type:</label>
        <input type="text" name="type" value="<%= contract.getType() %>" required><br>
        <label>Amount:</label>
        <input type="number" name="amount" step="0.01" value="<%= contract.getAmount() %>" required><br>
        <label>Status:</label>
        <select name="status">
            <option value="pending" <%= contract.getStatus().equals("pending") ? "selected" : "" %>>Pending</option>
            <option value="approved" <%= contract.getStatus().equals("approved") ? "selected" : "" %>>Approved</option>
            <option value="rejected" <%= contract.getStatus().equals("rejected") ? "selected" : "" %>>Rejected</option>
        </select><br>
        <input type="submit" value="Update Contract">
    </form>
</body>
</html>
