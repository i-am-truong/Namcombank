<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Customer Saving Request</title>
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 20px;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 12px;
                text-align: center;
            }
            .btn {
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
            }
            .btn-approve {
                background-color: #28a745;
                color: white;
            }
            .btn-reject {
                background-color: #dc3545;
                color: white;
            }
        </style>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <%@include file="../homepage/sidebar_admin.jsp" %>
            <div id="content-wrapper" class="d-flex flex-column">
                <%@include file="../homepage/header_admin.jsp" %>

                <!--            
                            private String saving_package_name;
                            private String saving_package_description;
                            private double saving_package_interest_rate;
                            private int saving_package_term_months;
                            private Double saving_package_min_deposit;
                            private Double saving_package_max_deposit;
                            private String saving_package_status;
                            
                            
                            private boolean saving_withdrawable;
                            private String saving_package_approval_status;-->

                <form action="createSavingPackage" method="post">
                    <div class="container">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger text-center">
                                ${error}
                            </div>
                        </c:if>

                        <h2 class="text-center">Create Saving Package</h2>
                        <input type="text" id="staff_id" name="staff_id" class="form-control" value="null" hidden>
                        <div >
                            <label for="saving_package_name" class="form-label">Package Name</label>
                            <input type="text" id="saving_package_name" name="saving_package_name" class="form-control" required>
                        </div>

                        <div >
                            <label for="saving_package_description" class="form-label">Description</label>
                            <textarea id="saving_package_description" name="saving_package_description" class="form-control" required></textarea>
                        </div>

                        <div >
                            <label for="saving_package_interest_rate" class="form-label">Interest Rate</label>
                            <input type="number" step="0.001" id="saving_package_interest_rate" name="saving_package_interest_rate" class="form-control" required>
                        </div>

                        <div >
                            <label for="saving_package_term_months" class="form-label">Term (Months)</label>
                            <input type="number" id="saving_package_term_months" name="saving_package_term_months" class="form-control" required>
                        </div>

                        <div >
                            <label for="saving_package_min_deposit" class="form-label">Min Deposit</label>
                            <input type="number" step="0.001" id="saving_package_min_deposit" name="saving_package_min_deposit" class="form-control" required>
                        </div>

                        <div >
                            <label for="saving_package_max_deposit" class="form-label">Max Deposit</label>
                            <input type="number" step="0.001" id="saving_package_max_deposit" name="saving_package_max_deposit" class="form-control" required>
                        </div>

                        <div >
                            <label for="saving_package_under_haft" class="form-label">Fine Deposit UnderHaft</label>
                            <input type="number" step="0.001" id="saving_package_under_haft" name="saving_package_under_haft" class="form-control" required>
                        </div>

                        <div >
                            <label for="saving_package_over_haft" class="form-label">Fine Deposit OverHaft</label>
                            <input type="number" step="0.001" id="saving_package_over_haft" name="saving_package_over_haft" class="form-control" required>
                        </div>


                        <div >
                            <label for="saving_package_status" class="form-label">Status</label>
                            <select id="saving_package_status" name="saving_package_status" class="form-control" required>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>

                        <div >
                            <label for="saving_package_approval_status" class="form-label">Approval Status</label>
                            <select id="saving_package_approval_status" name="saving_package_approval_status" class="form-control" required>
                                <option value="pending">Pending</option>

                            </select>
                        </div>

                        <div >
                            <label class="form-label">Withdrawable</label>
                            <div>
                                <input type="radio" id="withdrawable_yes" name="saving_package_withdrawable" value="1" required>
                                <label for="withdrawable_yes">Yes</label>
                                <input type="radio" id="withdrawable_no" name="saving_package_withdrawable" value="0">
                                <label for="withdrawable_no">No</label>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success">Create Package</button>
                    </div>
                </form>

            </div>
    </body>
</html>
