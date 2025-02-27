<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Customer Feedback</title>
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 20px;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
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
    </head>
    <body id="page-top">
        <div id="wrapper">
            <%@include file="../homepage/sidebar_admin.jsp" %>
            <div class="container">
                <h2 class="text-center">Customer Feedback</h2>
                <form action="viewCustomerFeedback" method="post">
                    <div class="form-group">
                        <label for="rating">Lọc theo đánh giá:</label>
                        <select name="rating" id="rating" class="form-control" onchange="this.form.submit()">
                            <option value="" ${empty param.rating ? 'selected' : ''}>Tất cả</option>
                            <option value="1" ${param.rating == '1' ? 'selected' : ''}>1 Sao</option>
                            <option value="2" ${param.rating == '2' ? 'selected' : ''}>2 Sao</option>
                            <option value="3" ${param.rating == '3' ? 'selected' : ''}>3 Sao</option>
                            <option value="4" ${param.rating == '4' ? 'selected' : ''}>4 Sao</option>
                            <option value="5" ${param.rating == '5' ? 'selected' : ''}>5 Sao</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="feedback_type">Lọc theo loại phản hồi:</label>
                        <select name="feedback_type" id="feedback_type" class="form-control" onchange="this.form.submit()">
                            <option value="" ${empty param.feedback_type ? 'selected' : ''}>Tất cả</option>
                            <option value="system" ${param.feedback_type == 'system' ? 'selected' : ''}>Hệ thống</option>
                            <option value="human" ${param.feedback_type == 'human' ? 'selected' : ''}>Nhân viên</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="content_search">Tìm theo mô tả:</label>
                        <input type="text" name="content_search" id="content_search" class="form-control" value="${param.content_search}" placeholder="Mô tả">
                    </div>
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </form>
                <table class="table table-bordered mt-3">
                    <thead>
                        <tr>
                            <th>Customer ID</th>
                            <th>Content</th>
                            <th>Submitted At</th>
                            <th>Rating</th>
                            <th>Type</th>
                            <th>Hình ảnh</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="feedback" items="${listPaging}">
                            <tr>
                                <td><a href="viewCustomerDetail?customer_id=${feedback.customer_id}" class="text-primary">${feedback.customer_id}</a></td>
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
                    </tbody>
                </table>
                <div class="text-center mt-3">
                    <button onclick="window.location.href = 'managerUser'" class="btn btn-secondary">Quay lại</button>
                </div>
                <div class="text-center mt-3">
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <a href="viewCustomerFeedback?index=${i}&rating=${selectedRating}&feedback_type=${feedback_type_selected}&content_search=${content_search_selected}" class="btn btn-outline-primary">${i}</a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </body>
</html>
