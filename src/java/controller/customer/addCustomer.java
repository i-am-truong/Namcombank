/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import java.io.IOException;
import java.io.PrintWriter;

import context.CustomerDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
//import java.util.Date;
import java.sql.Date;
import model.auth.Staff;

/**
 *
 * @author TQT
 */
public class addCustomer extends BaseRBACControlller {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet addCustomer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addCustomer at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        // Only validate if form was actually submitted
        if (request.getParameter("fullnameC") != null) {
            String fullname = request.getParameter("fullnameC");
            String phonenumber = request.getParameter("phonenumberC");
            String email = request.getParameter("emailC");
            String address = request.getParameter("addressC");
            String dob = request.getParameter("dobC");
            String gender = request.getParameter("genderC");
            String username = request.getParameter("usernameC");
            String password = request.getParameter("passwordC");
            String cic = request.getParameter("cicC");

            // Check if any required field is empty (not just null)
            if (password == null || password.trim().isEmpty() ||
                fullname == null || fullname.trim().isEmpty() ||
                dob == null || dob.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phonenumber == null || phonenumber.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                gender == null || gender.trim().isEmpty() ||
                cic == null || cic.trim().isEmpty()) {
                request.setAttribute("error", "All fields cannot be empty!");
                request.getRequestDispatcher("customer/addCustomer.jsp").forward(request, response);
                return;
            }

            CustomerDAO cd = new CustomerDAO();
            // check xem username or email or phonenumber đã tồn tại hay chưa
            if (cd.checkUsernameAdded(username, email, phonenumber, cic)) {
                password = cd.toSHA1(password);
                cd.registerAcc(fullname, username, password, email, dob, Integer.parseInt(gender), phonenumber, cic, address);
                request.setAttribute("suc", "Create account successfully!");
                request.getRequestDispatcher("customer/addCustomer.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Username or email or phonenumber or CCCD already exist!");
                request.getRequestDispatcher("customer/addCustomer.jsp").forward(request, response);
            }
        } else {
            // Initial form load - just show the form without validation
            request.getRequestDispatcher("customer/addCustomer.jsp").forward(request, response);
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        // Just show the form without validation
        request.getRequestDispatcher("customer/addCustomer.jsp").forward(request, response);
    }

}
