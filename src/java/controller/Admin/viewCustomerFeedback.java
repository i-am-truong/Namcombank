/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

import context.FeedbackDao;
import controller.auth.BaseRBACControlller;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;
import model.auth.Staff;

/**
 *
 * @author admin
 */
public class viewCustomerFeedback extends BaseRBACControlller {

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
            out.println("<title>Servlet viewCustomerFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewCustomerFeedback at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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

        FeedbackDao dao = new FeedbackDao();
        List<Feedback> list = new ArrayList<>();
        String ratingStr = request.getParameter("rating");
        String indexStr = request.getParameter("index");

        int index = 1; // Mặc định trang đầu tiên
        if (indexStr != null && !indexStr.isEmpty()) {
            try {
                index = Integer.parseInt(indexStr);
            } catch (NumberFormatException e) {
                index = 1; // Nếu lỗi, quay về trang đầu
            }
        }

        int rating = 0; // Giá trị mặc định (0 = tất cả)
        if (ratingStr != null && !ratingStr.isEmpty()) {
            try {
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                rating = 0;
            }
        }

        int count;
        if (rating > 0) {
            count = dao.getTotalFeedbackByRating(rating);
            list = dao.pagingFeedbackByRating(index, rating);
        } else {
            count = dao.getTotalFeedback();
            list = dao.pagingFeedback(index);
        }

        int endPage = (count % 4 == 0) ? count / 4 : (count / 4) + 1;

        request.setAttribute("listPaging", list);
        request.setAttribute("endP", endPage);
        request.setAttribute("selectedRating", rating); // Giữ lại giá trị rating
        request.getRequestDispatcher("feedback/viewCustomerFeedback.jsp").forward(request, response);
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        String indexStr = request.getParameter("index");
        int index = 1;

        if (indexStr != null && !indexStr.isEmpty()) {
            try {
                index = Integer.parseInt(indexStr);
            } catch (NumberFormatException e) {
                index = 1;
            }
        }

        String ratingStr = request.getParameter("rating");
        int rating = 0;
        if (ratingStr != null && !ratingStr.isEmpty()) {
            try {
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                rating = 0;
            }
        }

        FeedbackDao dao = new FeedbackDao();
        int count;
        List<Feedback> listPaging;

        if (rating > 0) {
            count = dao.getTotalFeedbackByRating(rating);
            listPaging = dao.pagingFeedbackByRating(index, rating);
        } else {
            count = dao.getTotalFeedback();
            listPaging = dao.pagingFeedback(index);
        }

        int endPage = count / 4;
        if (count % 4 != 0) {
            endPage++;
        }

        request.setAttribute("listPaging", listPaging);
        request.setAttribute("endP", endPage);
        request.setAttribute("selectedRating", rating);
        request.setAttribute("currentPage", index);
        request.getRequestDispatcher("feedback/viewCustomerFeedback.jsp").forward(request, response);

    }

}
