<%-- 
    Document   : managerContracts
    Created on : Feb 9, 2025, 2:11:54 PM
    Author     : lenovo
--%>

%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="controller.contract.Contract" %>
<%@ page import="Contract" %>
<%@ page import="ContractDAO" %>

<html>
    <head>
        <title>Manage Contracts</title>
        <!-- Custom fonts for this template -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="adminassets/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Custom styles for this page -->
        <link href="adminassets/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">
        <style>
            th {
                position: relative;
                padding-right: 20px; /* Adjust this value to give space for the icon */
            }
            th .fa {
                position: absolute;
                right: 5px; /* Adjust this value to control the distance from the edge */
                top: 50%;
                transform: translateY(-50%);
                font-size: 12px; /* Adjust the size of the icon if needed */
            }
        </style>
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
                        <h2>Contract Management</h2>
                        <a href="addContract.jsp">Add New Contract</a>
                        <table border="1">
                            <tr>
                                <th>ID</th>
                                <th>Customer Name</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            <% 
                                ContractDAO contractDAO = new ContractDAO();
                                List<Contract> contracts = contractDAO.list();
                                for (Contract contract : contracts) {
                            %>
                            <tr>
                                <td><%= contract.getId() %></td>
                                <td><%= contract.getCustomerName() %></td>
                                <td><%= contract.getType() %></td>
                                <td><%= contract.getAmount() %></td>
                                <td><%= contract.getStatus() %></td>
                                <td>
                                    <form action="contractApproval" method="post">
                                        <input type="hidden" name="contractId" value="<%= contract.getId() %>">
                                        <button type="submit" name="action" value="approve">Approve</button>
                                        <button type="submit" name="action" value="reject">Reject</button>
                                    </form>
                                    <a href="editContract.jsp?id=<%= contract.getId() %>">Edit</a>
                                </td>
                            </tr>
                            <% } %>
                        </table>

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