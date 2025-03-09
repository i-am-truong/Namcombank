<%-- 
    Document   : AddNews
    Created on : 16/06/2024, 2:48:30 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        <style>
            .ck-editor__editable_inline {
                min-height: 320px;
            }

        </style>
        <script src="${pageContext.request.contextPath}/assets/js/jquery-3.5.1.min.js" type="text/javascript"></script>
        <script src="https://cdn.ckeditor.com/ckeditor5/41.4.2/classic/ckeditor.js"></script>
        <script type="text/javascript">
         
            function approveNews(functionName) {
                if (window.editor.getData() === "") {
                    showError('All field must be filled', 3000);
                } else {
                    $.ajax({
                        type: 'POST',
                        url: 'updateNews',
                        data: {
                            "functionName": functionName
                        },
                        success: function (data) {
                            showAlert("Approve News successfully", 3000);
                             setTimeout(() => {
                                window.location.href = 'newsListStaff'; // Thay 'newsList' bằng URL đúng của servlet
                            }, 1000);
                        },
                        error: function (xhr, status, error) {
                            showError("Approve fail, something went wrong", 3000);
                            setTimeout(() => {
                                window.location.href = 'newsListStaff'; // Thay 'newsList' bằng URL đúng của servlet
                            }, 1000);
                        }
                    });
                }
            }
            ;
            function saveUpdate(functionName) {
              if (!/[A-Za-z0-9]/.test($('#title').val()) || !/[A-Za-z0-9]/.test(window.editor.getData())) {
    showError('All field must be filled', 3000);
} else {
                    var body = window.editor.getData();


                    $.ajax({
                        type: 'POST',
                        url: 'updateNews',
                        data: {
                            "body": body,
                            "functionName": functionName
                        },
                        success: function (data) {
                            showAlert("Update News successfully", 3000);
                            setTimeout(() => {
                                window.location.href = 'newsListStaff'; // Thay 'newsList' bằng URL đúng của servlet
                            }, 1000);
                        },
                        error: function (xhr, status, error) {
                            showError("Update fail, something went wrong", 3000);
                            setTimeout(() => {
                                window.location.href = 'newsListStaff'; // Thay 'newsList' bằng URL đúng của servlet
                            }, 1000);
                        }
                    });
                }
            }
            ;
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
                                window.location.href = 'newsListStaff'; // Thay 'newsList' bằng URL đúng của servlet
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

            $(document).ready(function () {


                $("#box").css("min-height", "650px");
                class MyUploadAdapter {
                    constructor(loader) {
                        // The file loader instance to use during the upload. It sounds scary but do not
                        // worry — the loader will be passed into the adapter later on in this guide.
                        this.loader = loader;
                    }

                    // Starts the upload process.
                    upload() {
                        return this.loader.file
                                .then(file => new Promise((resolve, reject) => {
                                        this._initRequest();
                                        this._initListeners(resolve, reject, file);
                                        this._sendRequest(file);
                                    }));
                    }

                    // Aborts the upload process.
                    abort() {
                        if (this.xhr) {
                            this.xhr.abort();
                        }
                    }
                    // Initializes the XMLHttpRequest object using the URL passed to the constructor.
                    _initRequest() {
                        const xhr = this.xhr = new XMLHttpRequest();

                        // Note that your request may look different. It is up to you and your editor
                        // integration to choose the right communication channel. This example uses
                        // a POST request with JSON as a data structure but your configuration
                        // could be different.
                        xhr.open('POST', 'http://localhost:8080/Namcombank/imageUploader', true);
                        xhr.responseType = 'json';
                        console.log(xhr.response);
                    }
                    // Initializes XMLHttpRequest listeners.
                    _initListeners(resolve, reject, file) {
                        const xhr = this.xhr;
                        const loader = this.loader;
                        const genericErrorText = `Couldn't upload file: ${file.name}.`;

                        xhr.addEventListener('error', () => reject(genericErrorText));
                        xhr.addEventListener('abort', () => reject());
                        xhr.addEventListener('load', () => {
                            const response = xhr.response;

                            // This example assumes the XHR server's "response" object will come with
                            // an "error" which has its own "message" that can be passed to reject()
                            // in the upload promise.
                            //
                            // Your integration may handle upload errors in a different way so make sure
                            // it is done properly. The reject() function must be called when the upload fails.
                            if (!response || response.error) {
                                return reject(response && response.error ? response.error.message : genericErrorText);
                            }

                            // If the upload is successful, resolve the upload promise with an object containing
                            // at least the "default" URL, pointing to the image on the server.
                            // This URL will be used to display the image in the content. Learn more in the
                            // UploadAdapter#upload documentation.
                            resolve({
                                default: response.url
                            });
                        });

                        // Upload progress when it is supported. The file loader has the #uploadTotal and #uploaded
                        // properties which are used e.g. to display the upload progress bar in the editor
                        // user interface.
                        if (xhr.upload) {
                            xhr.upload.addEventListener('progress', evt => {
                                if (evt.lengthComputable) {
                                    loader.uploadTotal = evt.total;
                                    loader.uploaded = evt.loaded;
                                }
                            });
                        }
                    }
                    // Prepares the data and sends the request.
                    _sendRequest(file) {
                        // Prepare the form data.
                        const data = new FormData();

                        data.append('upload', file);

                        // Important note: This is the right place to implement security mechanisms
                        // like authentication and CSRF protection. For instance, you can use
                        // XMLHttpRequest.setRequestHeader() to set the request headers containing
                        // the CSRF token generated earlier by your application.

                        // Send the request.
                        this.xhr.send(data);
                    }
                }
                function MyCustomUploadAdapterPlugin(editor) {
                    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                        // Configure the URL to the upload script in your backend here!
                        return new MyUploadAdapter(loader);
                    };
                }

                ClassicEditor
                        .create(document.querySelector('#body'), {
                            extraPlugins: [MyCustomUploadAdapterPlugin]
                        })
                        .then(editor => {
                            window.editor = editor;
                        })
                        .catch(err => {
                            console.error(err.stack);
                        });



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
                                    <a  class="btn btn-link" style="height:20px;color:royalblue;width:160px;font-size:18px;height: 36px" href="newsListStaff?type=News">News</a>

                                </div>
                                 <c:if test="${sessionScope.user.rid == 1}">
                                <div class="col-3">
                                    <a  class="btn btn-link" style="height:20px;color:royalblue;width:160px;font-size:18px;height: 36px" href="newsListStaff?type=WaitingNews">Waiting News</a>
                                </div>
                                </c:if>
                            </div>
                            <div id="box" class="row" style="   min-width: 500px;max-width: 1060px;position: relative;margin-left:40px;border:solid;height:auto;background-color:white;min-height: 350px;border-radius: 7px;overflow: auto;">
                                <div id="createBlog" class="col">
                                    <div>
                                        <label style="padding-top:12px">Title</label>
                                        <input readonly type="text" class="form-control" id="title" value="${news.title}" />
                                    </div>
                                    <div>
                                        <label>Content</label>
                                        <textarea id="body" style="min-height: 450px">${news.body}</textarea>
                                    </div>
                                    <div>
                                        <button onclick="saveUpdate('updateFunction')" type="button" id="updatebtn" class="btn btn-primary" style="margin-bottom:20px; margin-top:10px">Update</button>
                                        <c:if test="${!news.status}">
                                            <button type="button" onclick="approveNews('approveFunction')" id="approvebtn" class="btn btn-success" style="margin-left:10px; margin-bottom:20px; margin-top:10px">Approve</button>
                                        </c:if>

                                        <button onclick="deleteNews(${news.nId})" type="button" id="denybtn" class="btn btn-danger" style="margin-left:10px; margin-bottom:20px; margin-top:10px">Delete</button>
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


    </body>
</html>
