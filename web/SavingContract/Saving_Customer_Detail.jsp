<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Chi tiết tài khoản tiết kiệm</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Banking Services System</title>
        <link rel="icon" href="assets/img/icon.png" type="image/gif" sizes="16x16">
        <link rel="icon" href="assets/img/icon.png" type="image/gif" sizes="18x18">
        <link rel="icon" href="assets/img/icon.png" type="image/gif" sizes="20x20">

        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/normalize.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">

        <style>
            .news-item {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .news-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }

            .news-item .card {
                border: 1px solid rgba(0,0,0,0.08);
                border-radius: 8px;
                overflow: hidden;
                height: 100%;
            }

            .news-item .card-title {
                font-size: 1.2rem;
                font-weight: 600;
                line-height: 1.3;
                margin-bottom: 10px;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .news-item .card-text {
                color: #555;
            }

            .news-item .card-body {
                padding: 1.25rem;
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .news-item .btn-outline-primary {
                margin-top: auto;
                align-self: flex-start;
            }

            .pagination-container .page-item.active .page-link {
                background-color: #0b5ed7;
                border-color: #0a58ca;
            }

            @media (max-width: 767px) {
                .news-item .card-img {
                    height: 200px;
                    border-radius: 4px 4px 0 0;
                }
            }

            /* Make sidebar sticky */
            .sticky-sidebar {
                position: sticky;
                top: 20px;
            }

            /* Fix for layout issues at different page sizes */
            /* Force the columns to maintain their position side by side */
            .row.news-container {
                display: flex;
                flex-wrap: nowrap;
            }

            .news-main-column {
                width: 67%;
                padding-right: 15px;
                flex: 0 0 67%;
            }

            .news-sidebar-column {
                width: 33%;
                padding-left: 15px;
                flex: 0 0 33%;
            }

            /* Make sure sidebar sticks properly */
            .sticky-sidebar {
                position: sticky;
                top: 20px;
                height: fit-content;
            }

            /* Ensure responsiveness */
            @media (max-width: 991px) {
                .row.news-container {
                    flex-wrap: wrap;
                }

                .news-main-column,
                .news-sidebar-column {
                    width: 100%;
                    flex: 0 0 100%;
                    padding-left: 15px;
                    padding-right: 15px;
                }

                .news-sidebar-column {
                    margin-top: 30px;
                }
            }
        </style>
    </head>
    <body>
        <header class="header">
            <!-- Header Middle -->
            <%@include file="../homepage/header.jsp" %>
            <!-- Header Bottom -->
            <%@include file="../homepage/header_bottom.jsp" %>
        </header>
        <div class="container">
            <h2>Chi tiết gói tiết kiệm của bạn</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Mã Tiết Kiệm</th>
                        <th>Số Tiền Nhận</th>
                        <th>Lãi Suất (%)</th>
                        <th>Kỳ Hạn (Tháng)</th>
                        <th>Ngày Mở</th>
                        <th>Trạng Thái</th>
                        <th>Nhân Viên Xử Lý</th>
                        <th>Ngày Nhận Tiền</th>
                        <th>Tên Khách Hàng</th>
                        <th>Phương thức nhận tiền</th>
                        <th>Phản Hồi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${list}">

                    <td>${s.savings_id}</td>
                    <td><fmt:formatNumber value="${s.amount}" type="currency"/></td>
                    <td>${s.interest_rate}</td>
                    <td>${s.term_months}</td>
                    <td>
                        <fmt:parseDate value="${s.opened_date}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                    </td>
                    <td>${s.status}</td>
                    <td>${s.staff_id}</td>
                    <td>
                        <fmt:parseDate value="${s.money_get_date}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                    </td>
                    <td>${s.customer_name}</td>
                    <td>
                        <form action="SavingCustomerDetail" method="post">
                            <input name="savings_id" value="${s.savings_id}" hidden>
                            <select name="payment_method" onchange="this.form.submit()">
                                <c:choose>
                                    <c:when test="${empty s.payment_method}">
                                        <option value="" selected>-- Chọn phương thức --</option>
                                    </c:when>
                                </c:choose>
                                <option value="CASH" ${s.payment_method == 'CASH' ? 'selected' : ''}>CASH</option>
                                <option value="TRANSFER" ${s.payment_method == 'TRANSFER' ? 'selected' : ''}>TRANSFER</option>
                            </select>
                        </form>
                    </td>

                    <td>
                        <form action="SavingFeedback" method="get">
                            <input type="hidden" name="savings_id" value="${s.savings_id}">
                            <button type="submit" class="btn btn-success">Gửi phản hồi</button>
                        </form>
                        <a href="SavingFeedbackAnswerCustomer?savings_id=${s.savings_id}">xem phản hồi</a>
                    </td>

                </c:forEach>
                </tbody>
            </table>
            <button class="btn-back" onclick="window.location.href = 'SavingCustomerActive'">Quay Lại</button>

        </div>
        </div>
                </div>
        <%@include file="../homepage/footer.jsp" %>
        <div class="scroll-area">
            <i class="fa fa-angle-up"></i>
        </div>

        <!-- Js File -->
        <script src="assets/js/modernizr.min.js"></script>
        <script src="assets/js/jquery-3.5.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/owl.carousel.min.js"></script>
        <script src="assets/js/jquery.nav.min.js"></script>
        <script src="assets/js/jquery.magnific-popup.min.js"></script>
        <script src="assets/js/mixitup.min.js"></script>
        <script src="assets/js/wow.min.js"></script>
        <script src="assets/js/script.js"></script>
        <script src="assets/js/mobile-menu.js"></script>
        <script src="${pageContext.request.contextPath}/adminassets/js/format-input.js"></script>

        <!-- Add JavaScript function to handle page size change -->
        <script>
                    function changePageSize() {
                        // Get the current URL
                        const url = new URL(window.location.href);
                        // Get the selected page size value
                        const pageSize = document.getElementById('pageSize').value;
                        // Set the page-size parameter
                        url.searchParams.set('page-size', pageSize);
                        // Reset to page 1 when changing page size
                        url.searchParams.set('page', '1');
                        // Navigate to the new URL
                        window.location.href = url.toString();
                    }

                    // Add event listener for the clear button
                    document.addEventListener('DOMContentLoaded', function () {
                        document.getElementById('clearSearchBtn').addEventListener('click', function () {
                            // Clear all input fields
                            document.getElementById('search').value = '';
                            document.getElementById('author').value = '';

                            // Reset sorting to default
                            document.getElementById('sortOrderFilter').value = '';

                            // Either submit the form or redirect to the base URL
                            window.location.href = 'newsList';
                        });
                    });
        </script>
    </body>
</html>
<script>
    function confirmPaymentMethod(selectElement) {
        if (selectElement.value) {
            const confirmChange = confirm("Bạn có chắc muốn chọn phương thức: " + selectElement.value + "?");
            if (!confirmChange) {
                selectElement.value = "";
            }
        }
    }
    function confirmSubmit(select) {
        if (confirm("Bạn có chắc chắn muốn thay đổi phương thức thanh toán?")) {
            select.form.submit();
        }
    }

</script>
