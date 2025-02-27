<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Feedback</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                text-align: center;
                margin: 20px;
            }

            form {
                background: white;
                width: 50%;
                margin: auto;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            h2 {
                color: #007bff;
            }

            label {
                font-weight: bold;
            }

            input, select {
                width: 100%;
                padding: 8px;
                margin: 8px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                background-color: #007bff;
                color: white;
                font-weight: bold;
                cursor: pointer;
                transition: 0.3s;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <h2>Edit Feedback</h2>
        <form action="editFeedback" method="post">
            <label>Content:</label>
            <input type="text" name="content" value="${content}" required>

            <input type="hidden" name="submitted_at" value="${submitted_at}">
            <input type="hidden" name="feedback_id" value="${feedback_id}">

            <label>Rating:</label>
            <select name="rating" required>
                <c:forEach var="i" begin="1" end="5">
                    <option value="${i}" ${i == rating ? 'selected' : ''}>${i} ⭐</option>
                </c:forEach>
            </select>

            <input type="submit" value="Confirm">
        </form>
    </body>
    <div style="position: absolute; top: 20px; right: 20px;">
        <button onclick="window.location.href = 'cusFeedback?customer_id=${sessionScope.customer_id}'" 
                style="padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;">
            Quay Lại
        </button>
    </div>
</html>
