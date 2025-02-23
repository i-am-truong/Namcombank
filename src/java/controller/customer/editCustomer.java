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
import jakarta.mail.internet.InternetAddress;
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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }
        try {

            // Get all parameters and trim whitespace
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String citizenId = request.getParameter("citizenIdC") != null
                    ? request.getParameter("citizenIdC").trim().replaceAll("\\s+", "") : null;
            String phonenumber = request.getParameter("phonenumberC") != null
                    ? request.getParameter("phonenumberC").trim().replaceAll("\\s+", "") : null;
            String email = request.getParameter("emailC") != null
                    ? request.getParameter("emailC").trim().replaceAll("\\s+", "") : null;
            String address = request.getParameter("addressC") != null
                    ? request.getParameter("addressC").trim().replaceAll("\\s+", " ") : null;

            CustomerDAO cdao = new CustomerDAO();
            Customer customer = cdao.getCustomerById(customerId);

            try {
                if (email.isEmpty()) {
                    throw new Exception("Email is required.<br>");
                } else if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                    throw new Exception("Invalid email format.<br>");
                } else {
                    try {
                        InternetAddress emailAddr = new InternetAddress(email);
                        emailAddr.validate();
                    } catch (Exception ex) {
                        throw new Exception("Invalid email address.<br>");
                    }
                }

                if (phonenumber == null || !phonenumber.matches("^(09|03|08|07|05)\\d{8}$")) {
                    throw new Exception("Invalid phone number format. Must be 10 digits starting with 09, 03, 08, 07, or 05");
                }

                if (citizenId == null || !citizenId.matches("^0\\d{11}$")) {
                    throw new Exception("Invalid Citizen ID format. Must be 12 digits starting with 0");
                }

                if (address == null || address.trim().length() < 10 || address.trim().length() > 200) {
                    throw new Exception("Address must be between 10 and 200 characters");
                }

            } catch (Exception e) {
                preserveFormData(customer, citizenId, phonenumber, email, address);
                request.setAttribute("customer", customer);
                request.setAttribute("error", e.getMessage());
                request.getRequestDispatcher("customer/editCustomer.jsp").forward(request, response);
                return;
            }

            if (cdao.checkCustomerUpdate(citizenId, phonenumber, email, customerId)) {
                preserveFormData(customer, citizenId, phonenumber, email, address);
                cdao.updateProfile(customer);

                customer = cdao.getCustomerById(customerId);
                request.setAttribute("customer", customer);
                request.setAttribute("success", "Customer updated successfully!");
            } else {
                preserveFormData(customer, citizenId, phonenumber, email, address);
                request.setAttribute("customer", customer);
                request.setAttribute("error", "Email, phone number or Citizen ID is already in use by another customer!");
            }

            request.getRequestDispatcher("customer/editCustomer.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("customer/editCustomer.jsp").forward(request, response);
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            String customerId = request.getParameter("customerId");
            if (customerId == null || customerId.trim().isEmpty()) {
                response.sendRedirect("manageCustomerVer2/Search");
                return;
            }

            CustomerDAO cdao = new CustomerDAO();
            Customer customer = cdao.getCustomerById(Integer.parseInt(customerId));

            if (customer == null) {
                response.sendRedirect("manageCustomerVer2/Search");
                return;
            }

            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer/editCustomer.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("manageCustomerVer2/Search");
            return;
        }
    }

    private void preserveFormData(Customer customer, String citizenId, String phonenumber, String email, String address) {
        customer.setCid(citizenId);
        customer.setPhonenumber(phonenumber);
        customer.setEmail(email);
        customer.setAddress(address);
    }

}
