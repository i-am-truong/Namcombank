<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Phản Hồi Tiết Kiệm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f8f5;
                margin: 20px;
                text-align: center;
            }
            h1 {
                color: #2e7d32;
            }
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #ffffff;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            th, td {
                padding: 10px;
                border: 1px solid #81c784;
                text-align: center;
            }
            th {
                background-color: #81c784;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #e8f5e9;
            }
            tr:hover {
                background-color: #c8e6c9;
                transition: 0.3s;
            }
        </style>
    </head>
    <body>
        <h1>Danh Sách Phản Hồi Tiết Kiệm</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nội Dung</th>
                    <th>Ngày Gửi</th>
                    <th>Phản Hồi</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="feedback" items="${list}">
                    <tr>
                        <td>${feedback.feedback_id}</td>
                        <td>${feedback.content}</td>
                        <td>
                            <fmt:parseDate value="${feedback.answer_at}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                        </td>
                        <td>${feedback.answer}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
