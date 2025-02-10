<%-- 
    Document   : addContract
    Created on : Feb 9, 2025, 2:23:32 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Contract</title>
    </head>
    <h2>Add New Contract</h2>
    <form action="addContract" method="post">
        <label>Customer Name:</label>
        <input type="text" name="customerName" required><br>
        <label>Type:</label>
        <input type="text" name="type" required><br>
        <label>Amount:</label>
        <input type="number" name="amount" step="0.01" required><br>
        <label>Status:</label>
        <select name="status">
            <option value="pending">Pending</option>
            <option value="approved">Approved</option>
            <option value="rejected">Rejected</option>
        </select><br>
        <input type="submit" value="Add Contract">
    </form>
</body>
</html>
</html>
