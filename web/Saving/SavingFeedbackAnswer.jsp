<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh Sách Phản Hồi Tiết Kiệm</title>
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
                text-align: center;
            }
            .btn {
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
            }
            .btn-approve {
                background-color: #28a745;
                color: white;
            }
            .btn-reject {
                background-color: #dc3545;
                color: white;
            }
            .custom-green-btn {
                background-color: #28a745 !important;
                border-color: #28a745 !important;
            }

        </style>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <%@ include file="../homepage/sidebar_admin.jsp" %>
            <div id="content-wrapper" class="d-flex flex-column">
                <%@include file="../homepage/header_admin.jsp" %>
                <div class="container">
                    <h2 class="text-center">Danh Sách Phản Hồi Tiết Kiệm</h2>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nội Dung</th>
                                <th>Ngày Gửi</th>
                                <th>Loại Phản Hồi</th>
                                <th>Phản Hồi</th>
                                <th>Tệp Đính Kèm</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="feedback" items="${list}">
                                <tr>
                                    <td>${feedback.feedback_id}</td>
                                    <td>${feedback.content}</td>
                                    <td>
                                        <fmt:parseDate value="${feedback.submitted_at}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>${feedback.feedback_type}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${feedback.answer != null}">
                                                ${feedback.answer}
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Thêm form để gửi phản hồi -->
                                                <form action="SavingFeedbackAnswer" method="POST">
                                                    <input type="hidden" name="feedback_id" value="${feedback.feedback_id}">
                                                    <textarea name="answer" placeholder="Nhập phản hồi" required></textarea>
                                                    <button type="submit" class="btn btn-success">Gửi Phản Hồi</button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty feedback.attachment}">
                                                <img src="${feedback.attachment}" alt="Attachment" style="max-width: 100px; max-height: 100px;" />
                                            </c:when>
                                            <c:otherwise>
                                                <span>Không có tệp</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>


                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
