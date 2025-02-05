<%-- 
    Document   : loanpackage-delete
    Created on : Jan 28, 2025, 2:49:22 PM
    Author     : lenovo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Delete Loan Package</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
    </head>
    <body class="bg-gray-100">
        <div class="container mx-auto mt-10 p-6 max-w-md bg-white shadow-md rounded-lg text-center">
            <h1 class="text-2xl font-bold mb-4">Confirm Delete Loan Package</h1>

            <%
                // Lấy packageId từ tham số URL
                String packageId = request.getParameter("packageId");

                if (packageId != null && !packageId.trim().isEmpty()) {
            %>

            <p class="mb-4 text-gray-700">
                Are you sure you want to delete the Loan Package with ID 
                <strong class="text-red-500"><%= packageId %></strong>?
            </p>

            <form action="<%= request.getContextPath() %>/loanpackage/deleteloanpackage" method="post">
                <input type="hidden" name="packageId" value="<%= packageId %>">
                <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-700">
                    Confirm Delete
                </button>
            </form>

            <div class="mt-4">
                <a href="loanpackage-list.jsp" class="text-blue-500 hover:underline">Cancel</a>
            </div>

            <%
                } else {
            %>

            <p class="text-red-500 font-bold">Error: Invalid package ID.</p>
            <div class="mt-4">
                <a href="loanpackage-list.jsp" class="text-blue-500 hover:underline">Back to List</a>
            </div>

            <%
                }
            %>
        </div>
    </body>
</html>

