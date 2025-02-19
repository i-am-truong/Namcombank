/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package context;

import Utils.DesEncDec;
import context.CustomerDAO;
import context.CustomerDAO;
import context.CustomerDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author duong
 */
@WebServlet(name="NewPassword", urlPatterns={"/newpassword"})
public class NewPassword extends HttpServlet {
    CustomerDAO customerDAO = new CustomerDAO();
   
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
            out.println("<title>Servlet NewPassword</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewPassword at " + request.getContextPath () + "</h1>");
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
        String newpassword = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");
        String email = (String) request.getSession().getAttribute("email");
        
        //check các trường trống
        if(newpassword.trim().isEmpty() || confPassword.trim().isEmpty()){
            request.setAttribute("errorMessage", "Mật khẩu không được để trống!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        //check mật khẩu có khớp không
        if(!newpassword.equals(confPassword)){
            request.setAttribute("error", "Mật khẩu bạn nhập không trùng khớp!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
            return;
        }
        try{
            //mã hóa mk mới
            newpassword = DesEncDec.encrypt(newpassword);
        } catch (Exception e){
            e.printStackTrace();
            request.setAttribute("errorMessage", "Encryption failed");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
            return;
        }
        //Cập nhập mật khẩu 
        boolean updateSuccess = customerDAO.updatePassword(email, newpassword);
        
        if(updateSuccess){
            //password update successfully
            request.setAttribute("successfully", "Đổi mật khẩu thành công!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
        } else {
            //password update failed
            request.setAttribute("errorMessage", "Failed to change password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/authen/newpassword.jsp");
            dispatcher.forward(request, response);
        }
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
