<%-- 
    Document   : loan-request-list
    Created on : Feb 24, 2025, 9:41:01 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.LoanRequest"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Loan Request Management</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <h2>Loan Requests</h2>

        <form action="loanRequestApproval" method="get">
            <input type="text" name="search" placeholder="Search by customer name">
            <select name="status">
                <option value="all">All</option>
                <option value="pending">Pending</option>
                <option value="approved">Approved</option>
                <option value="rejected">Rejected</option>
            </select>
            <button type="submit">Filter</button>
        </form>

        <table border="1">
            <tr>
                <th>ID</th>
                <th>Customer Name</th>
                <th>Loan Amount</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <c:forEach var="loan" items="${requestScope.loanRequests}">
                <tr>
                    <td>${loan.requestId}</td>
                    <td>${loan.customerName}</td>
                    <td>${loan.loanAmount}</td>
                    <td>${loan.status}</td>
                    <td>
                        <form action="loanRequestApproval" method="post">
                            <input type="hidden" name="requestId" value="${loan.requestId}" />
                            <button type="submit" name="action" value="approve">Approve</button>
                            <button type="submit" name="action" value="reject">Reject</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>

