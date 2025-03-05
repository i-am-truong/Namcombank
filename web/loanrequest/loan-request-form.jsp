<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo yêu cầu vay mới</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    </head>
    <body class="bg-light">
        <div class="container py-4">
            <h2 class="mb-4">Tạo yêu cầu vay mới</h2>

            <div class="card">
                <div class="card-body">
                    <form action="create-loan-request" method="POST" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="customerName" class="form-label">Họ và tên</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                                <input type="text" class="form-control" id="customerName" name="customerName" 
                                       minlength="2" maxlength="100" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập họ tên (ít nhất 2 ký tự).
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="loanAmount" class="form-label">Số tiền vay (VNĐ)</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-currency-dollar"></i></span>
                                <input type="number" class="form-control" id="loanAmount" name="loanAmount" 
                                       step="1000000" min="10000000" max="1000000000" required>
                                <span class="input-group-text">VNĐ</span>
                                <div class="invalid-feedback">
                                    Vui lòng nhập số tiền vay từ 10.000.000 đến 1.000.000.000 VNĐ.
                                </div>
                            </div>
                            <small class="form-text text-muted" id="formattedAmount"></small>
                        </div>

                        <div class="mb-3">
                            <label for="loanType" class="form-label">Loại khoản vay</label>
                            <select class="form-select" id="loanType" name="loanType" required>
                                <option value="">Chọn loại khoản vay</option>
                                <option value="personal">Vay cá nhân</option>
                                <option value="business">Vay kinh doanh</option>
                                <option value="mortgage">Vay thế chấp</option>
                            </select>
                            <div class="invalid-feedback">
                                Vui lòng chọn loại khoản vay.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="loanTerm" class="form-label">Thời hạn vay (tháng)</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-calendar-event-fill"></i></span>
                                <input type="number" class="form-control" id="loanTerm" name="loanTerm" 
                                       min="6" max="360" required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập thời hạn vay từ 6 đến 360 tháng.
                                </div>
                            </div>
                        </div>

                        <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger mb-3">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle-fill me-2"></i>Gửi yêu cầu
                            </button>
                            <a href="loan-requests" class="btn btn-secondary">
                                <i class="bi bi-arrow-left-circle me-2"></i>Quay lại danh sách
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Enable Bootstrap form validation
            (function () {
                'use strict'

                // Fetch all forms that need validation
                var forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms).forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })

                // Custom validation for loan amount
                var loanAmountInput = document.getElementById('loanAmount')
                var formattedAmountDiv = document.getElementById('formattedAmount')

                loanAmountInput.addEventListener('input', function (event) {
                    var value = parseFloat(this.value)
                    if (value < 10000000) {
                        this.setCustomValidity('Số tiền vay tối thiểu là 10.000.000 VNĐ')
                    } else if (value > 1000000000) {
                        this.setCustomValidity('Số tiền vay tối đa là 1.000.000.000 VNĐ')
                    } else {
                        this.setCustomValidity('')
                    }

                    // Format number with thousand separator
                    if (value) {
                        formattedAmountDiv.textContent = new Intl.NumberFormat('vi-VN', {
                            style: 'currency',
                            currency: 'VND'
                        }).format(value)
                    } else {
                        formattedAmountDiv.textContent = ''
                    }
                })
            })()
        </script>
    </body>
</html>