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

            $(document).ready(function () {
                // Document ready handler
            });
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

                            <div class="row">
                                <div class="col-3">
                                    <h3 style="padding-left:40px; margin-top:20px;white-space: nowrap">News</h3>
                                </div>
                                <div class="col-6">
                                    <!-- Thêm dropdown cho filter sort by date -->
                                    <div class="form-group" style="margin-top:20px;">
                                        <select class="form-control" id="sortOrder" onchange="applySortFilter()">
                                            <option value="" ${empty sortOrder ? 'selected' : ''}>Default sort</option>
                                            <option value="newest" ${sortOrder eq 'newest' ? 'selected' : ''}>Newest first</option>
                                            <option value="oldest" ${sortOrder eq 'oldest' ? 'selected' : ''}>Oldest first</option>
                                        </select>
                                    </div>
                                    <script>
                                        function applySortFilter() {
                                            const sortValue = document.getElementById('sortOrder').value;
                                            // Lấy URL hiện tại
                                            let currentUrl = new URL(window.location.href);

                                            // Xóa param sort cũ nếu có
                                            currentUrl.searchParams.delete('sort');

                                            // Thêm param sort mới nếu người dùng chọn giá trị
                                            if (sortValue) {
                                                currentUrl.searchParams.set('sort', sortValue);
                                            }

                                            // Chuyển đến URL mới
                                            window.location.href = currentUrl.toString();
                                        }
                                    </script>
                                </div>
                                <div class="col-3">
                                    <c:if test="${sessionScope.roleId != null}">
                                        <a href="addNews" class="btn btn-info" style="float:right;margin-top:20px">Create News</a>
                                    </c:if>
                                </div>
                            </div>

                            <div class="row" style="margin-top:50px;margin-left:50px;margin-bottom:20px">
                                <!-- Tab for News - Adjusted for Admin role -->
                                <div class="col-3">
                                    <c:choose>
                                        <c:when test="${sessionScope.roleId == 1}">
                                            <!-- For Admin: simpler tab navigation without view parameter -->
                                            <a class="btn ${empty param.type || param.type eq 'News' ? 'btn-primary' : 'btn-link'}"
                                               style="height:20px;color:${empty param.type || param.type eq 'News' ? 'white' : 'royalblue'};width:160px;font-size:18px;height: 36px"
                                               href="newsListStaff?type=News">All News</a>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- For other roles: keep the view parameter -->
                                            <a class="btn ${param.view eq 'allNews' || param.view == null ? 'btn-primary' : 'btn-link'}"
                                               style="height:20px;color:${param.view eq 'allNews' || param.view == null ? 'white' : 'royalblue'};width:160px;font-size:18px;height: 36px"
                                               href="newsListStaff?type=News&view=allNews">All News</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Tab for Role News (for all roles except Admin) -->
                                <c:if test="${sessionScope.roleId != 1}">
                                    <div class="col-3">
                                        <a class="btn ${param.view eq 'roleNews' ? 'btn-primary' : 'btn-link'}"
                                           style="height:20px;color:${param.view eq 'roleNews' ? 'white' : 'royalblue'};width:160px;font-size:14px;height: 36px"
                                           href="newsListStaff?type=News&view=roleNews">${sessionScope.roleId == 2 ? 'Staff' : sessionScope.roleId == 3 ? 'Head Of Staff' : 'Accountant'} News</a>
                                    </div>
                                </c:if>

                                <!-- Tab for My News (for all roles except Admin) -->
                                <c:if test="${sessionScope.roleId != 1}">
                                    <div class="col-3">
                                        <a class="btn ${param.view eq 'myNews' ? 'btn-primary' : 'btn-link'}"
                                           style="height:20px;color:${param.view eq 'myNews' ? 'white' : 'royalblue'};width:160px;font-size:18px;height: 36px"
                                           href="newsListStaff?type=News&view=myNews">My News</a>
                                    </div>

                                    <!-- Tab for Pending News (for all roles except Admin) -->
                                    <div class="col-3">
                                        <a class="btn ${param.view eq 'pendingNews' ? 'btn-primary' : 'btn-link'}"
                                           style="height:20px;color:${param.view eq 'pendingNews' ? 'white' : 'royalblue'};width:160px;font-size:16px;height: 36px"
                                           href="newsListStaff?type=News&view=pendingNews">My Pending News</a>
                                    </div>
                                </c:if>



                                <!-- Tab for Waiting News (Admin only) -->
                                <c:if test="${sessionScope.roleId == 1}">
                                    <div class="col-3">
                                        <a class="btn ${param.type eq 'WaitingNews' ? 'btn-primary' : 'btn-link'}"
                                           style="height:20px;color:${param.type eq 'WaitingNews' ? 'white' : 'royalblue'};width:160px;font-size:18px;height: 36px"
                                           href="newsListStaff?type=WaitingNews">Waiting News</a>
                                    </div>
                                </c:if>
                            </div>

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

                            <!-- Pagination -->
                            <div aria-label="Page navigation example" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <c:forEach begin="1" end="${pages}" var="i">
                                        <li class="page-item">
                                            <c:choose>
                                                <c:when test="${sessionScope.roleId == 1}">
                                                    <!-- For Admin: no view parameter in pagination -->
                                                    <a class="page-link" href="newsListStaff?index=${i}&type=${param.type}${not empty param.sort ? '&sort='.concat(param.sort) : ''}">${i}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- For other roles: include view parameter -->
                                                    <a class="page-link" href="newsListStaff?index=${i}&type=${param.type}&view=${param.view}${not empty param.sort ? '&sort='.concat(param.sort) : ''}">${i}</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:forEach>
                                </ul>
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
        <!-- Page level plugins -->
        <script src="adminassets/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="adminassets/vendor/datatables/dataTables.bootstrap4.min.js"></script>
        <!-- Page level custom scripts -->
        <script src="adminassets/js/demo/datatables-demo.js"></script>
    </body>
</html>
