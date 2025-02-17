<%-- 
    Document   : home
    Created on : Jun 20, 2024, 10:22:00 PM
    Author     : lenovo
--%>
<%@ page import="model.*" %>
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
        <link rel="icon" href="assets/img/icon.jpg" type="image/gif" sizes="16x16">
        <link rel="icon" href="assets/img/icon.jpg" type="image/gif" sizes="18x18">
        <link rel="icon" href="assets/img/icon.jpg" type="image/gif" sizes="20x20">

        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/normalize.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
        <script src="${pageContext.request.contextPath}/assets/js/jquery-3.5.1.min.js" type="text/javascript"></script>

        <style>
            /* Nút */
            .button-1 {
                background-color: #28a745; /* Xanh lá cây đậm */
                color: #ffffff; /* Chữ màu trắng */
                border: 2px solid #28a745; /* Viền cùng màu */
                border-radius: 5px; /* Bo góc */
                padding: 10px 20px; /* Cách lề trong */
                font-size: 16px; /* Kích thước chữ */
                font-weight: bold; /* Chữ đậm */
                cursor: pointer; /* Con trỏ chuột */
                transition: background-color 0.3s ease, border-color 0.3s ease;
            }

            .button-1:hover {
                background-color: #218838; /* Xanh lá cây đậm hơn */
                border-color: #1e7e34; /* Viền đậm hơn */
            }

            /* Tiêu đề */
            h1, h2, h3, h4, h5, h6, .section-headding-1 span {
                color: #28a745; /* Xanh lá cây đậm */
                font-weight: bold;
                text-transform: uppercase; /* Chữ in hoa */
            }

            /* Liên kết */
            a {
                color: #28a745; /* Xanh lá cây đậm */
                text-decoration: none; /* Không gạch chân */
                transition: color 0.3s ease;
            }

            a:hover {
                color: #218838; /* Xanh lá cây đậm hơn */
                text-decoration: underline; /* Gạch chân khi hover */
            }

            /* Nền */
            .hero-slider-single {
                background-color: #81c784; /* Xanh lá cây nhạt */
                color: #ffffff; /* Chữ trắng */
                padding: 20px;
                border-radius: 10px; /* Bo góc nhẹ */
            }

            /* Thanh điều hướng */
            .offcanvas_main_menu li a {
                color: #28a745; /* Xanh lá cây đậm */
                font-size: 16px; /* Kích thước chữ */
                font-weight: bold; /* Chữ đậm */
            }

            .offcanvas_main_menu li a:hover {
                color: #218838; /* Xanh lá cây đậm hơn */
                text-decoration: underline; /* Gạch chân khi hover */
            }

            /* Các khối khác */
            .card {
                background-color: #f8f9fa; /* Màu nền nhạt */
                border: 1px solid #28a745; /* Viền xanh lá cây */
                border-radius: 8px; /* Bo góc */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Hiệu ứng bóng */
            }

            .card-header {
                background-color: #28a745; /* Xanh lá cây đậm */
                color: #ffffff; /* Chữ trắng */
                font-weight: bold;
            }

            .card-header:first-child {
                border-radius: 8px 8px 0 0; /* Bo góc chỉ ở phần trên */
            }

            .card-body {
                color: #28a745;
            }

            /* Footer */
            .footer {
                background-color: #1e7e34; /* Xanh lá cây tối */
                color: #ffffff; /* Chữ trắng */
                text-align: center;
                padding: 20px;
            }

            .footer a {
                color: #81c784; /* Xanh lá cây nhạt */
                text-decoration: none;
            }

            .footer a:hover {
                color: #28a745; /* Xanh lá cây đậm */
                text-decoration: underline;
            }

        </style>
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
                        <h2><a href="Home"><img src="assets/img/logo3.png" alt="Logo"></a></h2>
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
        <!--offcanvas menu area end-->
        <!-- End Mobile Menu Area -->
        <!-- Start Hero Area -->
        <section class="hero-area">
            <div class="hero-area-full owl-carousel">
                <div class="hero-slider-single" style="background-image: url('assets/img/breadcrumb2.png');">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="hero-slider-single-content">
                                    <h2>Banking <span>Service System</span></h2>
                                    <p>Explore our range of loan options with flexible repayment plans.</p>
                                    <a class="button-1" href="javascript:void(0)">Experience Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="hero-slider-single" style="background-image: url('assets/img/business-process-automation-banking-scaled.jpg');">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="hero-slider-single-content">
                                    <h2>Banking <span>Service System</span></h2>
                                    <p>Looking for a credit card? Let us help you find the best one for your lifestyle</p>
                                    <a class="button-1" href="javascript:void(0)">Experience Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="hero-slider-single" style="background-image: url('assets/img/breadcrumb.png');">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="hero-slider-single-content">
                                    <h2>Banking <span>Service System</span></h2>
                                    <p>We offer competitive interest rates on personal and home loans.</p>
                                    <a class="button-1" href="/Namcombank/login">Experience Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- End Hero Area -->
        <!-- Start banner Area -->
        <section class="banner-area container">
            <div class="row">
                <c:forEach var="image" items="${bannerImages}">
                    <div class="col-lg-3 col-md-6 mb-30" style="padding: 15px;">
                        <div class="banner-item" style="overflow: hidden; display: flex; align-items: center; justify-content: center;">
                            <a href="#">
                                <img src="${image}" alt="img" style="width: 300px; height: 300px; object-fit: cover;">
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>

        </section>
        <!-- End banner Area -->
        <!-- Home Front Section  -->
        <section class="pt-3">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <p class="bank-subtitle mb-1">Namcombank - Banking Services System</p>
                        <h2 class="mb-3 bank-title">Putting "fun" <br> in "funds" <br> since 1969</h2>
                        <p class="bease-subtitle col-9 mb-4 bank-info">
                            We're not your stuffy, suit-and-tie bankers. We're the bank that gets you - the meme lords, the
                            avocado toast enthusiasts, the ones who still think dogecoin has potential.
                        </p>
                        <div class="row">
                            <div class="col-md-6 mb-5">
                                <a href="javascript:void(0)"><button class="btn btn-primary border-0 bank-btn">Register now</button></a>
                            </div>
                            <ul class="list-inline">
                                <li class="list-inline-item bank-phone"> <img src="./assets/img/home-call.png"
                                                                              height="20px" class="zoom-on-hover"> +977 9819102869</li>
                                <li class="list-inline-item"><span class="vertical-divider"></span></li>
                                <li class="list-inline-item zoom-on-hover fa-sm"><a href="http://facebook.com"><i
                                            class="fab fa-facebook fa-lg" id="icon-awesome"></i></a></li>
                                <li class="list-inline-item zoom-on-hover fa-sm"><a href="http://instagram.com"><i
                                            class="fab fa-instagram fa-lg" id="icon-awesome"></i></a></li>
                                <li class="list-inline-item zoom-on-hover fa-sm"><a href="http://twitter.com"><i class="fab fa-twitter fa-lg"
                                                                                                                 id="icon-awesome"></i></a></li>
                                <li class="list-inline-item zoom-on-hover fa-sm"><a href="http://linkedin.com"><i
                                            class="fab fa-linkedin fa-lg" id="icon-awesome"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-7 d-none d-lg-block">
                        <img src="./assets/img/bank.png" class="img-fluid">
                    </div>
                </div>
            </div>
        </section>
        <div class="gap"></div>


        <!-- Our Services -->
        <section id="services">
            <div class="container">
                <div class="row">
                    <div class="col-12 text-center mb-3">
                        <h2 class="font-weight-bold section-title">Our Services</h2>
                    </div>
                </div>
                <div class="row justify-content-center mb-5">
                    <div class="col-12 col-md-8 text-center">
                        <p class="text-center section-subtitle">
                            Tired of banking apps that look like they were designed by a hamster on acid? Ditch the snooze
                            and join the financial fiesta at Sawongam Bank! Where your hard-earned moolah gets more action
                            than a Dogecoin on Elon's Twitter feed.
                        </p>
                    </div>
                </div>
                <div class="row col-12 justify-content-center text-center text-uppercase" id="service-list">
                    <div class="col-7 col-md-2 mb-4">
                        <a href="#"><img src="./assets/img/service-1.png" alt="Home Loan"
                                         class="img-fluid zoom-on-hover text-center"></a>
                        <div class="d-flex justify-content-between">
                            <a href="#" class="no-underline">
                                <p class="mt-3">DREAM <br>Home Loan</p>
                            </a>
                            <a href="#" class="no-underline"> <img src="./assets/img/arrow_right.svg" alt="" height="35px"
                                                                   class="mt-4">
                            </a>
                        </div>
                    </div>
                    <div class="col-7 col-md-2 mb-4">
                        <a href="#"><img src="./assets/img/service-2.png" alt="Auto Loan"
                                         class="img-fluid zoom-on-hover text-center"></a>
                        <div class="d-flex justify-content-between ">
                            <a href="#" class="no-underline">
                                <p class="mt-3">ktm <br>Auto Loan</p>
                            </a>
                            <a href="#" class="no-underline"> <img src="./assets/img/arrow_right.svg" alt="" height="35px"
                                                                   class="mt-4">
                            </a>
                        </div>
                    </div>

                    <div class="col-7 col-md-2 mb-4">
                        <a href="#"><img src="./assets/img/service-3.png" alt="Education Loan"
                                         class="img-fluid zoom-on-hover text-center"></a>
                        <div class="d-flex justify-content-between ">
                            <a href="#" class="no-underline">
                                <p class="mt-3">fyp <br>Education Loan</p>
                            </a>
                            <a href="#" class="no-underline"> <img src="./assets/img/arrow_right.svg" alt="" height="35px"
                                                                   class="mt-4">
                            </a>
                        </div>
                    </div>
                    <div class="col-7 col-md-2 mb-4">
                        <a href="#"><img src="./assets/img/service-4.png" alt="Personal Loan"
                                         class="img-fluid zoom-on-hover text-center"></a>
                        <div class="d-flex justify-content-between ">
                            <a href="#" class="no-underline">
                                <p class="mt-3">ohno <br>Personal Loan</p>
                            </a>
                            <a href="#" class="no-underline"> <img src="./assets/img/arrow_right.svg" alt="" height="35px"
                                                                   class="mt-4">
                            </a>
                        </div>
                    </div>

                    <div class="col-7 col-md-2 mb-4">
                        <a href="#"><img src="./assets/img/service-5.png" alt="SME Loan"
                                         class="img-fluid zoom-on-hover text-center"></a>
                        <div class="d-flex justify-content-between ">
                            <a href="#" class="no-underline">
                                <p class="mt-3">sad <br>SME Loan</p>
                            </a>
                            <a href="#" class="no-underline"> <img src="./assets/img/arrow_right.svg" alt="" height="35px"
                                                                   class="mt-4">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="gap"></div>


    <!-- We the Best -->
    <section id="about">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center best-subtitle">The Broke But Woke Club</div>
                <div class="col-12 text-center mb-5">
                    <h2 class="section-title">We Offer the best</h2>
                </div>
            </div>
            <div class="row justify-content-center mt-3">
                <div class="col-lg-2 text-center mb-3">
                    <img src="./assets/img/register-interest.png" height="99px" width="99px" alt="Interest Rates"
                         class="img-fluid mb-3">
                    <h3 class="best-title">Interest Rates</h3>
                    <p class="best-info">Built Wicket longer admire do barton vanity itself do in it.</p>
                </div>
                <div class="col-lg-2 text-center mb-3">
                    <img src="./assets/img/register-saving.png" height="99px" width="99px" alt="Savings"
                         class="img-fluid mb-3">
                    <h3 class="best-title">Savings</h3>
                    <p class="best-info">Engrossed listening. Park gate sell they west hard for the.</p>
                </div>
                <div class="col-lg-2 text-center mb-3">
                    <img src="./assets/img/register-digital.png" height="95px" width="95px" alt="Digital Services"
                         class="img-fluid mb-3">
                    <h3 class="best-title">Digital Services</h3>
                    <p class="best-info">Barton vanity itself do in it. Preferd to men it engrossed listening. </p>
                </div>
                <div class="col-lg-2 text-center mb-3">
                    <img src="./assets/img/register-atm.png" height="99px" width="99px" alt="Safe Deposit Locker"
                         class="img-fluid mb-3">
                    <h3 class="best-title">Safe Deposit</h3>
                    <p class="best-info">We deliver outsourced aviation services for military customers</p>
                </div>
                <div class="col-lg-2 text-center mb-3">
                    <img src="./assets/img/register-card.png" height="101px" width="101px" alt="Service 5"
                         class="img-fluid mb-3">
                    <h3 class="best-title">Credit/Debit Card</h3>
                    <p class="best-info">We deliver outsourced aviation services for military customers</p>
                </div>
            </div>
        </div>
    </section>
    <div class="gap"></div>


    <!-- Budget Beasts -->
    <section id="beast">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <h2 class="beast-title mb-3">Budget Beasts, Not <br> Budget Bums</h2>
                    <p class="bease-subtitle mb-5">Unleash Your Inner Financial Ninja with Sawongam Bank's Killer Tools
                    </p>
                    <div class="row">
                        <div class="col-md-4 mb-5 text-center">
                            <img src="./assets/img/budget-coin.png" height="58px" width="62px" alt="Interest Rate"
                                 class="img-fluid">
                            <h3 class="image-title beast-info mt-3">Your money grooves with our amazing interest rates.
                            </h3>
                        </div>
                        <div class="col-md-4 mb-5 text-center">
                            <img src="./assets/img/budget-saving.png" height="50px" width="58px" alt="Savings"
                                 class="img-fluid">
                            <h3 class="image-title beast-info mt-3">We make finance so lively, your savings might break
                                into a jig.</h3>
                        </div>
                        <div class="col-md-4 mb-5 text-center">
                            <img src="./assets/img/budget-security.png" height="50px" width="55px" alt="Security"
                                 class="img-fluid">
                            <h3 class="image-title beast-info mt-3">Our security is tighter than your grandma's salsa
                                moves.</h3>
                        </div>
                        <ul class="list-inline">
                            <li class="list-inline-item"><a href="#"><i class="fab fa-facebook fa-lg"
                                                                        id="icon-awesome"></i></a></li>
                            <li class="list-inline-item"><a href="#"><i class="fab fa-instagram fa-lg"
                                                                        id="icon-awesome"></i></a></li>
                            <li class="list-inline-item"><a href="#"><i class="fab fa-twitter fa-lg"
                                                                        id="icon-awesome"></i></a></li>
                            <li class="list-inline-item"><a href="#"><i class="fab fa-linkedin fa-lg"
                                                                        id="icon-awesome"></i></a></li>
                            <li class="list-inline-item"><a href="#"><i class="fab fa-youtube fa-lg"
                                                                        id="icon-awesome"></i></a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6 d-none d-lg-block">
                    <img src="./assets/img/budget-block.png" alt="Image 4" class="img-fluid">
                </div>
            </div>
        </div>
    </section>
    <div class="gap"></div>


    <!-- Result Years -->
    <section>
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-3">
                    <h2 class="font-weight-bold section-title">Our best results <br> for the year</h2>
                </div>
            </div>
            <div class="row justify-content-center mb-5">
                <div class="col-12 col-md-6 text-center">
                    <p class="text-center section-subtitle">
                        We've got all the boring essentials (checking, savings, loans, yawn)
                        but served with a side of meme-tastic names and enough pop
                        culture references to make your inner nerd do a fist pump.
                    </p>
                </div>
            </div>
            <div class="row justify-content-center mt-5">
                <div class="row col-lg-9 text-center">
                    <div class="col-lg-3 text-center mb-4 text-rotate">
                        <h3 class="budget-title text-warning ">57.6 bn</h3>
                        <p class="budget-info">Loan Portfolio</p>
                    </div>
                    <div class="col-lg-3 text-center mb-4">
                        <h3 class="budget-title">0.95%</h3>
                        <p class="budget-info">Classified <br>Loan Portfolio</p>
                    </div>
                    <div class="col-lg-3 text-center mb-4">
                        <h3 class="budget-title">388.5%</h3>
                        <p class="budget-info">Classified <br> Loan Coverage</p>
                    </div>
                    <div class="col-lg-3 text-center mb-4">
                        <h3 class="budget-title">50.4 bn</h3>
                        <p class="budget-info">Deposit</p>
                    </div>
                    <div class="col-lg-3 text-center mb-4">
                        <h3 class="budget-title">6.1 bn</h3>
                        <p class="budget-info">Shareholders <br> Equity</p>
                    </div>
                    <div class="col-lg-3 text-center mb-4">
                        <h3 class="budget-title">18.51%</h3>
                        <p class="budget-info">Capiital <br> Adequacy Ratio</p>
                    </div>
                    <div class="col-lg-3 text-center mb-4">
                        <h3 class="budget-title">8.5 bn</h3>
                        <p class="budget-info">Market <br> Capitalization</p>
                    </div>
                    <div class="col-lg-3 text-center mb-4">
                        <h3 class="budget-title">AAA</h3>
                        <p class="budget-info">Credit Rating</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="gap"></div>


    <!-- Footer -->
    <footer id="contact">
        <div class="container pt-5 pb-3">
            <div class="row">
                <div class="col-lg-3">
                    <h5>About</h5>
                    <p>Namcombank | Banking Services System</p>
                    <ul class="list-inline">
                        <li class="list-inline-item"><a href="http://facebook.com"><i class="fab fa-facebook fa-lg"
                                                                                      id="icon-awesome"></i></a></li>
                        <li class="list-inline-item"><a href="http://instagram.com"><i class="fab fa-instagram fa-lg"
                                                                                       id="icon-awesome"></i></a></li>
                        <li class="list-inline-item"><a href="http://twitter.com"><i class="fab fa-twitter fa-lg"
                                                                                     id="icon-awesome"></i></a></li>
                        <li class="list-inline-item"><a href="http://linkedin.com"><i class="fab fa-linkedin fa-lg"
                                                                                      id="icon-awesome"></i></a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h5>Services</h5>
                    <ul>
                        <li><a href="#">Home Loan</a></li>
                        <li><a href="#">Auto Loan</a></li>
                        <li><a href="#">Personal Loan</a></li>
                        <li><a href="#">Education Loan</a></li>
                        <li><a href="#">SME Loan</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h5>Information</h5>
                    <ul>
                        <li><a href="#">Branches</a></li>
                        <li><a href="#">ATM Locations</a></li>
                        <li><a href="#">EMI Calculator</a></li>
                        <li><a href="#">Service Charges</a></li>
                        <li><a href="#">Financial Reports</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h5>Support</h5>
                    <ul>
                        <li><a href="#">FAQs</a></li>
                        <li><a href="#">Career</a></li>
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Document Verification</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>



    <!-- End Our Latest Product -->

    <!-- Start Deal Product -->
    <!-- Start Deal Product -->

    <!-- Start Product Widget List Area -->

    <!-- End Product Widget List Area -->

    <!-- Start Latest Blog -->


    <!-- End Latest Blog -->

    <!-- Start Instagram Feed -->
    <!-- End Instagram Feed -->

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