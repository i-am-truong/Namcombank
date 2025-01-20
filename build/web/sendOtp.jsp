<%-- 
    Document   : sendOtp
    Created on : Jan 19, 2025, 12:49:54 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, jakarta.mail.*, jakarta.mail.internet.*, java.sql.*" %>

<%
    String email = request.getParameter("email");
    String otp = String.valueOf(new Random().nextInt(999999));
    String message;

    // Save OTP in the database (replace with your database logic)
    Connection conn = null;
    PreparedStatement stmt = null;
    String url = "jdbc:mysql://localhost:3306/your_database"; // Replace with your DB URL
    String user = "your_username"; // Replace with your DB user
    String password = "your_password"; // Replace with your DB password

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        String query = "INSERT INTO otp_verification (email, otp, expiry) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 10 MINUTE))";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, email);
        stmt.setString(2, otp);
        stmt.executeUpdate();

        // Send OTP via email
        String host = "smtp.yourmailserver.com"; // Replace with your SMTP server
        final String smtpUser = "tranducanh220604@gmail.com"; // Replace with your email
        final String smtpPassword = 22062004"; // Replace with your email password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587"); // Port for TLS

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPassword);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(smtpUser));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        msg.setSubject("Your OTP for Password Reset");
        msg.setText("Your OTP is: " + otp);

        Transport.send(msg);

        message = "OTP sent to your email.";
    } catch (Exception e) {
        e.printStackTrace();
        message = "Error sending OTP.";
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>OTP Sent</title>
</head>
<body>
    <div class="container mt-5">
        <h2><%= message %></h2>
    </div>
</body>
</html>
