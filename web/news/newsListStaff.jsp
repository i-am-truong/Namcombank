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
    function deleteNews(newsId){
                    var result =  confirm("Confirm delete?");
                    var nId = newsId;
        if (result) {
         console.log("News Id: "+ nId);
                    $.ajax({
    type: 'POST',
    data: {nId:nId},
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
            alertDiv.style = 'margin-top: 50px;z-index: 9999; position: fixed; top: 0; right: 0;width: 300px;height:50px'
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
             alertDiv.style = 'margin-top: 50px;z-index: 9999; position: fixed; top: 0; right: 0;width: 300px;height:50px'
            let wrapper = document.getElementById('notifications');
            // Thêm phần tử alert vào body hoặc một container cụ thể
            wrapper.appendChild(alertDiv);

            // Tự động ẩn phần tử alert sau thời gian đã định
            setTimeout(() => {
                alertDiv.remove();
            }, duration);
        }
    $(document).ready(function(){

            });
        </script>
    </head>
    <body id="page-top">
        <div  id="notifications">
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
                                <div class="col-9">

                                    <a href="addNews" class="btn btn-info" style="float:right;margin-top:20px" >Create News</a>

                                </div>
                            </div>

                            <div class="row" style="margin-top:50px;margin-left:50px;margin-bottom:20px">
    <div class="col-3">
        <a class="btn ${param.type eq 'News' || param.type == null ? 'btn-primary' : 'btn-link'}"
           style="height:20px;color:${param.type eq 'News' || param.type == null ? 'white' : 'royalblue'};width:160px;font-size:18px;height: 36px"
           href="newsListStaff?type=News">News</a>
    </div>

    <!-- Only show Waiting News option to admins (roleId = 1) -->
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
                                        <h4>No ${param.type eq 'WaitingNews' ? 'waiting' : 'published'} news available.</h4>
                                        <p>
                                            ${param.type eq 'WaitingNews' ? 'There are currently no news awaiting approval.' : 'No published news found.'}
                                        </p>
                                    </div>
                                </c:if>

                                <c:forEach var="news" items="${n}">
                                    <table style="max-height:124px; min-height:119.4px;width:1049.7px; "><tr onmouseover="this.style.backgroundColor ='#B0E0E6'" onmouseout="this.style.backgroundColor='transparent'">
                                        <th style="width: 85%;"><div  style="min-width: 500px;max-width: 916px;height:109.4px;padding-left:20px;padding-top:13px; white-space: nowrap;" ><h3 style="font-size: 20px;display: inline-block; vertical-align: top;margin-top: 17px;text-overflow: ellipsis; overflow: hidden; white-space: nowrap;" ><a href="">${news.title} </a></h3>
                                            <button id="deletebtn" onclick="deleteNews(${news.nId})" style="float:right; border:none; width:103px; height:70px; appearance: none; background-color: inherit; display: flex; justify-content: center; align-items: center;">
                                            <img src="https://drive.google.com/thumbnail?id=1jMT2nYYaUtyf7OQbRk3t_6u8U5bnL8r2" style="width:103px; height:70px; display:inline-block;" class="img-rounded" alt="Load img fail"></button>
                                            <a href="updateNews?nId=${news.nId}"  class="btn btn-info editNewsbtn" style="float:right; display:inline-block; vertical-align:top; margin-top:15px;">Edit</a>
                                            <p style="margin-top: -2px;">
                                                Posted:
                                                <%
                                                    Date newsDate = ((model.News)pageContext.getAttribute("news")).getUpdateDate();
                                                    if(newsDate != null) {
                                                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy, HH:mm");
                                                        out.print(sdf.format(newsDate));
                                                    } else {
                                                        out.print("Unknown Date");
                                                    }
                                                %>
                                                <span style="margin-left: 20px;">By: ${not empty news.authorName ? news.authorName : 'Unknown'}</span>
                                            </p></th></div></tr></table>
                                </c:forEach>
                            </div>
                            <!-- Pagination -->
                            <div aria-label="Page navigation example" class="mt-4">
                                <ul class="pagination justify-content-center">

                                    <c:forEach begin="1" end = "${pages}" var = "i">
                                        <li class="page-item">
                                            <a class="page-link" href="newsListStaff?index=${i}&type=${param.type}">${i}</a>
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
