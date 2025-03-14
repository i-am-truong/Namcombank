<%--
    Document   : viewNewsDetail
    Created on : Mar 14, 2025, 8:49:51 AM
    Author     : Bernie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Namcombank - News Detail</title>

        <!-- Custom fonts for this template -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <!-- Custom styles for this page -->
        <link href="adminassets/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

        <style>
            .content-container {
                border: 1px solid #ddd;
                padding: 15px;
                margin-bottom: 20px;
                min-height: 450px;
                background-color: #f8f9fc;
                border-radius: 5px;
                overflow-wrap: break-word;
                word-wrap: break-word;
            }

            .news-title {
                font-size: 24px;
                font-weight: bold;
                color: #2e59d9;
                margin-bottom: 15px;
                padding: 10px;
                border-bottom: 1px solid #eaeaea;
            }

            .news-content {
                padding: 15px;
                line-height: 1.6;
            }

            .news-meta {
                font-size: 14px;
                color: #666;
                margin-bottom: 20px;
                padding-left: 10px;
            }

            /* Responsive image handling */
            .news-content img {
                max-width: 100%;
                height: auto !important;
                display: block;
                margin: 10px auto;
            }

            /* Handle tables that might contain images */
            .news-content table {
                max-width: 100%;
                width: auto !important;
                height: auto !important;
                overflow-x: auto;
                display: block;
            }

            /* Fix for iframe content */
            .news-content iframe {
                max-width: 100%;
                width: 100%;
                height: auto;
                min-height: 315px;
            }

            /* Ensure figures and other containers respect boundaries */
            .news-content figure,
            .news-content div,
            .news-content p {
                max-width: 100%;
                overflow-wrap: break-word;
                word-wrap: break-word;
            }
        </style>

        <script>
            // Fix images after the page loads
            window.addEventListener('DOMContentLoaded', function() {
                // Process all images in the news content
                const images = document.querySelectorAll('.news-content img');
                images.forEach(function(img) {
                    // Ensure image doesn't exceed container width
                    img.style.maxWidth = '100%';
                    img.style.height = 'auto';

                    // Remove any fixed width/height attributes
                    img.removeAttribute('width');
                    img.removeAttribute('height');

                    // Fix parent elements if needed
                    if (img.parentElement) {
                        img.parentElement.style.maxWidth = '100%';
                        img.parentElement.style.height = 'auto';
                    }
                });

                // Process tables that might contain images or have fixed widths
                const tables = document.querySelectorAll('.news-content table');
                tables.forEach(function(table) {
                    table.style.maxWidth = '100%';
                    table.removeAttribute('width');

                    // Make table scrollable if it's too wide
                    if (table.offsetWidth > table.parentElement.offsetWidth) {
                        const wrapper = document.createElement('div');
                        wrapper.style.overflowX = 'auto';
                        wrapper.style.width = '100%';
                        table.parentNode.insertBefore(wrapper, table);
                        wrapper.appendChild(table);
                    }
                });
            });
        </script>
    </head>
    <body id="page-top">
        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <%@include file="../homepage/sidebar_admin.jsp" %>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <%@include file="../homepage/header_admin.jsp" %>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">
                        <div class="container" style="background-color:whitesmoke;height:auto;overflow: auto;">
                            <div class="row">
                                <div class="col-6">
                                    <h3 style="padding-left:40px; margin-top:20px;white-space: nowrap">News Detail</h3>
                                </div>
                                <div class="col-6">
                                    <a href="newsListStaff" class="btn btn-info" style="float:right;margin-top:20px">Back to News</a>
                                </div>
                            </div>
                            <div id="box" class="row" style="min-width: 500px;max-width: 1060px;position: relative;margin-left:40px;border:solid;height:auto;background-color:white;min-height: 650px;border-radius: 7px;overflow: auto;">
                                <div class="col-12">
                                    <div class="news-title">${news.title}</div>
                                    <div class="news-meta">
                                        Posted by: ${not empty news.authorName ? news.authorName : 'Unknown'} |
                                        Date:
                                        <%
                                            Date newsDate = ((model.News) request.getAttribute("news")).getUpdateDate();
                                            if (newsDate != null) {
                                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
                                                out.print(sdf.format(newsDate));
                                            } else {
                                                out.print("Unknown Date");
                                            }
                                        %>
                                    </div>
                                    <div class="content-container">
                                        <div class="news-content">
                                            ${news.body}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.container-fluid -->
                </div>
                <!-- End of Main Content -->
            </div>
            <!-- End of Content Wrapper -->
        </div>
        <!-- End of Page Wrapper -->

        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <!-- Custom scripts for all pages-->
        <script src="adminassets/js/sb-admin-2.min.js"></script>
    </body>
</html>
