/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Utils;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.Random;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 *
 * @author duong
 */
@WebServlet(name="ResendEmail", urlPatterns={"/resendOtp"})
public class ResendEmail extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResendEmail</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResendEmail at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = (String) request.getSession().getAttribute("email");
        String otpvalue = generateOTP(6); // Tạo OTP với độ dài chính xác là 6 số

        if (email != null && !email.equals("")) {
            // Sending OTP
            String to = email;

            // Get the session object
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
            props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getDefaultInstance(props, new jakarta.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("duongkoi0504@gmail.com", "qjew mxlv juli wgwr");
                }
            });

            // Compose message
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("namcombank@gmail.com"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("Yêu cầu gửi lại mã OTP để đổi mật khẩu mới", StandardCharsets.UTF_8.name());
                message.setText("Mã OTP để đổi mật khẩu của bạn là: " + otpvalue, StandardCharsets.UTF_8.name());
                Transport.send(message);
                System.out.println("message sent successfully");
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

            // Update session with new OTP
            request.getSession().setAttribute("otp", otpvalue);
            response.getWriter().write("Mã OTP đã được gửi đến bạn!");
        } else {
            response.getWriter().write("Error: Email not found in session.");
        }
    }

    private String generateOTP(int length) {
        Random rand = new Random();
        StringBuilder otp = new StringBuilder(length);
        while (otp.length() < length) {
            otp.append(rand.nextInt(10));
        }

        return otp.toString();
    
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
