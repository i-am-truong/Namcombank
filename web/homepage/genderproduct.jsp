<%@ page import="model.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  class="no-js" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank</title>
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

    </head>
    <body>
        <div id="preloader" class="preeloader">
            <div class="sk-circle">
                <div class="sk-circle1 sk-child"></div>
                <div class="sk-circle2 sk-child"></div>
                <div class="sk-circle3 sk-child"></div>
                <div class="sk-circle4 sk-child"></div>
                <div class="sk-circle5 sk-child"></div>
                <div class="sk-circle6 sk-child"></div>
                <div class="sk-circle7 sk-child"></div>
                <div class="sk-circle8 sk-child"></div>
                <div class="sk-circle9 sk-child"></div>
                <div class="sk-circle10 sk-child"></div>
                <div class="sk-circle11 sk-child"></div>
                <div class="sk-circle12 sk-child"></div>
            </div>
        </div>
        <div class="off_canvars_overlay"></div>
        <!-- Header -->
        <header class="header">
            <!-- Header Top -->
            <!-- Header Middle -->
            <%@include file="header.jsp" %>
            <!-- Header Bottom -->
            <%@include file="../homepage/header_bottom.jsp" %>
        </header>
        <!-- Header -->

        <!-- Start Mobile Menu Area -->
        <div class="mobile-menu-area">

            <!--offcanvas menu area start-->
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
                            <li><a href="/Namcombank/allLoanPackages">Loan Packages <i class="fa fa-angle-down"></i></a>
                                <ul class="submenu-item">
                                    <li><a href="/Namcombank/allLoanPackages">All Loan Packages</a></li>
                                    <li><a href="persional-loans">Personal Loans</a></li>
                                    <li><a href="bussiness-loans">Business Loans</a></li>
                                    <li><a href="unsecured-loans">Unsecured Loans</a></li>
                                    <li><a href=secured-loans">Secured Loans</a></li>

                                </ul>
                            </li>
                            <li><a href="/Namcombank/allSavings">Savings <i class="fa fa-angle-down"></i></a>
                                <ul class="submenu-item">
                                    <li><a href="/Namcombank/allSavings">All Savings</a></li>
                                    <li><a href="savings-without-term">Savings without term</a></li>
                                    <li><a href="term-savings">Term Savings</a></li>
                                    <li><a href="accumulated-savings">Accumulated savings</a></li>
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
                                var currentPage = ${currentPage};
                                window.location.href = 'gender-products?gender=${gender}&sortBy=' + sortBy + '&page=' + currentPage;
                            }
                        </script>
                        <!-- Shop -->
                        <div class="row">
                            <!-- No Products Message -->
                            <c:if test="${not empty message}">
                                <div class="col-12">
                                    <p>${message}</p>
                                </div>
                            </c:if>

                            <!-- Product Single -->
                            <c:forEach var="product" items="${products}">
                                <div class="col-lg-4 col-md-4 col-sm-6 mb-30">
                                    <div class="product-single">
                                        <div class="product-thumbnail">
                                            <a href="product-details.html">
                                                <img src="${product.img}" alt="${product.name}" style="width: 100%; height: 300px; object-fit: cover;">
                                            </a>
                                            <div class="product-thumbnail-overly">
                                                <ul>
                                                    <li><a onclick="addToCart(${product.pid})"><i class="fas fa-shopping-cart"></i></a></li>
                                                    <li><a onclick="addToWishList(${product.pid})"><i class="far fa-heart"></i></a></li>   
                                                    <li><a href="#"><i class="far fa-eye"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="product-content">
                                            <h4><a href="product-details.html">${product.name}</a></h4>
                                            <div class="pricing">
                                                <span>$${product.price}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="row">
                                <div class="col-12 mb-30">
                                    <div class="page-pagination text-center">
                                        <ul>
                                            <li><a href="gender-products?gender=${gender}&sortBy=${sortBy}&page=${currentPage - 1}" ${currentPage == 1 ? 'style="display:none;"' : ''}><i class="fa fa-angle-left"></i></a></li>
                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li><a href="gender-products?gender=${gender}&sortBy=${sortBy}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a></li>
                                                </c:forEach>
                                            <li><a href="gender-products?gender=${gender}&sortBy=${sortBy}&page=${currentPage + 1}" ${currentPage == totalPages ? 'style="display:none;"' : ''}><i class="fa fa-angle-right"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:if>
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
                            <h4 class="title">Recent Post</h4>
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
        </section>
        <!-- End Shop Area -->



        <!-- Start Footer Area -->
        <%@include file="../homepage/footer.jsp" %>

        <!-- End Footer Area -->




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
    </body>
</html>