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
<html class="no-js" lang="en">
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

        <!-- Header -->
        <header class="header">
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
                <!-- Replace the default "row" with our custom "row news-container" -->
                <div class="row news-container">
                    <!-- Main News Column - Use our custom class -->
                    <div class="news-main-column">
                        <!-- Combined Filter Section -->
                        <div class="combined-filter mb-4 p-3" style="background-color: #f9f9f9; border-radius: 5px; border: 1px solid #e9e9e9;">
                            <form id="newsFilterForm" action="newsList" method="get" class="row align-items-center">
                                <!-- Search by Title -->
                                <div class="col-md-3">
                                    <div class="form-group mb-2 mb-md-0">
                                        <label for="search" class="small mb-1">Title</label>
                                        <input type="text" class="form-control form-control-sm" id="search" name="search"
                                               placeholder="Search by title" value="${not empty searchQuery ? searchQuery : ''}">
                                    </div>
                                </div>

                                <!-- Search by Author -->
                                <div class="col-md-3">
                                    <div class="form-group mb-2 mb-md-0">
                                        <label for="author" class="small mb-1">Author</label>
                                        <input type="text" class="form-control form-control-sm" id="author" name="author"
                                               placeholder="Search by author" value="${not empty authorQuery ? authorQuery : ''}">
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
                                        <button type="submit" class="btn btn-primary btn-sm me-2" style="height: 38px; width: 75%;">
                                            <i class="fas fa-search mr-1"></i> Search
                                        </button>
                                        <button type="button" id="clearSearchBtn" class="btn btn-secondary btn-sm" style="height: 38px; width: 25%;" title="Clear filters">
                                            <i class="fas fa-times"></i>
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

                        <!-- Page Size and Results Count -->
                        <c:if test="${not empty n}">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <span class="text-muted">Found ${count} news items</span>
                                </div>
                                <div class="d-flex align-items-center">
                                    <label for="pageSize" class="text-nowrap mr-2 mb-0">Items per page:</label>
                                    <select id="pageSize" class="form-control form-control-sm" style="width: auto;" onchange="changePageSize()">
                                        <c:forEach items="${pagination.listPageSize}" var="size">
                                            <option value="${size}" ${pagination.pageSize eq size ? 'selected' : ''}>${size}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </c:if>

                        <!-- News List Content -->
                        <div class="news-list">
                            <c:forEach var="news" items="${n}">
                                <div class="news-item mb-4">
                                    <div class="card">
                                        <div class="row no-gutters">
                                            <!-- Image Column -->
                                            <div class="col-md-4">
                                                <a href="newsDetail?id=${news.nId}">
                                                    <img src="${news.thumbnail}" class="card-img" alt="News thumbnail"
                                                         style="height: 100%; object-fit: cover; border-radius: 4px 0 0 4px;">
                                                </a>
                                            </div>
                                            <!-- Content Column -->
                                            <div class="col-md-8">
                                                <div class="card-body">
                                                    <h5 class="card-title">
                                                        <a href="newsDetail?id=${news.nId}" class="text-dark text-decoration-none">
                                                            ${news.title}
                                                        </a>
                                                    </h5>
                                                    <p class="card-text">
                                                        <small class="text-muted">
                                                            <i class="fas fa-user mr-1"></i> ${not empty news.authorName ? news.authorName : 'Unknown'} |
                                                            <i class="fas fa-calendar-alt mr-1"></i>
                                                            <%
                                                                Date newsDate = ((model.News)pageContext.getAttribute("news")).getUpdateDate();
                                                                if(newsDate != null) {
                                                                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
                                                                    out.print(sdf.format(newsDate));
                                                                } else {
                                                                    out.print("Unknown Date");
                                                                }
                                                            %>
                                                        </small>
                                                    </p>
                                                    <p class="card-text text-truncate mb-2">
                                                        ${news.description.length() > 150 ? news.description.substring(0, 150).concat('...') : news.description}
                                                    </p>
                                                    <a href="newsDetail?id=${news.nId}" class="btn btn-sm btn-outline-primary">Read More</a>
                                                </div>
                                            </div>
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

                        <!-- Dynamic Pagination - Only show if we have results -->
                        <c:if test="${not empty n}">
                            <div class="pagination-container my-4">
                                <%@include file="../homepage/pagination.jsp" %>
                            </div>
                        </c:if>
                    </div>

                    <!-- Sidebar - Recent News - Use our custom class -->
                    <div class="news-sidebar-column">
                        <div class="sidebar-widgets sticky-sidebar">
                            <h4 class="title">Recent News</h4>
                            <ul class="recent-post">
                                <c:forEach items="${recentNews}" var="recent">
                                    <li>
                                        <div class="recent-news-item" style="display: flex; margin-bottom: 20px;">
                                            <!-- Thumbnail on the left -->
                                            <div class="recent-news-thumb" style="flex: 0 0 100px; margin-right: 15px;">
                                                <a href="newsDetail?id=${recent.nId}">
                                                    <img src="${recent.thumbnail}" alt="thumbnail"
                                                         style="width: 100px; height: 75px; object-fit: cover; border-radius: 4px;">
                                                </a>
                                            </div>
                                            <!-- Content on the right -->
                                            <div class="recent-news-content" style="flex: 1;">
                                                <!-- Title at the top -->
                                                <h5 style="margin: 0 0 8px; font-size: 15px; font-weight: 600; line-height: 1.3;">
                                                    <a href="newsDetail?id=${recent.nId}" style="color: #333; text-decoration: none;">
                                                        ${recent.title}
                                                    </a>
                                                </h5>
                                                <!-- Author and date at the bottom -->
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
            document.addEventListener('DOMContentLoaded', function() {
                document.getElementById('clearSearchBtn').addEventListener('click', function() {
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
