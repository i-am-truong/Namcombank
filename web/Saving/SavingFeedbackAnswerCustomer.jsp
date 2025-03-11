<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Phản Hồi Tiết Kiệm</title>
    </head>
    <body>
        <h1>Danh Sách Phản Hồi Tiết Kiệm</h1>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nội Dung</th>
                    <th>Ngày Gửi</th>
                    <th>Phản Hồi</th>

                </tr>
            </thead>
            <tbody>
                <!-- Sử dụng JSTL để lặp qua danh sách phản hồi -->
                <c:forEach var="feedback" items="${list}">
                    <tr>
                        <td>${feedback.feedback_id}</td>
                        <td>${feedback.answer}</td>
                        <td>${feedback.answer_at}</td>
                        <td>${feedback.answer}</td>
  
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
