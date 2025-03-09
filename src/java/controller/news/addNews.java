/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.news;

import context.NewsDAO;
import context.StaffAccountDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.News;

/**
 *
 * @author ADMIN
 */
public class addNews extends HttpServlet {

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
         HttpSession session = request.getSession(false);

        // The logical error is in this if condition - it's using OR logic incorrectly
        // Fix: Check if session exists and user has valid role (1, 2, 3, or 4)
        if (session == null || session.getAttribute("roleId") == null) {
            response.sendRedirect("admin.login");
            return;
        }

        int roleId = (int) session.getAttribute("roleId");
        if (roleId != 1 && roleId != 2 && roleId != 3 && roleId != 4) {
            response.sendRedirect("admin.login");
            return;
        } else {
            request.getRequestDispatcher("news/addNews.jsp").forward(request, response);
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
        News news = new News();

        // Lấy staffId từ session hoặc từ parameter
        HttpSession session = request.getSession(false);
        int staffId = 0;

        if (session != null) {
            // Nếu staffId đã được lưu trong session thì lấy trực tiếp
            if (session.getAttribute("staffId") != null) {
                staffId = (int) session.getAttribute("staffId");
            }
            // Nếu chỉ có roleId và account thì lấy staffId từ account
            else if (session.getAttribute("account") != null) {
                model.auth.Staff account = (model.auth.Staff) session.getAttribute("account");
                staffId = account.getId();
            }
            // Nếu không có cả staffId lẫn account,
            // nhưng có username thì truy vấn DB để lấy staffId
            else if (session.getAttribute("username") != null) {
                String username = (String) session.getAttribute("username");
                StaffAccountDBContext dbContext = new StaffAccountDBContext();
                staffId = dbContext.getStaffIdByUsername(username);
            }
        }

        // Nếu vẫn chưa có staffId, thử lấy từ parameter
        if (staffId == 0) {
            try {
                staffId = Integer.parseInt(request.getParameter("authorId"));
            } catch (NumberFormatException e) {
                System.out.println("Error parsing authorId: " + e.getMessage());
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid author ID");
                return;
            }
        }

        // Nếu vẫn không có staffId thì báo lỗi
        if (staffId == 0) {
            System.out.println("Could not determine staff ID");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Staff ID not found");
            return;
        }

        news.setStaff_id(staffId);
        news.setDescription(request.getParameter("body"));
        news.setTitle((request.getParameter("title")));
        news.setStatus(false);

        // Set current date and time
        news.setUpdateDate(new java.util.Date());

        NewsDAO dao = new NewsDAO();
        dao.addNews(news);
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
