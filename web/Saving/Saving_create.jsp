<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
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
        <div class="container">
            <header class="header">
                <!-- Header Middle -->
                <%@include file="../homepage/header.jsp" %>
                <!-- Header Bottom -->
                <%@include file="../homepage/header_bottom.jsp" %>
            </header>
            <p>HOME > SAVING > Tạo Gói Tiết Kiệm</p>
            <h1>Tạo yêu cầu gửi tiết kiệm trực tuyến</h1>
            <form action="Saving_create" method="get" id="savingForm">
                <label>Chọn loại gói tiết kiệm:</label>
                <select id="saving_package_withdrawable" name="saving_package_withdrawable" onchange="document.getElementById('savingForm').submit();"> 
                    <option value="5">-- Chọn loại gói --</option>
                    <option value="1">Gói tiết kiệm Linh Hoạt</option>
                    <option value="0">Gói tiết kiệm Không Rút Trước Hạn</option>
                </select>
            </form>
            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <br>
            <br>
            <a href="Home">Quay Lại</a>
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
