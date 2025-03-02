<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.auth.Staff" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Header Admin</title>
        <link rel="stylesheet" href="assets/css/fontawesome.all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
                justify-content: center;
            }
            .navbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #fff;
                padding: 10px 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .navbar .navbar-brand {
                font-size: 1.25rem;
                color: #4e73df;
                text-decoration: none;
            }
            .navbar .navbar-toggler {
                display: none;
            }
            .navbar .navbar-nav {
                display: flex;
                align-items: center;
            }
            .navbar .nav-item {
                list-style: none;
                margin: 0 10px;
                position: relative;
            }
            .navbar .nav-link {
                color: #5a5c69;
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 5px;
                transition: background-color 0.3s;
                display: flex;
                align-items: center;
            }
            .navbar .nav-link:hover {
                background-color: #f8f9fa;
            }
            .navbar .img-profile {
                border-radius: 50%;
                width: 40px;
                height: 40px;
                margin-right: 10px;
            }
            .dropdown-menu {
                display: none;
                position: absolute;
                width: 200px;
                /*                margin-left: 1480px;*/
                margin-left: 85%;
                top: 70px;
                right: 0px;
                background-color: #fff;
                border: 1px solid #e3e6f0;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
                overflow: hidden;

            }
            .dropdown-menu a {
                display: block;
                padding: 10px 20px;
                color: #5a5c69;
                text-decoration: none;
            }
            .dropdown-menu form {

                padding: 20px;
            }
            .dropdown-menu form input {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .dropdown-menu a:hover {
                background-color: #f8f9fa;
            }
            .nav-item.dropdown.show .dropdown-menu {
                display: block;
            }
            @media (max-width: 768px) {
                .navbar .navbar-toggler {
                    display: block;
                    background: none;
                    border: none;
                    font-size: 1.25rem;
                    cursor: pointer;
                }
                .navbar .navbar-nav {
                    display: none;
                    flex-direction: column;
                    width: 100%;
                    text-align: center;
                }
                .navbar .navbar-nav.active {
                    display: flex;
                }
                .navbar .nav-item {
                    margin: 10px 0;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar">
            <c:if test="${sessionScope.roleId==1}"><h2>Admin manager</h2></c:if>
            <c:if test="${sessionScope.roleId==2}"><h2>Staff manager</h2></c:if>
                <button class="navbar-toggler" onclick="toggleNavbar()">
                    <i class="fa fa-bars"></i>
                </button>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" onclick="toggleDropdown(event)">
                            <i style="padding-right: 20px" class="fas fa-bell"></i>

                            <span>${sessionScope.account.fullname}</span>
                    </a>

                </li>
            </ul>
        </nav>
        <div class="dropdown-menu" id="dropdownMenu">

            <a href="ChatListServlet"><i class="fas fa-user"></i>&nbsp;&nbsp;Tin Nhan Dang Cho</a>
            <a href="staffProfile"><i class="fas fa-user"></i>&nbsp;&nbsp;Show profile </a>

            <a href="#"><i class="fas fa-cog"></i>&nbsp;&nbsp;Setting</a>
            <a href="logOut"><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;Logout</a>
        </div>

        <script>
            function toggleNavbar() {
                const navbarNav = document.querySelector('.navbar-nav');
                navbarNav.classList.toggle('active');
            }

            function toggleDropdown(event) {
                event.preventDefault();
                const dropdownMenu = document.getElementById('dropdownMenu');
                dropdownMenu.classList.toggle('show');
            }
        </script>
    </body>
</html>
