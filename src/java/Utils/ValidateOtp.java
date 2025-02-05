/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Utils;


import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 *
 * @author duong
 */
@WebServlet(name="ValidateOtp", urlPatterns={"/ValidateOtp"})
public class ValidateOtp extends HttpServlet {
   
    private static final long serialVersionUID = 1L;
    
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String value = request.getParameter("otp");
        HttpSession session = request.getSession();
        String otp = String.valueOf(session.getAttribute("otp")); // Đảm bảo otp được lấy ra dưới dạng String
        Integer attempts = (Integer) session.getAttribute("otpAttempts");
        if (attempts == null) {
            attempts = 0;
        }

        RequestDispatcher dispatcher = null;

        if (value == null || value.isEmpty()) {
            request.setAttribute("message", "Mã OTP không được để trống.");
            dispatcher = request.getRequestDispatcher("view/authen/enterOTP.jsp");
        } else if (value.equals(otp)) {
            request.setAttribute("email", session.getAttribute("email"));
            request.setAttribute("status", "success");
            session.setAttribute("otpAttempts", 0); // Reset attempts on success
            dispatcher = request.getRequestDispatcher("view/authen/newpassword.jsp");
        } else {
            attempts++;
            session.setAttribute("otpAttempts", attempts);
            request.setAttribute("message", "Mã của bạn không chính xác. Hãy kiểm tra lại!");
            dispatcher = request.getRequestDispatcher("view/authen/enterOTP.jsp");
        }

        dispatcher.forward(request, response);
    }
    
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ValidateOtp</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ValidateOtp at " + request.getContextPath () + "</h1>");
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
        processRequest(request, response);
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
