/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import context.CustomerDAO;
import controller.auth.BaseRBACControlller;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import model.auth.Staff;

/**
 *
 * @author TQT
 */
public class viewCustomer extends BaseRBACControlller {

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
            out.println("<title>Servlet viewCustomer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewCustomer at " + request.getContextPath() + "</h1>");
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
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            CustomerDAO cdao = new CustomerDAO();
            Customer customer = cdao.getCustomerById(customerId);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer/viewCustomer.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            doAuthorizedGet(request, response, account);
        } catch (Exception e) {
            doAuthorizedGet(request, response, account);
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            // Get customerId from request parameter
            String customerIdStr = request.getParameter("customerId");
            if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
                response.sendRedirect("manageCustomer");
                return;
            }

            int customerId = Integer.parseInt(customerIdStr);
            CustomerDAO cdao = new CustomerDAO();
            Customer customer = cdao.getCustomerDetail(customerId);

            if (customer == null) {
                // Customer not found
                response.sendRedirect("manageCustomer");
                return;
            }

            // Set the customer object as a request attribute
            request.setAttribute("customer", customer);

            // Forward to the JSP page
            request.getRequestDispatcher("customer/viewCustomer.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Invalid customer ID format
            response.sendRedirect("manageCustomer");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageCustomer");
        }
    }

}
