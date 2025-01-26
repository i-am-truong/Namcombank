<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-transparent pb-5 header">
    <div class="container">
        <a class="navbar-brand nav-logo" href="index.jsp">
            <img src="./assets/img/namcombank.jpg" alt="Logo" width="100">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class=""><i class="fas fa-bars fa-sm"></i></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link text-dark nav-change-color" href="#">Tools & Extensions</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark nav-change-color" href="#about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark nav-change-color" href="#contact">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark nav-change-color" href="./login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <div class="nav-signup-container">
                        <div class="nav-signup">
                            <a href="./register.jsp" class="no-underline">Sign Up</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>