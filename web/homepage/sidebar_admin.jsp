<%--
    Document   : sidebar_admin
    Created on : Jun 17, 2024, 4:31:07 PM
    Author     : lenvo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">

</head>

<ul class="navbar-nav bg-gradient-success sidebar sidebar-dark accordion" id="accordionSidebar">
    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Banking Services System
        </div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="Dashboard">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">Interface</div>

    <li class="nav-item active">
        <a class="nav-link" href="staffProfile">
            <i class="fas fa-fw fa-table"></i>
            <span>Profile</span></a>
    </li>

    <li class="nav-item active">
        <a class="nav-link" href="loanpackage/listloanpackage">
            <i class="fas fa-fw fa-table"></i>
            <span>Loan Packages Table</span></a>
    </li>

    <!-- manage contracts -->
    <li class="nav-item active">
        <a class="nav-link" href="contractApproval">
            <i class="fas fa-fw fa-table"></i>
            <span>Manage Contracts</span>
        </a>
    </li>

    <!-- manage Saving Request -->
    <li class="nav-item active">
        <a class="nav-link" href="#"data-toggle="collapse" data-target="#toolMenu" aria-expanded="false">
            <i class="fas fa-fw fa-table"></i>
            <span>Saving Request Table</span>
        </a>
        <div id="toolMenu" class="collapse">
            <a class="nav-link sub-menu" href="listSaving">
                <i class="fas fa-fw fa-table"></i> Saving Request
            </a>
            <a class="nav-link sub-menu" href="savingMoney">
                <i class="fas fa-fw fa-table"></i> Saving Request Money Revie
            </a>
        </div>
        </a>
    </li>

    <!-- manage Saving Package -->
    <li class="nav-item active">
        <a class="nav-link" href="#"data-toggle="collapse" data-target="#toolMenu" aria-expanded="false">
            <i class="fas fa-fw fa-table"></i>
            <span>Saving Package Manager</span>
        </a>
        <div id="toolMenu" class="collapse">
            <a class="nav-link sub-menu" href="managerSaving">
                <i class="fas fa-fw fa-table"></i> Manager Saving
            </a>
            <a class="nav-link sub-menu" href="updateSaving">
                <i class="fas fa-fw fa-table"></i> Request
            </a>
            <a class="nav-link sub-menu" href="SavingPay">
                <i class="fas fa-fw fa-table"></i> Saving Pay
            </a>
        </div>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#toolMenu" aria-expanded="false">
            <i class="fas fa-fw fa-table"></i>
            <span>Tool & Extensions</span>
        </a>
        <div id="toolMenu" class="collapse">
            <a class="nav-link sub-menu" href="repaymentSchedule">
                <i class="fas fa-fw fa-table"></i> Repayment Schedule
            </a>
            <a class="nav-link sub-menu" href="savingInterest">
                <i class="fas fa-fw fa-table"></i> Savings Interest Rate
            </a>
            <a class="nav-link sub-menu" href="loanPackage">
                <i class="fas fa-fw fa-table"></i> Loan Interest Rate
            </a>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#staffMenu" aria-expanded="false">
            <i class="fas fa-fw fa-user"></i>
            <span>Staff Manager</span>
        </a>
        <div id="staffMenu" class="collapse">
            <a class="nav-link sub-menu" href="staffFilter">
                <i class="fas fa-fw fa-filter"></i> Filter Staff
            </a>
            <a class="nav-link sub-menu" href="addStaff">
                <i class="fas fa-fw fa-user-plus"></i> Add Staff
            </a>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#assetMenu" aria-expanded="false">
            <i class="fas fa-fw fa-user"></i>
            <span>Asset Manager</span>
        </a>
        <div id="assetMenu" class="collapse">
            <a class="nav-link sub-menu" href="assets-filter">
                <i class="fas fa-fw fa-filter"></i> Filter Asset
            </a>
            <a class="nav-link sub-menu" href="assets-add">
                <i class="fas fa-fw fa-user-plus"></i> Add Asset
            </a>
        </div>
    </li>
    <!-- feedback cua admin -->

    <li class="nav-item active">
        <a class="nav-link" href="viewCustomerFeedback">
            <i class="fas fa-fw fa-table"></i>
            <span>View Customer Feedback</span></a>
    </li>



    <li class="nav-item active">
        <a class="nav-link" href="listCate">
            <i class="fas fa-fw fa-table"></i>
            <span>Category Table</span></a>
    </li>



    <li class="nav-item active">
        <a class="nav-link" href="newsListStaff">
            <i class="fas fa-fw fa-table"></i>
            <span>News Manager</span></a>
    </li>

    <li class="nav-item active">
        <a class="nav-link" href="addNews">
            <i class="fas fa-fw fa-table"></i>
            <span> News Manager</span></a>
    </li>



    <!--    <li class="nav-item active">
            <a class="nav-link" href="listCate">
                <i class="fas fa-fw fa-table"></i>
                <span>Category Table</span></a>
        </li>



    -->    <li class="nav-item active">
        <a class="nav-link" href="newsList">
            <i class="fas fa-fw fa-table"></i>
            <span> News</span></a>
    </li>

    <li class="nav-item active">
        <a class="nav-link" href="manageCustomerVer2">
            <i class="fas fa-fw fa-table"></i>
            <span> Manage Customer Ver 2</span></a>
    </li>


    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
<script>
    document.getElementById('sidebarToggle').addEventListener('click', function () {
        document.getElementById('accordionSidebar').classList.toggle('toggled');
    });
</script>
<!-- jQuery and Bootstrap  -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
