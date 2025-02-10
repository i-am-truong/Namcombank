<%-- 
    Document   : listContracts
    Created on : Feb 9, 2025, 2:34:15 PM
    Author     : lenovo
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Contract" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Contracts</title>
    </head>
    <body>
        <form action="listContracts" method="POST">
            <h2>Contracts List</h2>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Customer Name</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <% List<Contract> contracts = (List<Contract>) request.getAttribute("contracts");
           for (Contract contract : contracts) { %>
                <tr>
                    <td><%= contract.getId() %></td>
                    <td><%= contract.getCustomerName() %></td>
                    <td><%= contract.getType() %></td>
                    <td><%= contract.getAmount() %></td>
                    <td><%= contract.getStatus() %></td>
                    <td>
                        <a href="EditContractController?id=<%= contract.getId() %>">Edit</a> |
                        <a href="DeleteContractController?id=<%= contract.getId() %>" onclick="return confirm('Are you sure?')">Delete</a>
                    </td>
                </tr>
                <% } %>
            </table>
        </form>
        <br>
        <a href="addContract.jsp">Add New Contract</a>
    </body>
</html>
