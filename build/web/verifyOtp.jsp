<%-- 
    Document   : verifyOtp
    Created on : Jan 19, 2025, 12:50:13 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="jakarta.servlet.http.*, jakarta.servlet.*" %>

<%
    String email = request.getParameter("email");
    String enteredOtp = request.getParameter("otp");
    String message;

    if (email != null && enteredOtp != null && email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$") && enteredOtp.matches("\\d{6}")) {
        // Secure database connection
        Connection conn = null;
        PreparedStatement stmt = null;
        String url = "jdbc:mysql://localhost:3306/your_database"; // Use configuration for this
        String dbUser = "your_username"; // Use configuration for this
        String dbPassword = "your_password"; // Use configuration for this

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
            String query = "SELECT * FROM otp_verification WHERE email = ? AND otp = ? AND expiry > NOW()";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, enteredOtp);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // OTP is valid
                message = "OTP verified. You can now reset your password.";
                // Set session attribute for email
                HttpSession session = request.getSession();
                session.setAttribute("verifiedEmail", email);
                // Redirect to password reset page
                response.sendRedirect("resetPassword.jsp");
            } else {
                message = "Invalid or expired OTP.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "Error verifying OTP.";
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        message = "Invalid input.";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>OTP Verification</title>
</head>
<body>
    <div class="container mt-5">
        <h2><%= message %></h2>
    </div>
</body>
</html>
