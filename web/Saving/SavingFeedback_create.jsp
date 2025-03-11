<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Gửi Phản Hồi Tiết Kiệm</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <h2>Gửi Phản Hồi Tiết Kiệm</h2>
            <form action="SavingFeedback" method="post">
                <div class="mb-3">
                    <input type="text" name="savings_id" value="${savings_id}">
                </div>
                <div class="mb-3">
                    <label class="form-label">Nội dung phản hồi:</label>
                    <textarea name="content" class="form-control" required></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Loại phản hồi:</label>
                    <select name="feedback_type" class="form-select" required>
                        <option value="question">Câu hỏi</option>
                        <option value="suggestion">Góp ý</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Đường dẫn ảnh (nếu có):</label>
                    <input type="text" name="attachment" class="form-control">
                </div>
                <a href="SavingCustomerActive">Quay lại</a>
                <button type="submit" class="btn btn-primary">Gửi Phản Hồi</button>

            </form>
            <a href="SavingCustomerActive">Quay lại</a>
            <c:if test="${not empty success}">
                <div class="alert alert-success mt-3">Phản hồi đã được gửi thành công!</div>
            </c:if>
            <c:if test="${not empty errorC}">
                <div class="alert alert-danger mt-3">${errorC}</div>
            </c:if>
            <c:if test="${not empty errorA}">
                <div class="alert alert-danger mt-3">${errorA}</div>
            </c:if>
        </div>
    </body>
</html>
