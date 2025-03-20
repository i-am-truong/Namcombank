<%--
    Document   : newsListStaff
    Created on : 13/06/2024, 2:50:08 PM
    Author     : ADMIN
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

        <title>Namcombank</title>

        <!-- Custom fonts for this template -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">

        <!-- Custom styles for this page -->
        <link href="adminassets/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

        <script src="${pageContext.request.contextPath}/assets/js/jquery-3.5.1.min.js" type="text/javascript"></script>

        <script type="text/javascript">
            function deleteNews(newsId) {
                var result = confirm("Confirm delete?");
                var nId = newsId;
                if (result) {
                    console.log("News Id: " + nId);
                    $.ajax({
                        type: 'POST',
                        data: {nId: nId},
                        url: 'newsListStaff',
                        success: (result) => {
                            showAlert('Delete successfully', 3000);
                            setTimeout(() => {
                                window.location.reload();
                            }, 1000);
                        },
                        error: function () {
                            showError('Delete fail something went wrong', 3000);
                        }
                    });
                }
            }

            function showAlert(message, duration) {
                // Tạo phần tử alert mới
                let alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-success';
                alertDiv.role = 'alert';
                alertDiv.innerHTML = message;
                alertDiv.style = 'margin-top: 50px;z-index: 9999; position: fixed; top: 0; right: 0;width: 300px;height:50px';
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
                alertDiv.style = 'margin-top: 50px;z-index: 9999; position: fixed; top: 0; right: 0;width: 300px;height:50px';
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
    <body id="page-top">
        <div id="notifications">
        </div>
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

                            <!-- News Title and Create Button Row -->
                            <div class="row mb-3">
                                <div class="col-8">
                                    <h3 style="padding-left:40px; margin-top:20px;white-space: nowrap">News</h3>
                                </div>
                                <div class="col-4 text-right">
                                    <c:if test="${sessionScope.roleId != null}">
                                        <a href="addNews" class="btn btn-info" style="margin-top:20px">
                                            <i class="fas fa-plus mr-1"></i> Create News
                                        </a>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Search and Filter Block -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="card shadow-sm">
                                        <div class="card-header bg-light py-2">
                                            <h6 class="m-0 font-weight-bold text-primary">Search & Filter</h6>
                                        </div>
                                        <div class="card-body py-3">
                                            <form id="searchForm" class="row align-items-center">
                                                <!-- Title search -->
                                                <div class="col-md-4 mb-2 mb-md-0">
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text bg-white">
                                                                <i class="fas fa-heading fa-sm text-gray-400"></i>
                                                            </span>
                                                        </div>
                                                        <input type="text" class="form-control border-left-0" name="searchTitle"
                                                               placeholder="Search by title" value="${not empty searchTitle ? searchTitle : ''}">
                                                    </div>
                                                </div>
                                                <!-- Author search -->
                                                <div class="col-md-3 mb-2 mb-md-0">
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text bg-white">
                                                                <i class="fas fa-user fa-sm text-gray-400"></i>
                                                            </span>
                                                        </div>
                                                        <input type="text" class="form-control border-left-0" name="searchAuthor"
                                                               placeholder="Search by author" value="${not empty searchAuthor ? searchAuthor : ''}">
                                                    </div>
                                                </div>
                                                <!-- Sort filter -->
                                                <div class="col-md-3 mb-2 mb-md-0">
                                                    <select class="form-control" name="sort" id="sortOrder">
                                                        <option value="" ${empty sortOrder ? 'selected' : ''}>Default sort</option>
                                                        <option value="newest" ${sortOrder eq 'newest' ? 'selected' : ''}>Newest first</option>
                                                        <option value="oldest" ${sortOrder eq 'oldest' ? 'selected' : ''}>Oldest first</option>
                                                    </select>
                                                </div>
                                                <!-- Buttons -->
                                                <div class="col-md-2 d-flex">
                                                    <button type="submit" class="btn btn-primary btn-sm mr-1 flex-fill">
                                                        <i class="fas fa-search"></i> Search
                                                    </button>
                                                    <button type="button" id="clearBtn" class="btn btn-secondary btn-sm flex-fill">
                                                        <i class="fas fa-times"></i> Clear
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- JavaScript for Search and Clear functionality -->
                            <script>
                                document.getElementById('searchForm').onsubmit = function(e) {
                                    e.preventDefault();
                                    let currentUrl = new URL(window.location.href);

                                    // Get form values
                                    let searchTitle = this.searchTitle.value;
                                    let searchAuthor = this.searchAuthor.value;
                                    let sort = this.sort.value;

                                    // Update URL parameters
                                    if (searchTitle) currentUrl.searchParams.set('searchTitle', searchTitle);
                                    else currentUrl.searchParams.delete('searchTitle');

                                    if (searchAuthor) currentUrl.searchParams.set('searchAuthor', searchAuthor);
                                    else currentUrl.searchParams.delete('searchAuthor');

                                    if (sort) currentUrl.searchParams.set('sort', sort);
                                    else currentUrl.searchParams.delete('sort');

                                    // Reset to page 1 when searching
                                    currentUrl.searchParams.set('page', '1');
                                    // Remove any old 'index' parameter if it exists
                                    currentUrl.searchParams.delete('index');

                                    // Preserve type and view parameters if they exist
                                    let type = currentUrl.searchParams.get('type');
                                    let view = currentUrl.searchParams.get('view');
                                    if (type) currentUrl.searchParams.set('type', type);
                                    if (view) currentUrl.searchParams.set('view', view);

                                    window.location.href = currentUrl.toString();
                                };

                                // Add clear button functionality
                                document.getElementById('clearBtn').onclick = function() {
                                    let currentUrl = new URL(window.location.href);

                                    // Remove search and sort parameters
                                    currentUrl.searchParams.delete('searchTitle');
                                    currentUrl.searchParams.delete('searchAuthor');
                                    currentUrl.searchParams.delete('sort');

                                    // Reset to page 1
                                    currentUrl.searchParams.set('page', '1');
                                    // Remove any old 'index' parameter if it exists
                                    currentUrl.searchParams.delete('index');

                                    // Preserve type and view parameters if they exist
                                    let type = currentUrl.searchParams.get('type');
                                    let view = currentUrl.searchParams.get('view');
                                    if (type) currentUrl.searchParams.set('type', type);
                                    if (view) currentUrl.searchParams.set('view', view);

                                    window.location.href = currentUrl.toString();
                                };
                            </script>

                            <!-- Tabs for News Types -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <ul class="nav nav-tabs">
                                        <!-- Tab for All News - Adjusted for Admin role -->
                                        <c:choose>
                                            <c:when test="${sessionScope.roleId == 1}">
                                                <!-- For Admin: simpler tab navigation without view parameter -->
                                                <li class="nav-item">
                                                    <a class="nav-link ${empty param.type || param.type eq 'News' ? 'active' : ''}"
                                                       href="newsListStaff?type=News">All News</a>
                                                </li>
                                                <!-- Tab for Waiting News (Admin only) -->
                                                <li class="nav-item">
                                                    <a class="nav-link ${param.type eq 'WaitingNews' ? 'active' : ''}"
                                                       href="newsListStaff?type=WaitingNews">Waiting News</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- For other roles -->
                                                <li class="nav-item">
                                                    <a class="nav-link ${param.view eq 'allNews' || param.view == null ? 'active' : ''}"
                                                       href="newsListStaff?type=News&view=allNews">All News</a>
                                                </li>

                                                <!-- Tab for Role News -->
                                                <li class="nav-item">
                                                    <a class="nav-link ${param.view eq 'roleNews' ? 'active' : ''}"
                                                       href="newsListStaff?type=News&view=roleNews">
                                                       ${sessionScope.roleId == 2 ? 'Staff' : sessionScope.roleId == 3 ? 'Head Of Staff' : 'Accountant'} News
                                                    </a>
                                                </li>

                                                <!-- Tab for My News -->
                                                <li class="nav-item">
                                                    <a class="nav-link ${param.view eq 'myNews' ? 'active' : ''}"
                                                       href="newsListStaff?type=News&view=myNews">My News</a>
                                                </li>

                                                <!-- Tab for Pending News -->
                                                <li class="nav-item">
                                                    <a class="nav-link ${param.view eq 'pendingNews' ? 'active' : ''}"
                                                       href="newsListStaff?type=News&view=pendingNews">My Pending News</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                            </div>

                            <!-- Page Size and Results Count -->
                            <c:if test="${not empty n}">
                                <div class="d-flex justify-content-between align-items-center mb-3" style="padding-left: 40px; padding-right: 40px;">
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

                            <div id="box" class="row" style="min-width: 500px;max-width: 1060px;position: relative;margin-left:40px;border:solid;height:auto;background-color:white;min-height: 350px;border-radius: 7px;overflow: auto;">
                                <c:if test="${empty n}">
                                    <div class="col-12 text-center p-5">
                                        <h4>No ${param.type eq 'WaitingNews' ? 'waiting' : ''}
                                           ${param.view eq 'myNews' ? 'personal' :
                                             param.view eq 'pendingNews' ? 'pending' :
                                             param.view eq 'roleNews' ? 'approved' : ''} news available.</h4>
                                        <p>
                                            ${param.type eq 'WaitingNews' ? 'There are currently no news awaiting approval.' :
                                              param.view eq 'myNews' ? 'You haven\'t created any news yet.' :
                                              param.view eq 'pendingNews' ? 'You don\'t have any news waiting for approval.' :
                                              param.view eq 'roleNews' ? 'No approved news from your role group. News must be approved by an admin before appearing here.' :
                                              'No published news found.'}
                                        </p>
                                    </div>
                                </c:if>

                                <c:forEach var="news" items="${n}">
                                    <table style="max-height:124px; min-height:119.4px;width:1049.7px;">
                                        <tr onmouseover="this.style.backgroundColor ='#B0E0E6'" onmouseout="this.style.backgroundColor='transparent'">
                                            <th style="width: 85%;">
                                                <div style="min-width: 500px;max-width: 916px;height:109.4px;padding-left:20px;padding-top:13px; white-space: nowrap;">
                                                    <h3 style="font-size: 20px;display: inline-block; vertical-align: top;margin-top: 17px;text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
                                                        <a href="ViewNewsDetail?nId=${news.nId}">${news.title}</a>
                                                    </h3>

                                                    <!-- Chỉ hiển thị nút Delete nếu là Admin hoặc chính người tạo -->
                                                    <c:if test="${sessionScope.roleId == 1 || (sessionScope.staffId == news.staffId)}">
                                                        <button id="deletebtn" onclick="deleteNews(${news.nId})" style="float:right; border:none; width:103px; height:70px; appearance: none; background-color: inherit; display: flex; justify-content: center; align-items: center;">
                                                            <img src="https://drive.google.com/thumbnail?id=1jMT2nYYaUtyf7OQbRk3t_6u8U5bnL8r2" style="width:103px; height:70px; display:inline-block;" class="img-rounded" alt="Load img fail">
                                                        </button>
                                                    </c:if>

                                                    <!-- Chỉ hiển thị nút Edit nếu là Admin hoặc chính người tạo -->
                                                    <c:if test="${sessionScope.roleId == 1 || (sessionScope.staffId == news.staffId)}">
                                                        <a href="updateNews?nId=${news.nId}" class="btn btn-info editNewsbtn" style="float:right; display:inline-block; vertical-align:top; margin-top:15px;">Edit</a>
                                                    </c:if>

                                                    <p style="margin-top: -2px;">
                                                        Posted:
                                                        <%
                                                            Date newsDate = ((model.News) pageContext.getAttribute("news")).getUpdateDate();
                                                            if (newsDate != null) {
                                                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
                                                                out.print(sdf.format(newsDate));
                                                            } else {
                                                                out.print("Unknown Date");
                                                            }
                                                        %>
                                                        <span style="margin-left: 20px;">By: ${not empty news.authorName ? news.authorName : 'Unknown'}</span>
                                                    </p>
                                                </div>
                                            </th>
                                        </tr>
                                    </table>
                                </c:forEach>
                            </div>

                            <!-- Dynamic Pagination - Replace old pagination -->
                            <c:if test="${not empty n}">
                                <div class="pagination-container my-4">
                                    <%@include file="../homepage/pagination.jsp" %>
                                </div>
                            </c:if>
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
        <!-- Page level plugins -->
        <script src="adminassets/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="adminassets/vendor/datatables/dataTables.bootstrap4.min.js"></script>
        <!-- Page level custom scripts -->
        <script src="adminassets/js/demo/datatables-demo.js"></script>

        <!-- Add JavaScript functions for approveNews and changePageSize -->
        <script>
            function approveNews(newsId) {
                var result = confirm("Approve this news?");
                if (result) {
                    $.ajax({
                        type: 'POST',
                        url: 'approveNews', // Create a new servlet for this
                        data: {nId: newsId},
                        success: function() {
                            showAlert('News approved successfully', 3000);
                            setTimeout(() => {
                                window.location.reload();
                            }, 1000);
                        },
                        error: function() {
                            showError('Failed to approve news', 3000);
                        }
                    });
                }
            }

            function changePageSize() {
                // Get the current URL
                const url = new URL(window.location.href);
                // Get the selected page size value
                const pageSize = document.getElementById('pageSize').value;
                // Set the page-size parameter
                url.searchParams.set('page-size', pageSize);
                // Reset to page 1 when changing page size
                url.searchParams.set('page', '1');
                // Remove old index parameter if it exists
                url.searchParams.delete('index');
                // Navigate to the new URL
                window.location.href = url.toString();
            }
        </script>
    </body>
</html>
