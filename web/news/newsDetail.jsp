<%-- 
    Document   : newsList
    Created on : 25/05/2024, 4:26:04 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
							<li><a href="index.html">Home</a></li>
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
				<div class="col-lg-8">
					<div class="blog-details">
						<div class="blog-item">
							
							<div class="content">
								<ul class="auth">
									<li><a href="#">by ${news.authorName}</a></li>
									<li><a href="#">${news.updateDate}</a></li>
								</ul>
                                                                        <h1>${news.title}</h1>
                                                                ${news.body}
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