<%-- 
    Document   : loan-request-form
    Created on : Feb 24, 2025, 9:39:45 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.LoanPackage"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng Ký Yêu Cầu Vay</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 flex items-center justify-center h-screen">

        <div class="bg-white p-6 rounded-lg shadow-md w-96">
            <h2 class="text-2xl font-semibold text-center mb-4">Yêu Cầu Vay</h2>

            <form action="loan-request/create" method="post">
                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700">Số tiền vay</label>
                    <input type="number" name="amount" required class="mt-1 p-2 w-full border rounded-md">
                </div>

                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700">Gói vay</label>
                    <select name="package_id" required class="mt-1 p-2 w-full border rounded-md">
                        <option value="1">Gói 1: 6 tháng</option>
                        <option value="2">Gói 2: 12 tháng</option>
                        <option value="3">Gói 3: 24 tháng</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700">Ngày bắt đầu</label>
                    <input type="date" name="start_date" required class="mt-1 p-2 w-full border rounded-md">
                </div>

                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700">Ngày kết thúc</label>
                    <input type="date" name="end_date" required class="mt-1 p-2 w-full border rounded-md">
                </div>

                <button type="submit" class="w-full bg-blue-500 text-white py-2 rounded-md hover:bg-blue-600">Gửi Yêu Cầu</button>
            </form>

        </div>

    </body>
</html>

