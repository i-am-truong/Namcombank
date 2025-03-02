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
                <th>Type</th>
                <th>Hinh Anh</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="feedback" items="${list}">
                <form action="editFeedback" method="post" enctype="multipart/form-data">
                    <tr>
                    <input type="hidden" name="feedback_id" value="${feedback.feedback_id}">

                    <td>
                        <input type="number" name="rating" value="${feedback.rating}" min="1" max="5" required>
                    </td>
                    <td>
                        <input type="text" name="content" value="${feedback.content}" >
                    </td>
                    <td>
                        <input type="text" name="submitted_at" value="${feedback.submitted_at}" readonly>
                    </td>
                    <td>
                        <select name="feedback_type" required>
                            <option value="human" ${feedback.feedback_type == 'human' ? 'selected' : ''}>Human</option>
                            <option value="system" ${feedback.feedback_type == 'system' ? 'selected' : ''}>System</option>
                        </select>
                    </td>
                    <td>
                        <c:if test="${not empty feedback.attachment}">
                            <img src="ImageServlet?rating=${feedback.rating}&content=${feedback.content}&submitted_at=${feedback.submitted_at}&feedback_type=${feedback.feedback_type}" alt="Feedback Image" width="200">
                        </c:if>
                        <br>
                        <label for="attachment">Upload Image (optional):</label>
                        <input type="file" id="attachment" name="attachment" accept="image/*">
                    </td>
                    <td>
                        <input type="hidden" name="original_submitted_at" value="${feedback.submitted_at}">
                        <button type="submit">✔ Lưu</button>
                    </td>
                    </tr>
                </form>
                <tr>
                    <td colspan="6">
                        <a href="deleteFeedback?rating=${feedback.rating}&content=${feedback.content}&submitted_at=${feedback.submitted_at}&feedback_type=${feedback.feedback_type}" style="color: red;">🗑 Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <button class="btn" onclick="window.location.href = 'viewFeedback'">Quay lại</button>


    </body>
</html>

