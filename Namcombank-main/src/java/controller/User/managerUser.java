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
import java.util.List;
import model.Customer;
import model.Role;

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
        try ( PrintWriter out = response.getWriter()) {
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
//        HttpSession session = request.getSession();
//        Customer o = (Customer) session.getAttribute("user");
//        if (o == null) {
//            response.sendRedirect("login");
//            return; // Ensure the method returns to avoid further execution
//        }
//
//        if (o.equals("Customer")) {
//            CustomerDAO ud = new CustomerDAO();
//            String indexPage = request.getParameter("indexU");
//            String searchU = request.getParameter("searchU");
//            String role = request.getParameter("role");
//            String active = request.getParameter("active");
//            String sortField = request.getParameter("sortField");
//            String sortOrder = request.getParameter("sortOrder");
//
//            if (indexPage == null) {
//                indexPage = "1";
//            }
//
//            if ((searchU == null || searchU.trim().isEmpty()) && (role == null && active == null)) {
//
//                int index1 = Integer.parseInt(indexPage);
////                int count = ud.getListU(1, 9999, null, null).size();
//                int endPage = count / 5;
//                if (count % 5 != 0) {
//                    endPage++;
//                }
////                List<Customer> listU = ud.getListU(index1, 5, sortField, sortOrder);
//                request.setAttribute("endPage", endPage);
//                request.setAttribute("listU", listU);
//                request.setAttribute("countU", count);
//                request.getRequestDispatcher("user/managerUser.jsp").forward(request, response);
//            } else {
//                int index1 = Integer.parseInt(indexPage);
//                int roleId = (role != null && !role.isEmpty()) ? Integer.parseInt(role) : -1;
//                int activeId = (active != null && !active.isEmpty()) ? Integer.parseInt(active) : -1;

//                int count = ud.searchU((searchU != null) ? searchU.trim() : "", roleId, activeId, 0, 999, null, null).size();
//                int endPage = count / 5;
//                if (count % 5 != 0) {
//                    endPage++;
//                }
//                List<Customer> listU = ud.searchU((searchU != null) ? searchU.trim() : "", roleId, activeId, index1, 5, sortField, sortOrder);
//                request.setAttribute("endPage", endPage);
//                request.setAttribute("listU", listU);
//                request.setAttribute("role", roleId);
//                request.setAttribute("active", activeId);
//                request.setAttribute("countU", count);
//                request.getRequestDispatcher("user/managerUser.jsp").forward(request, response);
//            }
//        } else {
//            response.sendRedirect("login");
//       }
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
