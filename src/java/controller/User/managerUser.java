/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.User;

import context.CustomerDAO;
import context.StaffAccountDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import model.Role;
import model.auth.Staff;

/**
 *
 * @author lenovo
 */
public class managerUser extends HttpServlet {

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
            out.println("<title>Servlet managerUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet managerUser at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("account");
        if (staff == null) {
            response.sendRedirect("admin.login");
            return;
        }

        CustomerDAO cdao = new CustomerDAO();

        // Get parameters
        String indexPage = request.getParameter("indexC");
        String searchC = request.getParameter("searchC");
        String active = request.getParameter("active");
        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");

        // Default page index to 1 if not specified
        int currentPage = 1;
        try {
            currentPage = (indexPage != null) ? Integer.parseInt(indexPage) : 1;
            if (currentPage < 1) currentPage = 1;
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        // Parse active parameter
        int activeId = -1;
        if (active != null && !active.isEmpty()) {
            try {
                activeId = Integer.parseInt(active);
                if (activeId != 0 && activeId != 1) {
                    activeId = -1;
                }
            } catch (NumberFormatException e) {
                activeId = -1;
            }
        }

        // Items per page
        final int ITEMS_PER_PAGE = 5;

        // Get total count
        int totalCustomers = cdao.getTotalCustomerCount(searchC, activeId);

        // Calculate total pages
        int totalPages = (totalCustomers + ITEMS_PER_PAGE - 1) / ITEMS_PER_PAGE;

        // Ensure current page is within valid range
        if (currentPage > totalPages) currentPage = totalPages;

        // Get customers for current page
        List<Customer> customers = cdao.searchCustomers(
            searchC != null ? searchC.trim() : "",
            activeId,
            currentPage,
            ITEMS_PER_PAGE,
            sortField,
            sortOrder
        );

        // Set request attributes
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("customers", customers);
        request.setAttribute("countC", totalCustomers);
        request.setAttribute("active", activeId);

        // Maintain search parameters for pagination links
        request.setAttribute("searchC", searchC);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);

        // Forward to JSP
        request.getRequestDispatcher("user/managerUser.jsp").forward(request, response);
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
        processRequest(request, response);
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
