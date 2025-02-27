<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Feedback</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                text-align: center;
                margin: 20px;
            }

            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                padding: 12px;
                border-bottom: 1px solid #ddd;
                text-align: center;
            }

            th {
                background-color: #007bff;
                color: white;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            a {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
                transition: 0.3s;
            }

            a:hover {
                color: #0056b3;
            }

            .btn {
                padding: 10px 20px;
                background-color: #6c757d;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
            }

            .btn:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <body>
        <h2>My Feedback</h2>
        <table>
            <tr>
                <th>Rating</th>
                <th>Content</th>
                <th>Submitted At</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="feedback" items="${list}">
                <tr>
                    <td>${feedback.rating} ⭐</td>
                    <td>${feedback.content}</td>
                    <td>${feedback.submitted_at}</td>
                    <td>
                        <a href="editFeedback?rating=${feedback.rating}&content=${feedback.content}&submitted_at=${feedback.submitted_at}">✏ Sửa</a> | 
                        <a href="deleteFeedback?rating=${feedback.rating}&content=${feedback.content}&submitted_at=${feedback.submitted_at}" style="color: red;">🗑 Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <button class="btn" onclick="window.location.href = 'viewFeedback'">Quay lại</button>
    </body>
</html>
