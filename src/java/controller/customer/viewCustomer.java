/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import context.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;

/**
 *
 * @author TQT
 */
public class viewCustomer extends HttpServlet {

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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            request.getRequestDispatcher("customer/viewCustomer.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("manageCustomer");
            return;
        } catch (Exception e) {
            response.sendRedirect("manageCustomer");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            CustomerDAO cdao = new CustomerDAO();
            Customer customer = cdao.getCustomerById(customerId);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer/viewCustomer.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            doGet(request, response);
        } catch (Exception e) {
            doGet(request, response);
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

}
