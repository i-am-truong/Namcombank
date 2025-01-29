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
                                <ul class="sub-menu">
                                    <li><a href="collection-summer.html">Summer Collection</a></li>
                                    <li><a href="collection-winter.html">Winter Collection</a></li>
                                    <li><a href="collection-best-sellers.html">My Collection</a></li>
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
                            <li><a href="contact.html">Contact Us</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- Start Shop Area -->
        <section class="shop-area pt-70 pb-70">
            <div class="container">
                <!-- Product Details -->
                <div class="row">
                    <div class="col-md-5 col-lg-6">
                        <div class="modal_tab">  
                            <div class="tab-content product-details-large">
                                <div class="tab-pane fade show active" id="detailstab1" role="tabpanel">
                                    <div class="modal_tab_img">
                                        <a href="#"><img src="${product.img}" alt="${product.name}"></a>    
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                    <div class="col-md-7 col-lg-6">
                        <div class="product-details-img-full">
                            <h2>${product.name}</h2>
                            <br>
                            <div class="pricing">
                                <span><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$"/></span>
                            </div>
                            <br>
                            <div class="variants_size">
                                <h5>Size</h5>
                                <select class="form-select">
                                    <c:forEach var="size" items="${product.sizes}">
                                        <option value="${size.sid}">${size.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <div class="modal_add_to_cart">
                                    <button class="button-1" onclick="addToCart(${product.pid})">Add to cart</button>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-50 section-bg">
                    <div class="shop-details-full-content">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="Description-tab" data-bs-toggle="tab" data-bs-target="#Description" type="button" role="tab" aria-controls="Description" aria-selected="true">Description</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="information-tab" data-bs-toggle="tab" data-bs-target="#information" type="button" role="tab" aria-controls="information" aria-selected="false">Additional Information</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="Review-tab" data-bs-toggle="tab" data-bs-target="#Review" type="button" role="tab" aria-controls="Review" aria-selected="false">Review</button>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="Description" role="tabpanel" aria-labelledby="Description-tab">
                                <p> ${product.quantity}</p>
                            </div>
                            <div class="tab-pane fade" id="information" role="tabpanel" aria-labelledby="information-tab">
                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <td>Quantity</td>
                                            <td>${product.quantity}</td>
                                        </tr>
                                        <tr>
                                            <td>Gender</td>
                                            <td>${product.gender.description}</td>
                                        </tr>
                                        <tr>
                                            <td>Release Date</td>
                                            <td>${product.releaseDate}</td>
                                        </tr>
                                        <tr>
                                            <td>Brand</td>
                                            <td>${product.brand.name}</td>
                                        </tr>
                                        <tr>
                                            <td>Category</td>
                                            <td>${product.category.name}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="tab-pane fade" id="Review" role="tabpanel" aria-labelledby="Review-tab">
                                <div class="product-review">
                                    <div class="product-review-list">
                                        <h3>2 Review For Blue Dress For Woman</h3>
                                        <ul>
                                            <!-- Single -->
                                            <li class="review-single">
                                                <img src="assets/img/avata-admin.jpg" alt="avatar">
                                                <div class="review-info">
                                                    <h5>Alea Brooks</h5>
                                                    <small> Jun 01, 2021 </small>
                                                </div>
                                                <div class="ratting">
                                                    <span><i class="fas fa-star"></i></span>
                                                    <span><i class="fas fa-star"></i></span>
                                                    <span><i class="fas fa-star"></i></span>
                                                    <span><i class="fas fa-star"></i></span>
                                                    <span><i class="fas fa-star"></i></span>
                                                </div>
                                                <div class="revie-con">
                                                    <p>Lorem Ipsumin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate</p>
                                                </div>
                                            </li>
                                            <!-- Single -->
                                            <li class="review-single">
                                                <img src="assets/img/avata-admin.jpg" alt="avatar">
                                                <div class="review-info">
                                                    <h5>Alea Brooks</h5>
                                                    <small> Jun 01, 2021 </small>
                                                </div>
                                                <div class="ratting">
                                                    <span><i class="fas fa-star"></i></span>
                                                    <span><i class="fas fa-star"></i></span>
                                                    <span><i class="fas fa-star"></i></span>
                                                    <span><i class="fas fa-star"></i></span>
                                                    <span><i class="fas fa-star"></i></span>
                                                </div>
                                                <div class="revie-con">
                                                    <p>Lorem Ipsumin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate</p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <!-- Form -->
                                    <div class="product-review-form">
                                        <h3>Add a review</h3>
                                        <div class="ratting">
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                            <span><i class="fas fa-star"></i></span>
                                        </div>
                                        <form action="#">
                                            <textarea name="review-message" class="form-control" placeholder="Your Review"></textarea>
                                            <input type="text" name="name" class="form-control" placeholder="Your Name">
                                            <input type="email" name="email" class="form-control" placeholder="Your Email">
                                            <button type="submit">Submit Review</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </section>
        <!-- Related Products Section -->
        <section class="latest-product pt-70 pb-70 section-bg">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="section-heading-1 mb-50">
                            <h2><span>Related Products</span></h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="latest-product-full owl-carousel">
                            <c:forEach var="relatedProduct" items="${relatedProducts}">
                                <div class="product-single">
                                    <div class="product-thumbnail">
                                        <a href="DetailProduct?pid=${relatedProduct.pid}">
                                            <img src="${relatedProduct.img}" alt="${relatedProduct.name}" style="width: 300px; height: 300px; object-fit: cover;">
                                        </a>
                                        <div class="product-thumbnail-overly">
                                            <ul>
                                                <li><a onclick="addToCart(${product.pid})" ><i class="fas fa-shopping-cart"></i></a></li>
                                                <li><a onclick="addToWishList(${product.pid})"><i class="far fa-heart"></i></a></li>
                                                <li><a href="#"><i class="far fa-eye"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="product-content">
                                        <h4>
                                            <a href="DetailProduct?pid=${relatedProduct.pid}">${relatedProduct.name}</a>
                                        </h4>
                                        <div class="pricing">
                                            <span><fmt:formatNumber value="${relatedProduct.price}" type="currency" currencySymbol="$"/></span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>

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