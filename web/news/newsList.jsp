<%--
    Document   : newsList
    Created on : 25/05/2024, 4:26:04 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html  class="no-js" lang="en">
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

        <!-- Start BreadCrumb Area -->
        <div class="breadcrumb-area pt-100 pb-100" style="background-image: url('assets/img/breadcrumb.jpg');">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb-content">
                            <h2>News</h2>
                            <ul>
                                <li><a>Home</a></li>
                                <li class="active">News</li>
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
                        <!-- Combined Filter Section -->
                        <div class="combined-filter mb-4 p-3" style="background-color: #f9f9f9; border-radius: 5px; border: 1px solid #e9e9e9;">
                            <form id="newsFilterForm" action="newsList" method="get" class="row align-items-center">
                                <!-- Search by Title -->
                                <div class="col-md-3">
                                    <div class="form-group mb-2 mb-md-0">
                                        <label for="search" class="small mb-1">Title</label>
                                        <input type="text" class="form-control form-control-sm" id="search" name="search"
                                               placeholder="Search by title" value="${param.search}">
                                    </div>
                                </div>

                                <!-- Search by Author -->
                                <div class="col-md-3">
                                    <div class="form-group mb-2 mb-md-0">
                                        <label for="author" class="small mb-1">Author</label>
                                        <input type="text" class="form-control form-control-sm" id="author" name="author"
                                               placeholder="Search by author" value="${param.author}">
                                    </div>
                                </div>

                                <!-- Sort Order -->
                                <div class="col-md-3">
                                    <div class="form-group mb-2 mb-md-0">
                                        <label for="sortOrderFilter" class="small mb-1">Sort by</label>
                                        <select id="sortOrderFilter" name="sort" class="form-control form-control-sm">
                                            <option value="" ${empty param.sort ? 'selected' : ''}>Default order</option>
                                            <option value="newest" ${param.sort eq 'newest' ? 'selected' : ''}>Newest first</option>
                                            <option value="oldest" ${param.sort eq 'oldest' ? 'selected' : ''}>Oldest first</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Search Button -->
                                <div class="col-md-3">
                                    <div class="form-group mb-0 d-flex align-items-end h-100">
                                        <button type="submit" class="btn btn-primary btn-sm w-100" style="height: 38px;">
                                            <i class="fas fa-search mr-1"></i> Search
                                        </button>
                                    </div>
                                </div>

                                <!-- Hidden field to track that we're using combined search -->
                                <input type="hidden" name="searchType" value="combined">
                            </form>
                        </div>

                        <!-- No Results Message - Only show when search was performed and no results found -->
                        <c:if test="${(not empty param.search || not empty param.author) && empty n}">
                            <div class="alert alert-warning py-2 mb-4" style="font-size: 0.9rem;">
                                <i class="fas fa-exclamation-triangle mr-2"></i>
                                No news found matching your search criteria. Please try different keywords.
                            </div>
                        </c:if>

                        <div class="row">
                            <!-- Single -->
                            <c:forEach var="news" items="${n}">
                                <div class="col-md-6 mb-30">
                                    <div class="blog-item">
                                        <div class="thumnail">
                                            <a  href="newsDetail?id=${news.nId}"><img style="width: 416px;height: 260px;display: block;margin: 0 auto;" src="${news.thumbnail}" alt="blog"></a>
                                        </div>
                                        <div class="content">
                                            <ul class="auth">
                                                <li><a href="#">${not empty news.authorName ? news.authorName : 'Unknown'}</a></li>
                                                <li><a href="#">
                                                    <%
                                                        Date newsDate = ((model.News)pageContext.getAttribute("news")).getUpdateDate();
                                                        if(newsDate != null) {
                                                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
                                                            out.print(sdf.format(newsDate));
                                                        } else {
                                                            out.print("Unknown Date");
                                                        }
                                                    %>
                                                </a></li>
                                            </ul>
                                            <h2><a href="newsDetail?id=${news.nId}">${news.title} </a></h2>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- If no results and no search criteria -->
                        <c:if test="${empty n && empty param.search && empty param.author}">
                            <div class="text-center py-5">
                                <h4 class="text-muted">No news available at this time</h4>
                                <p class="text-muted">Please check back later for updates.</p>
                            </div>
                        </c:if>

                        <!-- Pagination - Only show if we have results -->
                        <c:if test="${not empty n}">
                            <div class="row">
                                <div class="col-12 mb-30">
                                    <div class="page-pagination text-center">
                                        <ul>
                                            <c:forEach begin="1" end = "${pages}" var = "i">
                                                <li>
                                                    <a href="newsList?index=${i}${not empty param.search ? '&search='.concat(param.search) : ''}${not empty param.author ? '&author='.concat(param.author) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}&searchType=combined">${i}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Siderbar -->
                    <div class="col-lg-4">
                        <!-- Recent News Section (remove old search forms) -->
                        <div class="sidebar-widgets">
                            <h4 class="title">Recent News</h4>
                            <ul class="recent-post">
                                <c:forEach items="${recentNews}" var="recent">
                                    <li>
                                        <div class="recent-news-item" style="display: flex; margin-bottom: 20px;">
                                            <!-- Ảnh bên trái -->
                                            <div class="recent-news-thumb" style="flex: 0 0 100px; margin-right: 15px;">
                                                <a href="newsDetail?id=${recent.nId}">
                                                    <img src="${recent.thumbnail}" alt="thumbnail"
                                                         style="width: 100px; height: 75px; object-fit: cover; border-radius: 4px;">
                                                </a>
                                            </div>
                                            <!-- Nội dung bên phải -->
                                            <div class="recent-news-content" style="flex: 1;">
                                                <!-- Tiêu đề ở phía trên -->
                                                <h5 style="margin: 0 0 8px; font-size: 15px; font-weight: 600; line-height: 1.3;">
                                                    <a href="newsDetail?id=${recent.nId}" style="color: #333; text-decoration: none;">
                                                        ${recent.title}
                                                    </a>
                                                </h5>
                                                <!-- Tên tác giả và thời gian ở phía dưới -->
                                                <div class="meta" style="font-size: 12px; color: #777;">
                                                    <span style="margin-right: 10px;">
                                                        <i class="fas fa-user" style="margin-right: 3px;"></i>
                                                        ${not empty recent.authorName ? recent.authorName : 'Unknown'}
                                                    </span>
                                                    <span>
                                                        <i class="fas fa-calendar-alt" style="margin-right: 3px;"></i>
                                                        <%
                                                            Date recentDate = ((model.News)pageContext.getAttribute("recent")).getUpdateDate();
                                                            if(recentDate != null) {
                                                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
                                                                out.print(sdf.format(recentDate));
                                                            } else {
                                                                out.print("Unknown Date");
                                                            }
                                                        %>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                                <c:if test="${empty recentNews}">
                                    <li style="padding: 15px 0; text-align: center; color: #777;">No recent news available</li>
                                </c:if>
                            </ul>
                        </div>

                        <!-- Single -->
                        <!-- ...existing code... -->
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