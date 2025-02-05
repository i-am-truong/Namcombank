/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.User;

import context.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;

/**
 *
 * @author lenovo
 */
public class addStaff extends HttpServlet {
   
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
            out.println("<title>Servlet addStaff</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addStaff at " + request.getContextPath () + "</h1>");
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
            HttpSession session = request.getSession(true);
        Customer user = (Customer) session.getAttribute("user");
        if (user!= null) {
            request.getRequestDispatcher("user/addStaff.jsp").forward(request, response);
        } else {
            // Redirect to login page if user session is not found
            response.sendRedirect("login");
        }
       
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
            String fullname = request.getParameter("nameS");
        String phonenumber = request.getParameter("phoneS");
        String email = request.getParameter("emailS");
        String address = request.getParameter("addressS");
        String dob = request.getParameter("dateS");
        String gender = request.getParameter("genderS");
        String username = request.getParameter("usernameS");
        String password = request.getParameter("passS");
        String cic = request.getParameter("cicS");
        CustomerDAO ud = new CustomerDAO();
        if (ud.checkUsername(username, email)) {
            password = ud.toSHA1(password);
            ud.registerAcc(fullname, username, password, email, dob, Integer.parseInt(gender), phonenumber, cic, address);
            ud.changeRole2(username, 2);
            request.setAttribute("suc2", "Create staff account successfully! ");
            request.getRequestDispatcher("user/addStaff.jsp").forward(request, response);
        } else {
            request.setAttribute("suc2", "username or email already exist!");
            request.getRequestDispatcher("user/addStaff.jsp").forward(request, response);
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
