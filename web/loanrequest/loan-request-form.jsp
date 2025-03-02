<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Yêu Cầu Vay</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .loan-container {
                max-width: 900px;
                margin: auto;
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }
            .form-section {
                background: #eefbea;
                padding: 20px;
                border-radius: 10px;
            }
            .result-section {
                padding: 20px;
            }
            .result-box {
                background: #fff;
                border-radius: 10px;
                padding: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .btn-primary {
                width: 100%;
            }
        </style>
    </head>
    <body>

        <div class="container my-4">
            <div class="loan-container row">
                <!-- Form nhập thông tin -->
                <div class="col-md-6 form-section">
                    <h3 class="mb-3">Yêu Cầu Vay</h3>
                    <form action="LoanRequestServlet" method="post">
                        <div class="mb-3">
                            <label for="amount" class="form-label">Số tiền vay</label>
                            <input type="number" class="form-control" id="amount" name="amount" required>
                        </div>
                        <div class="mb-3">
                            <label for="interestRate" class="form-label">Lãi suất (%/năm)</label>
                            <input type="number" step="0.01" class="form-control" id="interestRate" name="interestRate" required>
                        </div>
                        <div class="mb-3">
                            <label for="package" class="form-label">Gói vay</label>
                            <select class="form-select" id="package" name="package">
                                <option value="6">Gói 1: 6 tháng</option>
                                <option value="12">Gói 2: 12 tháng</option>
                                <option value="24">Gói 3: 24 tháng</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="startDate" class="form-label">Ngày bắt đầu</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="endDate" class="form-label">Ngày kết thúc</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Gửi Yêu Cầu</button>
                    </form>
                </div>

                <!-- Hiển thị kết quả -->
                <div class="col-md-6 result-section">
                    <h3 class="mb-3">Số tiền cần trả</h3>
                    <div class="result-box">
                        <p><strong>Phương thức vay:</strong> --</p>
                        <p><strong>Lãi suất (%/năm):</strong> 0%</p>
                        <p><strong>Số tiền trả hàng tháng:</strong> 0 VND</p>
                        <p><strong>Tổng số gốc phải trả:</strong> 0 VND</p>
                        <p><strong>Tổng lãi phải trả:</strong> 0 VND</p>
                        <hr>
                        <p><strong>Tổng số tiền cần trả:</strong> <span style="font-size: 20px; font-weight: bold;">0 VND</span></p>
                        <p class="text-muted">Lưu ý: Kết quả chỉ mang tính chất tham khảo</p>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
