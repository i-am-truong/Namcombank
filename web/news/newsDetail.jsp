<%--
    Document   : newsList
    Created on : 25/05/2024, 4:26:04 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="Utils.DateFormatter" %>

<!DOCTYPE html>
<html  class="no-js" lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Namcombank - Banking Services System | News Details</title>
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

        <!-- CSS để xử lý hiển thị ảnh trong nội dung bài viết -->
        <style>
            .news-content img {
                max-width: 100%;
                height: auto;
                display: block;
                margin: 1rem auto;
            }

            .news-content figure {
                max-width: 100%;
                margin: 1rem 0;
            }

            .news-content figure img {
                max-width: 100%;
                height: auto;
            }

            .news-content figcaption {
                text-align: center;
                font-style: italic;
                margin-top: 0.5rem;
            }

            .news-content * {
                max-width: 100%;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="header">
            <!-- Header Top -->

            <!-- Header Middle -->
            <%@include file="../homepage/header.jsp" %>
            <!-- Header Bottom -->
            <%@include file="../homepage/header_bottom.jsp" %>
        </header>
        <!-- Header -->

        <!-- Start Mobile Menu Area -->
        <div class="mobile-menu-area">

            <!--offcanvas menu area start-->
            <div class="off_canvars_overlay">

            </div>
            <div class="offcanvas_menu">
                <div class="offcanvas_menu_wrapper">
                    <div class="canvas_close">
                        <a href="javascript:void(0)"><i class="fas fa-times"></i></a>
                    </div>
                    <div class="mobile-logo">
                        <h2><a href="index.html"><img src="assets/img/logo.png"></a></h2>
                    </div>
                    <div id="menu" class="text-left ">
                        <ul class="offcanvas_main_menu">
                            <li class="menu-item-has-children">
                                <a href="index.html">Home</a>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="about.html">about Us</a>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="#">Page</a>
                                <ul class="sub-menu">
                                    <li><a href="cart.html">Cart</a></li>
                                    <li><a href="wishlist.html"> Wishlist</a></li>
                                    <li><a href="checkout.html">Checkout</a></li>
                                    <li><a href="login.html">Login</a></li>
                                    <li><a href="register.html">Register</a></li>
                                    <li><a href="reset-password.html">Reset Password</a></li>
                                    <li><a href="privacy-policy.html">Privacy Policy</a></li>
                                    <li><a href="terms-condition.html">Terms & Condition</a></li>
                                    <li><a href="404.html">404 Error</a></li>
                                    <li><a href="faq.html">Faq</a></li>
                                </ul>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="#">Shop</a>
                                <ul class="sub-menu">
                                    <li><a href="shop.html">Shop</a></li>
                                    <li><a href="shop2-columns.html">Shop 2 Columns</a></li>
                                    <li><a href="shop-grid.html">Shop Grid</a></li>
                                    <li><a href="shop-left-sidebar.html">Shop Left Sidebar</a></li>
                                    <li><a href="shop-list.html">Shop List</a></li>
                                </ul>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="#">Elements</a>
                                <ul class="sub-menu">
                                    <li class="menu-item-has-children">
                                        <a href="#">Elements</a>
                                        <ul class="sub-menu">
                                            <li><a href="element-infobox.html">Element Info Box</a></li>
                                            <li><a href="element-breadcrumb.html">Element Breadcrum</a></li>
                                            <li><a href="element-heading.html">Element Headding</a></li>
                                            <li><a href="element-post.html">Element Post Element</a></li>
                                            <li><a href="element-pricing.html">Element Pricing</a></li>
                                        </ul>
                                    </li>
                                    <li class="menu-item-has-children">
                                        <a href="#">Elements</a>
                                        <ul class="sub-menu">
                                            <li><a href="element-product-category.html">Element Product Category</a></li>
                                            <li><a href="element-product-style.html">Element Product Style</a></li>
                                            <li><a href="element-product-tab.html">Element Product Tab</a></li>
                                            <li><a href="element-team-style.html">Element Team</a></li>
                                            <li><a href="element-testimonial.html">Element Testimonial</a></li>
                                        </ul>
                                    </li>
                                    <li class="menu-item-has-children">
                                        <a href="#">Elements</a>
                                        <ul class="sub-menu">
                                            <li><a href="shop.html">Element Shop</a></li>
                                            <li><a href="shop2-columns.html">Element Shop 2 Columns</a></li>
                                            <li><a href="shop-grid.html">Element Shop Grid</a></li>
                                            <li><a href="shop-left-sidebar.html">Element Shop Left Sidebar</a></li>
                                            <li><a href="shop-list.html">Element Shop List</a></li>
                                        </ul>
                                    </li>
                                    <li class="menu-item-has-children">
                                        <a href="#">Elements</a>
                                        <ul class="sub-menu">
                                            <li><a href="product-details.html">Element Shop Single</a></li>
                                            <li><a href="cart.html">Element Cart Page</a></li>
                                            <li><a href="checkout.html">Element CheckOut Page</a></li>
                                            <li><a href="wishlist.html">Element Wishlist</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="#">Blog</a>
                                <ul class="sub-menu">
                                    <li><a href="blog.html">Blog</a></li>
                                    <li><a href="blog-grid.html">Blog Grid</a></li>
                                    <li><a href="single.html">Blog Single</a></li>
                                </ul>
                            </li>
                            <li class="menu-item-has-children">
                                <a href="contact.html"> Contact Us</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!--offcanvas menu area end-->
        <!-- End Mobile Menu Area -->
        <!-- Start BreadCrumb Area -->
        <div class="breadcrumb-area pt-100 pb-100" style="background-image: url('assets/img/breadcrumb.jpg');">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb-content">
                            <h2>News Details</h2>
                            <ul>
                                <li><a href="newsList">Back to News</a></li>
                                <li class="active">News Details</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End BreadCrumb Area -->

        <!-- Start Blog Area -->
        <section class="blog-area pt-70 pb-70">
            <div class="container">
                <div class="row">
                    <!-- Blog -->
                    <div class="col-lg-12">
                        <div class="blog-details">
                            <div class="blog-item">

                                <div class="content">
                                    <ul class="auth">
                                        <li><a href="#">by ${not empty news.authorName ? news.authorName : 'Unknown'}</a></li>
                                        <li><a href="#">${DateFormatter.formatDefault(news.updateDate)}</a></li>
                                        <h1>${news.title}</h1>
                                        <!-- Thêm class news-content để áp dụng CSS cho nội dung bài viết -->
                                        <div class="news-content">
                                            ${news.body}
                                        </div>
                                </div>
                            </div>

                            <!-- Related News Section -->
                            <div class="related-news mt-5">
                                <h3 class="mb-4">Related News</h3>
                                <div class="row">
                                    <c:forEach items="${relatedNews}" var="related">
                                        <div class="col-lg-4 col-md-6 mb-4">
                                            <div class="related-news-item" style="height: 100%; border: 1px solid rgba(0,0,0,0.08); border-radius: 8px; overflow: hidden;">
                                                <!-- Thumbnail -->
                                                <a href="newsDetail?id=${related.nId}">
                                                    <img src="${related.thumbnail}" alt="Related news thumbnail"
                                                         style="width: 100%; height: 180px; object-fit: cover; border-radius: 8px 8px 0 0;">
                                                </a>
                                                <!-- Content -->
                                                <div class="p-3">
                                                    <h5 style="margin: 0 0 8px; font-size: 16px; font-weight: 600; line-height: 1.3;">
                                                        <a href="newsDetail?id=${related.nId}" style="color: #333; text-decoration: none;">
                                                            ${related.title}
                                                        </a>
                                                    </h5>
                                                    <div class="meta" style="font-size: 13px; color: #777; margin-bottom: 8px;">
                                                        <span style="margin-right: 10px;">
                                                            <i class="fas fa-user" style="margin-right: 3px;"></i>
                                                            ${not empty related.authorName ? related.authorName : 'Unknown'}
                                                        </span>
                                                        <span>
                                                            <i class="fas fa-calendar-alt" style="margin-right: 3px;"></i>
                                                            ${DateFormatter.formatDefault(related.updateDate)}
                                                        </span>
                                                    </div>
                                                    <p style="font-size: 14px; margin-bottom: 8px; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                                        ${related.description.replaceAll("\\<[^>]*>", "").length() > 100 ?
                                                          related.description.replaceAll("\\<[^>]*>", "").substring(0, 100).concat('...') :
                                                          related.description.replaceAll("\\<[^>]*>", "")}
                                                    </p>
                                                    <a href="newsDetail?id=${related.nId}" class="btn btn-sm btn-outline-primary">Read More</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty relatedNews}">
                                        <div class="col-12">
                                            <div class="alert alert-light text-center">
                                                No related news available at this time.
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- Siderbar -->
                    <div class="col-lg-4">
                        <!-- Single -->

                        <!-- Single -->

                        <!-- Single -->

                        <!-- Single -->

                        <!-- Single -->

                    </div>
                </div>
            </div>
        </section>
        <!-- End Blog Area -->

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