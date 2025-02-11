/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale.Category;

import context.CustomerDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import model.Customer;
import model.auth.Staff;

/**
 *
 * @author TQT
 */
public class editCustomer extends BaseRBACControlller {

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
            out.println("<title>Servlet editCustomer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editCustomer at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
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
        try {
            // Get all parameters
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String citizenId = request.getParameter("citizenIdC");
            String phonenumber = request.getParameter("phonenumberC");
            String email = request.getParameter("emailC");
            String address = request.getParameter("addressC");
            String dobStr = request.getParameter("dobC");
            String gender = request.getParameter("genderC");

            // Validate required fields
            if (isNullOrEmpty(citizenId) || isNullOrEmpty(phonenumber)
                    || isNullOrEmpty(email) || isNullOrEmpty(address)
                    || isNullOrEmpty(dobStr) || isNullOrEmpty(gender)) {

                request.setAttribute("error", "All fields are required!");
                doGet(request, response);
                return;
            }

            // Convert date string to SQL Date
            Date dob = Date.valueOf(dobStr);

            // Get existing customer
            CustomerDAO cdao = new CustomerDAO();
            Customer customer = cdao.getCustomerById(customerId);

            if (customer == null) {
                request.setAttribute("error", "Customer not found!");
                response.sendRedirect("manageCustomer");
                return;
            }

            // Update customer details
            customer.setCid(citizenId);
            customer.setPhonenumber(phonenumber);
            customer.setEmail(email);
            customer.setAddress(address);
            customer.setDob(dob);
            customer.setGender(Integer.parseInt(gender));

            // Check for duplicates excluding current customer
            if (cdao.checkCustomerUpdate(citizenId, phonenumber, email, customerId)) {
                cdao.updateProfile(customer);
                request.setAttribute("success", "Customer updated successfully!");
                doGet(request, response);
            } else {
                request.setAttribute("error", "Citizen ID, phone number or email is already in use by another customer!");
                doGet(request, response);
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format!");
            doAuthorizedGet(request, response, account);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while updating customer!");
            doAuthorizedGet(request, response, account);
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            String customerId = request.getParameter("customerId");
            if (customerId == null || customerId.trim().isEmpty()) {
                response.sendRedirect("manageCustomer");
                return;
            }

            CustomerDAO cdao = new CustomerDAO();
            Customer customer = cdao.getCustomerById(Integer.parseInt(customerId));

            if (customer == null) {
                response.sendRedirect("manageCustomer");
                return;
            }

            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer/editCustomer.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("manageCustomer");
            return;
        }
    }

}
