<%-- 
    Document   : loan-request-list
    Created on : Feb 24, 2025, 9:41:01 PM
    Author     : lenovo
--%>

<%@page import="java.util.List, model.LoanRequest"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách gói vay</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            .card img {
                height: 200px;
                object-fit: cover;
            }
            .btn-green {
                background-color: #86c232;
                color: white;
            }
            .btn-green:hover {
                background-color: #61892f;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Danh sách gói vay</h2>
            <form action="ListLoanPackageController" method="POST">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card">
                            <img src="../assets/img/loanpackage/vaytinchap.png" class="card-img-top" alt="Vay tín chấp">
                            <div class="card-body">
                                <h5 class="card-title">Vay tín chấp đối với Người lao động</h5>
                                <p><strong>Mức vay:</strong> Linh hoạt</p>
                                <p><strong>Thời hạn vay tối đa:</strong> 60 tháng</p>
                                <a href="#" class="btn btn-green">Đăng ký ngay</a>
                                <a href="#" class="btn btn-outline-secondary">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <img src="../assets/img/loanpackage/vaymuaoto.jpg" class="card-img-top" alt="Vay mua ô tô">
                            <div class="card-body">
                                <h5 class="card-title">Vay mua ô tô</h5>
                                <p><strong>Mức vay lên tới:</strong> 100% giá trị xe</p>
                                <p><strong>Thời hạn vay tối đa:</strong> 96 tháng</p>
                                <a href="#" class="btn btn-green">Đăng ký ngay</a>
                                <a href="#" class="btn btn-outline-secondary">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <img src="../assets/img/loanpackage/antamkinhdoanh.jpg" class="card-img-top" alt="An tâm kinh doanh">
                            <div class="card-body">
                                <h5 class="card-title">An tâm kinh doanh</h5>
                                <p><strong>Mức vay lên tới:</strong> 70% phương án vay</p>
                                <p><strong>Thời gian vay tối đa:</strong> 84 tháng</p>
                                <a href="#" class="btn btn-green">Đăng ký ngay</a>
                                <a href="#" class="btn btn-outline-secondary">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <img src="../assets/img/loanpackage/vayxaysuanhao.jpg" class="card-img-top" alt="Vay xây sửa nhà ở">
                            <div class="card-body">
                                <h5 class="card-title">Vay xây sửa nhà ở</h5>
                                <p><strong>Mức vay lên tới:</strong> 100% giá trị xây sửa</p>
                                <p><strong>Thời gian vay tối đa:</strong> 30 năm</p>
                                <a href="#" class="btn btn-green">Đăng ký ngay</a>
                                <a href="#" class="btn btn-outline-secondary">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <img src="../assets/img/loanpackage/vaycamcogiaytocogia.webg" class="card-img-top" alt="Vay cầm cố giấy tờ có giá">
                            <div class="card-body">
                                <h5 class="card-title">Vay cầm cố giấy tờ có giá</h5>
                                <p><strong>Mức vay lên tới:</strong> 100% giá trị giấy tờ có giá</p>
                                <p><strong>Thời gian vay tối đa:</strong> Linh hoạt</p>
                                <a href="#" class="btn btn-green">Đăng ký ngay</a>
                                <a href="#" class="btn btn-outline-secondary">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <img src="../assets/img/loanpackage/vaytieudungcotaisanbaodam.webg" class="card-img-top" alt="Vay tiêu dùng có tài sản bảo đảm">
                            <div class="card-body">
                                <h5 class="card-title">Vay tiêu dùng có tài sản bảo đảm</h5>
                                <p><strong>Mức vay lên tới:</strong> 02 tỷ VND</p>
                                <p><strong>Thời gian vay tối đa:</strong> 120 tháng</p>
                                <a href="#" class="btn btn-green">Đăng ký ngay</a>
                                <a href="#" class="btn btn-outline-secondary">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </form>
</body>
</html>