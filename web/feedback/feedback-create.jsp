<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Insert Feedback</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f7fc;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 50%;
                margin: 50px auto;
                background-color: #ffffff;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                color: #333;
            }
            label {
                font-weight: bold;
                margin-bottom: 8px;
                display: block;
            }
            input, textarea, select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }
            textarea {
                resize: vertical;
            }
            button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
                width: 100%;
            }
            button:hover {
                background-color: #45a049;
            }
            .form-group {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Submit Feedback</h2>
            <form action="addFeedback" method="post" enctype="multipart/form-data">

                <div class="form-group">
                    <label for="feedback_type">Feedback Type:</label><br>
                    <select id="feedback_type" name="feedback_type" required>
                        <option value="human">Nhân viên</option>
                        <option value="system">Hệ thống</option>
                    </select><br>
                </div>

                <div class="form-group">
                    <label for="customer_id"></label>
                    <input type="text" name="customer_id" value="${sessionScope.customer_id}" hidden><br>
                </div>

                <div class="form-group">
                    <label for="content">Feedback Content:</label><br>
                    <textarea id="content" name="content" rows="4" cols="50"></textarea><br>
                </div>

                <div class="form-group">
                    <label for="submitted_at">Submitted At:</label>
                    <input type="date" id="submitted_at" name="submitted_at" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                           readonly><br>
                </div>

                <div class="form-group">
                    <label for="rating">Rating:</label>
                    <select id="rating" name="rating" required>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select><br>
                </div>

                <!-- Mục chọn file -->
                <div class="form-group">
                    <label for="attachment">Upload Image (optional):</label>
                    <input type="file" id="attachment" name="attachment" accept="image/*"><br>
                </div>

                <button type="submit">Submit Feedback</button>
            </form>

            <button onclick="window.location.href = 'viewFeedback'" style="padding: 10px 20px; background-color: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer;">
                Back
            </button>   
        </div>

    </body>
</html>
