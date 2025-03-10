/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.news;

import context.NewsDAO;
import controller.auth.BaseRBACControlller;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Customer;
import model.News;
import model.auth.Staff;

/**
 *
 * @author ADMIN
 */
public class newsListStaff extends BaseRBACControlller {

    private final NewsDAO dao = new NewsDAO();

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {

        int nId = Integer.parseInt(request.getParameter("nId"));
        dao.deleteNews(nId);
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Kiểm tra xem có session hay không
        if (session == null || session.getAttribute("roleId") == null) {
            response.sendRedirect("admin.login");
            return;
        }

        int roleId = (int) session.getAttribute("roleId");
        int staffId = -1;

        // Lấy staffId từ session
        if (session.getAttribute("staffId") != null) {
            staffId = (int) session.getAttribute("staffId");
        } else if (session.getAttribute("account") != null) {
            staffId = account.getId();
        }

        // Kiểm tra role hợp lệ
        if (roleId != 1 && roleId != 2 && roleId != 3 && roleId != 4) {
            response.sendRedirect("admin.login");
            return;
        }

        // Lấy các tham số từ request
        String indexPage = request.getParameter("index");
        String type = request.getParameter("type");
        String view = request.getParameter("view"); // Thêm tham số view để phân biệt chế độ xem

        System.out.println("Request type parameter: " + type);
        System.out.println("Request view parameter: " + view);

        ArrayList<News> n = new ArrayList<News>();
        int pages = 1;

        // Nếu là role Admin (roleId = 1), hiển thị tất cả - đơn giản hóa logic
        if (roleId == 1) {
            if (type != null && type.equals("WaitingNews")) {
                // Xử lý tin đang chờ duyệt cho Admin
                int index = indexPage != null ? Integer.parseInt(indexPage) : 1;
                n = dao.paggingWaitingList(index);
                int count = dao.countWaiting();
                pages = count == 0 ? 1 : (count % 4 != 0) ? (count / 4) + 1 : count / 4;
                request.setAttribute("type", "WaitingNews");
            } else {
                // Mặc định hiển thị tất cả tin đã đăng cho Admin
                int index = indexPage != null ? Integer.parseInt(indexPage) : 1;
                n = dao.pagging(index);
                int count = dao.count("");
                pages = count == 0 ? 1 : (count % 4 != 0) ? (count / 4) + 1 : count / 4;
                request.setAttribute("type", "News");
            }
        } // Nếu là role khác, hiển thị theo quyền
        else {
            if (view != null && view.equals("myNews") && staffId > 0) {
                // Hiển thị tin cá nhân đã đăng (có thể chỉnh sửa/xóa)
                int index = indexPage != null ? Integer.parseInt(indexPage) : 1;
                n = dao.getNewsByStaffId(staffId, index);
                int count = dao.countNewsByStaffId(staffId);
                pages = count == 0 ? 1 : (count % 4 != 0) ? (count / 4) + 1 : count / 4;
                request.setAttribute("type", "News");
                request.setAttribute("view", "myNews");
            } else if (view != null && view.equals("pendingNews") && staffId > 0) {
                // Hiển thị tin cá nhân đang chờ duyệt
                int index = indexPage != null ? Integer.parseInt(indexPage) : 1;
                n = dao.getPendingNewsByStaffId(staffId, index);
                int count = dao.countPendingNewsByStaffId(staffId);
                pages = count == 0 ? 1 : (count % 4 != 0) ? (count / 4) + 1 : count / 4;
                request.setAttribute("type", "News");
                request.setAttribute("view", "pendingNews");
            } else if (view != null && view.equals("roleNews")) {
                // Hiển thị tin của role tương ứng
                int index = indexPage != null ? Integer.parseInt(indexPage) : 1;
                n = dao.getNewsByRoleId(roleId, index);
                int count = dao.countNewsByRoleId(roleId);
                pages = count == 0 ? 1 : (count % 4 != 0) ? (count / 4) + 1 : count / 4;
                request.setAttribute("type", "News");
                request.setAttribute("view", "roleNews");
            } else {
                // Mặc định hiển thị tất cả tin đã đăng (chỉ xem)
                int index = indexPage != null ? Integer.parseInt(indexPage) : 1;
                n = dao.pagging(index);
                int count = dao.count("");
                pages = count == 0 ? 1 : (count % 4 != 0) ? (count / 4) + 1 : count / 4;
                request.setAttribute("type", "News");
                request.setAttribute("view", "allNews");
            }
        }

        request.setAttribute("n", n);
        request.setAttribute("pages", pages);
        request.setAttribute("staffId", staffId);

        // Forward to JSP page
        request.getRequestDispatcher("news/newsListStaff.jsp").forward(request, response);
    }

}
