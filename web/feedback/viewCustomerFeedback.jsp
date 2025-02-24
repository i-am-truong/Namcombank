<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Customer Feedback</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 20px;
                padding: 20px;
            }
            h2 {
                text-align: center;
                color: #333;
            }
            form {
                text-align: center;
                margin-bottom: 20px;
            }
            select {
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ccc;
                cursor: pointer;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }
            th, td {
                padding: 12px;
                text-align: left;
            }
            th {
                background-color: #28a745;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            tr:hover {
                background-color: #ddd;
                transition: 0.3s;
            }
        </style>
        <script>
            function confirmSubmit() {
                return confirm("Bạn có muốn lọc kết quả theo đánh giá này không?");
            }
        </script>
    </head>
    <body>


        <h2>Customer Feedback</h2>

        <form action="viewCustomerFeedback" method="post" onsubmit="return confirmSubmit()">
            <label for="rating">Lọc theo đánh giá:</label>
            <select name="rating" id="rating" onchange="this.form.submit()">
                <option value="" ${empty param.rating ? 'selected' : ''}>Tất cả</option>
                <option value="1" ${param.rating == '1' ? 'selected' : ''}>1 Sao</option>
                <option value="2" ${param.rating == '2' ? 'selected' : ''}>2 Sao</option>
                <option value="3" ${param.rating == '3' ? 'selected' : ''}>3 Sao</option>
                <option value="4" ${param.rating == '4' ? 'selected' : ''}>4 Sao</option>
                <option value="5" ${param.rating == '5' ? 'selected' : ''}>5 Sao</option>
            </select>
            <label for="feedback_type">Lọc theo loại phản hồi:</label>
            <select name="feedback_type" id="feedback_type" onchange="this.form.submit()">
                <option value="" ${empty param.feedback_type ? 'selected' : ''}>Tất cả</option>
                <option value="system" ${param.feedback_type == 'system' ? 'selected' : ''}>Hệ thống</option>
                <option value="human" ${param.feedback_type == 'human' ? 'selected' : ''}>Nhân viên</option>
            </select>
        </form>

        <table>
            <tr>
                <th>Customer ID</th>
                <th>Content</th>
                <th>Submitted At</th>
                <th>Rating</th>
                <th>Type</th>
                <th>hinh anh</th>
            </tr>
            <c:forEach var="feedback" items="${listPaging}">
                <tr>
                    <td><a href="viewCustomerDetail?customer_id=${feedback.customer_id}" style="color: #007bff; text-decoration: none;">${feedback.customer_id}</a></td>
                    <td>${feedback.content}</td>
                    <td>${feedback.submitted_at}</td>
                    <td>${feedback.rating} Sao</td>
                    <td>${feedback.feedback_type}</td>
                    <td>
                        <c:if test="${not empty feedback.attachment}">
                            <img src="ImageServlet?rating=${feedback.rating}&content=${feedback.content}&submitted_at=${feedback.submitted_at}&feedback_type=${feedback.feedback_type}" alt="Feedback Image" width="200">
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <div style="text-align: center; margin-top: 20px;">
            <button onclick="window.location.href = 'managerUser'" style="padding: 10px 20px; background-color: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer;">
                Quay lại
            </button>
        </div>

        <c:forEach begin="1" end="${endPage}" var="i">
            <a href="viewCustomerFeedback?index=${i}&rating=${selectedRating}&feedback_type=${feedback_type_selected}">${i}</a>
        </c:forEach>
    </body>
</html>
