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
import jakarta.servlet.http.HttpSession;
//import java.util.Date;
import java.sql.Date;
import model.auth.Staff;
import jakarta.mail.internet.InternetAddress;

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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        // Only validate if form was actually submitted
        if (request.getParameter("fullnameC") != null) {
            String fullname = request.getParameter("fullnameC").trim();
            String phonenumber = request.getParameter("phonenumberC").trim();
            String email = request.getParameter("emailC").trim();
            String address = request.getParameter("addressC").trim();
            String defaultPassword = "123456".trim();
            // Validation patterns
            String regexFullName = "^[A-Z][a-z]+(\\s[A-Z][a-z]+)+$";
            String regexEmail = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
            String regexPhoneNumber = "^(09|03|08|07|05)\\d{8}$";

            // Validate each field
            StringBuilder errorMessage = new StringBuilder();

            // Fullname validation
            if (fullname.isEmpty()) {
                errorMessage.append("Full name is required.<br>");
            } else if (!fullname.matches(regexFullName)) {
                errorMessage.append("Full name must start with uppercase letters and contain at least two words.<br>");
            }

            // Email validation
            if (email.isEmpty()) {
                errorMessage.append("Email is required.<br>");
            } else if (!email.matches(regexEmail)) {
                errorMessage.append("Invalid email format.<br>");
            } else {
                try {
                    InternetAddress emailAddr = new InternetAddress(email);
                    emailAddr.validate();
                } catch (Exception ex) {
                    errorMessage.append("Invalid email address.<br>");
                }
            }

            // Phone number validation
            if (phonenumber.isEmpty()) {
                errorMessage.append("Phone number is required.<br>");
            } else if (!phonenumber.matches(regexPhoneNumber)) {
                errorMessage.append("Phone number must start with 09, 03, 08, 07, or 05 and have 10 digits.<br>");
            }

            // Address validation
            if (address.isEmpty()) {
                errorMessage.append("Address is required.<br>");
            } else if (address.length() < 10 || address.length() > 200) {
                errorMessage.append("Address must be between 10 and 200 characters.<br>");
            }

            if (errorMessage.length() > 0) {
                // Set error message and preserve form data
                request.setAttribute("error", errorMessage.toString());
                request.setAttribute("fullnameC", fullname);
                request.setAttribute("emailC", email);
                request.setAttribute("phonenumberC", phonenumber);
                request.setAttribute("addressC", address);
                request.getRequestDispatcher("customer/addCustomer.jsp").forward(request, response);
                return;
            }

            // If validation passes, proceed with registration
            CustomerDAO cd = new CustomerDAO();
            if (cd.checkCustomerAdded(email, phonenumber)) {
                try {
                    String hashedPassword = cd.toSHA1(defaultPassword);
                    cd.registerCustomer(fullname, email, phonenumber, address, hashedPassword);
                    request.setAttribute("suc", "Customer account created successfully! Default password is: " + defaultPassword);
                    // Clear form after successful submission
                    request.removeAttribute("fullnameC");
                    request.removeAttribute("emailC");
                    request.removeAttribute("phonenumberC");
                    request.removeAttribute("addressC");
                } catch (Exception e) {
                    request.setAttribute("error", "An error occurred while creating the account. Please try again.");
                    // Preserve form data in case of error
                    request.setAttribute("fullnameC", fullname);
                    request.setAttribute("emailC", email);
                    request.setAttribute("phonenumberC", phonenumber);
                    request.setAttribute("addressC", address);
                }
            } else {
                request.setAttribute("error", "Email or phone number is already registered!");
                // Preserve form data
                request.setAttribute("fullnameC", fullname);
                request.setAttribute("emailC", email);
                request.setAttribute("phonenumberC", phonenumber);
                request.setAttribute("addressC", address);
            }
            request.getRequestDispatcher("customer/addCustomer.jsp").forward(request, response);
        } else {
            // Initial form load
            request.getRequestDispatcher("customer/addCustomer.jsp").forward(request, response);
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        // Just show the form without validation
        request.getRequestDispatcher("customer/addCustomer.jsp").forward(request, response);
    }

}
