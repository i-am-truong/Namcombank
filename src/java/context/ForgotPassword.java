/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package context;

import context.CustomerDAO;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.Random;
import model.Customer;

/**
 *
 * @author duong
 */
@WebServlet(name="ForgotPassword", urlPatterns={"/ForgotPassword"})
public class ForgotPassword extends HttpServlet {

    private Session session;
    private int length;
   
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
            out.println("<title>Servlet ForgotPassword</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPassword at " + request.getContextPath () + "</h1>");
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
        String email = request.getParameter("email");
        RequestDispatcher dispatcher = null;
        HttpSession mySession = request.getSession();
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = new Customer();
        customer.setEmail(email);
        
        //kiểm tra email có tồn tại trong DB không
        if(email != null && !email.equals("") && customerDAO.checkUsername(email, email)){
            String otpvalue = generateOTP(6);
            String to = email;
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            
            Session s = Session.getDefaultInstance(props, new jakarta.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("duongkoi0504@gmail.com", "Duong123");
                }
            });
            try {
                MimeMessage mess = new MimeMessage(session);
                mess.setFrom(new InternetAddress("swp@gmail.com"));
                mess.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                mess.setSubject("Mã OTP yêu cầu đặt lại mật khẩu mới", StandardCharsets.UTF_8.name()); //sử dụng UTF_8 cho tiêu đề
                mess.setText("Mã OTP để đặt lại mật khẩu mới của bạn là: " + otpvalue, StandardCharsets.UTF_8.name()); //sử dụng UTF_8 cho nội dung
                Transport.send(mess);
                System.out.println("Message sent successfully");
            } catch (MessagingException e){
                throw new RuntimeException(e);
            }
            dispatcher = request.getRequestDispatcher("view/authen/enterOTP.jsp");
            request.setAttribute("message", "OTP đã được gửi, hãy kiểm tra lại gmail của bạn!");
            mySession.setAttribute("otp", otpvalue);
            mySession.setAttribute("email", email);
        } else {
            dispatcher = request.getRequestDispatcher("view/authen/forgotpassword.jsp");
            request.setAttribute("errorMessage", "Email không tồn tại trong hệ thống!");
        }
        dispatcher.forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String generateOTP(int i) {
        Random rand = new Random();
        StringBuilder otp = new StringBuilder(length);
        while (otp.length() < length){
            otp.append(rand.nextInt(10));
        }
        return otp.toString();
    }

}
