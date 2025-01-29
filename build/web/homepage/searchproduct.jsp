<%@ page import="model.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  class="no-js" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Namcombank - Search Results</title>
        <link rel="icon" href="assets/img/icon.png" type="image/gif" sizes="16x16">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/normalize.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
    </head>
    <body>
        <div class="off_canvars_overlay"></div>
        <!-- Header -->
        <header class="header">
            <%@include file="header.jsp" %>
                 <!-- Header Bottom -->
            <%@include file="../homepage/header_bottom.jsp" %>
        </header>
        <!-- Header -->

        <!-- Start Mobile Menu Area -->
        <div class="mobile-menu-area">
            <div class="off_canvars_overlay"></div>
            <div class="offcanvas_menu">
                <div class="offcanvas_menu_wrapper">
                    <div class="canvas_close">
                        <a href="javascript:void(0)"><i class="fas fa-times"></i></a>
                    </div>
                    <div class="mobile-logo">
                        <h2><a href="index.html"><img src="assets/img/logo.png" alt="Logo"></a></h2>
                    </div>
                    <div id="menu" class="text-left">
                        <ul class="offcanvas_main_menu">
                            <li><a href="/Namcombank/Home">Home</a></li>
                            <li class="menu-item-has-children">
                                <a href="/Namcombank/AllProduct">Shop</a>
                                <ul class="submenu-item">
                                    <li><a href="/Namcombank/AllProduct">All Products</a></li>
                                    <li><a href="gender-products?gender=men">Men</a></li>
                                    <li><a href="gender-products?gender=women">Women</a></li>
                                    <li><a href="gender-products?gender=other">Other</a></li>
                                </ul>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="#">Collections</a>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="#">Blog</a>
                                <ul class="sub-menu">
                                    <li><a href="blog.html">Blog</a></li>
                                    <li><a href="blog-grid.html">Blog Grid</a></li>
                                    <li><a href="single.html">Blog Single</a></li>
                                </ul>
                            </li>
                            <li><a href="contact.html">Contact Us</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Start Shop Area -->
        <section class="shop-area pt-70 pb-70">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8">
                        <!-- Shop Top Pagination -->
                        <div class="row section-bg pt-20 pb-20 mb-30">
                            <div class="col-lg-5 col-md-6 order-1 order-md-2">
                                <div class="top-bar-right">
                                    <select class="form-select" id="sortSelect" aria-label="Default select example" onchange="changeSort()">
                                        <option value="name" ${sortBy == 'name' ? 'selected' : ''}>Sort by Name</option>
                                        <option value="price" ${sortBy == 'price' ? 'selected' : ''}>Sort by Price</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <script>
                            function changeSort() {
                                var sortBy = document.getElementById('sortSelect').value;
                                var searchKeyword = '<%= request.getParameter("searchKeyword") %>';
                                var categoryId = '<%= request.getParameter("categoryId") %>';
                                window.location.href = 'search?sortBy=' + sortBy + '&searchKeyword=' + searchKeyword + '&categoryId=' + categoryId;
                            }
                        </script>

                        <!-- Shop -->
                        <div class="row">
                            <!-- Product Single -->
                            <c:forEach var="product" items="${products}">
                                <div class="col-lg-4 col-md-4 col-sm-6 mb-30">
                                    <div class="product-single">
                                        <div class="product-thumbnail">
                                            <a href="DetailProduct?pid=${product.pid}">
                                                <img src="${product.img}" alt="${product.name}" style="width: 100%; height: 300px; object-fit: cover;">
                                            </a>
                                            <div class="product-thumbnail-overly">
                                                <ul>    
                                                     <li><a onclick="addToCart(${product.pid})"><i class="fas fa-shopping-cart"></i></a></li>
                                                    <li><a onclick="addToWishList(${product.pid})"><i class="far fa-heart"></i></a></li>   
                                                    <li><a href="DetailProduct?pid=${product.pid}"><i class="far fa-eye"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="product-content">
                                            <h4><a href="DetailProduct?pid=${product.pid}">${product.name}</a></h4>
                                            <div class="pricing">
                                                <span>$${product.price}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <!-- End Shop -->
                        <div class="row">
                            <div class="col-12 mb-30">
                                <div class="page-pagination text-center">
                                    <ul>
                                        <li><a href="search?sortBy=${sortBy}&searchKeyword=${searchKeyword}&categoryId=${categoryId}&page=${currentPage - 1}" ${currentPage == 1 ? 'style="display:none;"' : ''}><i class="fa fa-angle-left"></i></a></li>
                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li><a href="search?sortBy=${sortBy}&searchKeyword=${searchKeyword}&categoryId=${categoryId}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a></li>
                                            </c:forEach>
                                        <li><a href="search?sortBy=${sortBy}&searchKeyword=${searchKeyword}&categoryId=${categoryId}&page=${currentPage + 1}" ${currentPage == totalPages ? 'style="display:none;"' : ''}><i class="fa fa-angle-right"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- Siderbar -->
                    <div class="col-lg-4">
                        <div class="sidebar-widgets">
                            <h4 class="title">Latest Products</h4>
                            <c:forEach var="product" items="${products2}">
                                <div class="widgets-latest-product-full">
                                    <!-- Single -->

                                    <div class="widgets-latest-product-single mb-30">
                                        <div class="thumbanil">
                                            <a href="#">
                                                <img src="${product.img}" alt="${product.name}" style="width: 100%; object-fit: cover;">
                                            </a>
                                        </div>
                                        <div class="content">
                                            <h4><a href="#">${product.name}</a></h4>
                                            <div class="pricing">
                                                <span>$${product.price}</span>
                                            </div>
                                        </div>
                                    </div

                                </div>
                            </c:forEach>
                        </div>
                        <!-- Single -->
                        <div class="sidebar-widgets">
                            <h4 class="title">Recent News</h4>
                            <ul>
                                <li><a href="#">Top 5 Savings Plans for 2025</a></li>
                                <li><a href="#">How to Apply for a Personal Loan Online</a></li>
                                <li><a href="#">5 Tips to Manage Your Loan Repayments Effectively UK</a></li>
                                <li><a href="#">Why Fixed Deposits are Still a Great Investment Option</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </section>
    <!-- End Shop Area -->

          <!-- Start Footer Area -->
        <%@include file="../homepage/footer.jsp" %>

        <!-- End Footer Area -->

    <!-- Javascript -->
    <script src="assets/js/vendor/modernizr-3.6.0.min.js"></script>
    <script src="assets/js/vendor/jquery-3.3.1.min.js"></script>
    <script src="assets/js/vendor/popper.min.js"></script>
    <script src="assets/js/vendor/bootstrap.min.js"></script>
    <script src="assets/js/vendor/owl.carousel.min.js"></script>
    <script src="assets/js/vendor/slick.min.js"></script>
    <script src="assets/js/vendor/jquery.counterup.min.js"></script>
    <script src="assets/js/vendor/jquery.countdown.js"></script>
    <script src="assets/js/vendor/waypoints.min.js"></script>
    <script src="assets/js/vendor/jquery.magnific-popup.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
