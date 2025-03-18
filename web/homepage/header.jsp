<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Namcombank</title>
        <style>
            .dropdown-menu {
                position: absolute;
                right: 0;
                display: none;
                background-color: white;
                border: 1px solid #ccc;
                padding: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
            }

            .dropdown-menu a {
                display: block;
                padding: 5px 10px;
                color: black;
                text-decoration: none;
            }

            .dropdown-menu a:hover {
                background-color: #f0f0f0;
            }
        </style>
        <script src="${pageContext.request.contextPath}/assets/js/jquery-3.5.1.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            function addToWishList(productId) {
                var pId = productId;
                $.ajax({
                    type: 'GET',
                    data: {pId: pId},
                    url: 'addWishList',
                    success: (result) => {

                    },
                    error: function () {
                        console.log('something went wrong');
                    }
                });

            }

            function addToCart(productId) {
                var pId = productId;
                var totalProduct;
                $.ajax({
                    type: 'GET',
                    data: {pId: pId},
                    url: 'AddToCart',
                    success: (result) => {
                        if (result.outOfStock) {
                            showError("Product out of stock", 1000);
                        } else {
                            showAlert("Product added to your cart", 1000);
                        }
                        totalProduct = result.productInCart;
                        ;
                        $('.counter').text(totalProduct);
                    },
                    error: function () {
                        console.log('something went wrong');
                    }
                });

            }
            function showAlert(message, duration) {
                // Tạo phần tử alert mới
                let alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-success';
                alertDiv.role = 'alert';
                alertDiv.innerHTML = message;
                alertDiv.style = 'margin-top: 50px;z-index: 9999; position: fixed; top: 0; right: 0;width: 300px;height:50px'
                let wrapper = document.getElementById('notifications');
                // Thêm phần tử alert vào body hoặc một container cụ thể
                wrapper.appendChild(alertDiv);

                // Tự động ẩn phần tử alert sau thời gian đã định
                setTimeout(() => {
                    alertDiv.remove();
                }, duration);
            }
            function showError(message, duration) {
                // Tạo phần tử alert mới
                let alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-danger';
                alertDiv.role = 'alert';
                alertDiv.innerHTML = message;
                alertDiv.style = 'margin-top: 50px;z-index: 9999; position: fixed; top: 0; right: 0;width: 300px;height:50px'
                let wrapper = document.getElementById('notifications');
                // Thêm phần tử alert vào body hoặc một container cụ thể
                wrapper.appendChild(alertDiv);

                // Tự động ẩn phần tử alert sau thời gian đã định
                setTimeout(() => {
                    alertDiv.remove();
                }, duration);
            }


        </script>
    </head>
    <body>
        <div  id="notifications">
        </div>
        <!-- Header Middle -->
        <div class="header-middle" style="padding-top: 30px; padding-bottom: 30px;">
            <div class="container">
                <div class="row" style="display: flex; align-items: center;">
                    <!-- Logo -->
                    <div class="col-lg-2">
                        <div class="logo">
                            <h2 style="margin: 0"><a href="/Namcombank/Home"><img src="assets/img/logo3.png" alt="Logo"></a></h2>
                        </div>
                    </div>
                    <!-- Search Bar -->
                    <div class="col-lg-6" style="margin-top: 10px;">
                        <div class="header-search-form">
                            <form action="search" method="get" style="display: flex; align-items: center;">
                                <select class="form-select" name="loanPackages" style="height: 40px;">
                                    <option value="0" selected>All Loan Packages</option>
                                    <c:forEach var="loan" items="${loanPackages}">
                                        <option value="${loan.getPackageId()}">${loan.getPackageName()}</option>
                                    </c:forEach>
                                </select>
                                <input type="search" name="searchKeyword" placeholder="Search keyword here..." style="height: 40px; color: #0D4F2F">
                                <button type="submit" style="height: 40px;"><i class="fas fa-search"></i></button>
                            </form>
                        </div>
                    </div>

                    <!-- User Icon and Name -->
                    <!-- <div class="col-lg-1 text-right">
                    <c:if test="${sessionScope.customer != null}">
                        <span style="line-height: 30px;">hello</span>
                    </c:if>


                </div> -->
                    <div class="col-lg-1 text-center" style="margin-left: 100px">
                        <c:if test="${sessionScope.customer != null}" >
                            <div style="position: relative; display: inline-block;">

                                <!--                                <i class="fas fa-user" id="userIcon" style="font-size: 30px; color: black; cursor: pointer;"></i>-->
                                <span class="logo" style="margin-left: 20px">
                                    <img src="${sessionScope.customer.avatar}" 
                                         id="userIcon" 
                                         style="border-radius: 50%; height: 50px; width: 50px;">
                                </span>

                                <span class="dropdown-menu" id="dropdownMenu">
                                    <a href="#">&nbsp;&nbsp;$${sessionScope.customer.balance}</a>
                                    <a href="userProfile"><i class="fas fa-user"></i>&nbsp;&nbsp;Show profile</a>
                                    <a href="credit-cards"><i class="fas fa-card"></i>&nbsp;&nbsp;My Credit Card</a>
                                    <a href="customer-loan-requests">
                                        <i class="fas fa-shopping-bag"></i>&nbsp;&nbsp;History Request
                                    </a>
                                    <a href="repaymentSchedule"><i class="fa fa-credit-card" aria-hidden="true"></i>&nbsp;&nbsp;Schedule Payment</a>
                                    <a href="logOut"><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;Logout</a>
                                </span>
                                <span style="line-height: 30px; display: block; color: #04414d; white-space: nowrap ">${sessionScope.customer.fullname}</span>
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.customer == null}">
                            <div style="display: flex; align-items: center; gap: 20px;">
                                <a href="login" style="text-align: center;">
                                    <i class="fas fa-user" style="font-size: 30px; color: #ccc; cursor: pointer"></i>
                                    <span style="display: block; color: #04414d;">Login/Register</span>
                                </a>
                                <a href="admin.login" style="text-align: center; gap: 20px;">
                                    <i class="fas fa-user" style="font-size: 30px; color: #ccc; cursor: pointer"></i>
                                    <span style="display: block; color: #04414d;">Login By Admin</span>
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.getElementById('userIcon').addEventListener('click', function () {
                var dropdown = document.getElementById('dropdownMenu');
                if (dropdown.style.display === 'none' || dropdown.style.display === '') {
                    dropdown.style.display = 'block';
                } else {
                    dropdown.style.display = 'none';
                }
            });

            // Close the dropdown if clicked outside
            document.addEventListener('click', function (event) {
                var isClickInside = document.getElementById('userIcon').contains(event.target);
                if (!isClickInside) {
                    document.getElementById('dropdownMenu').style.display = 'none';
                }
            });

            document.addEventListener("DOMContentLoaded", function () {
                var userIcon = document.getElementById("userIcon");
                var avatarSrc = userIcon.src;
                userIcon.src = avatarSrc + "?t=" + new Date().getTime();
            });
        </script>
    </body>
</html>
