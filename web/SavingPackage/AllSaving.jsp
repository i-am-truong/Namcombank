<%@page contentType="text/html" pageEncoding="UTF-8"%>\
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách Gói Tiết Kiệm</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
                text-align: center;
            }
            h1 {
                color: #333;
            }
            .button-container {
                margin-bottom: 20px;
            }
            button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                margin: 5px;
                cursor: pointer;
                font-size: 16px;
                border-radius: 5px;
                transition: 0.3s;
            }
            button:hover {
                background-color: #0056b3;
            }
            .content {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                margin: 20px auto;
                width: 80%;
                display: none;
            }
            .active {
                display: block !important;
            }
        </style>
        <script>
            function showPage(page) {
                document.getElementById("withdrawable").classList.remove("active");
                document.getElementById("nonWithdrawable").classList.remove("active");

                document.getElementById(page).classList.add("active");
            }
        </script>
    </head>
    <body>


        <header class="header">
            <!-- Header Middle -->
            <%@include file="../homepage/header.jsp" %>
            <!-- Header Bottom -->
            <%@include file="../homepage/header_bottom.jsp" %>
        </header>
        <h1>Danh sách Gói Tiết Kiệm</h1>

        <div class="button-container">    
            <button onclick="showPage('withdrawable')">Gói Không Rút Trước Hạn</button>
            <button onclick="showPage('nonWithdrawable')">Gói Linh Hoạt</button>
        </div>

        <div id="withdrawable" class="content active">
            <%@ include file="WithdrawableSaving.jsp" %>
        </div>

        <div id="nonWithdrawable" class="content">
            <%@ include file="NonWithdrawableSaving.jsp" %>
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
