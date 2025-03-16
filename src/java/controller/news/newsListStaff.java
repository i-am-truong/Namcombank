/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.news;

import Utils.SearchUtils;
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
        String sortOrder = request.getParameter("sort"); // Thêm tham số sort để xác định thứ tự sắp xếp
        String searchTitle = SearchUtils.preprocessSearchQuery(request.getParameter("searchTitle"));
        String searchAuthor = SearchUtils.preprocessSearchQuery(request.getParameter("searchAuthor"));

        System.out.println("DEBUG - Search Parameters:");
        System.out.println("Request type parameter: " + type);
        System.out.println("Request view parameter: " + view);
        System.out.println("Request sort parameter: " + sortOrder);
        System.out.println("Search title: " + searchTitle);
        System.out.println("Search author: " + searchAuthor);
        System.out.println("Index page: " + indexPage);
        System.out.println("Role ID: " + roleId);
        System.out.println("Staff ID: " + staffId);

        ArrayList<News> n = new ArrayList<News>();
        int pages = 1;
        int index = indexPage != null ? Integer.parseInt(indexPage) : 1;

        // Nếu là role Admin (roleId = 1), hiển thị tất cả - đơn giản hóa logic
        if (roleId == 1) {
            if (type != null && type.equals("WaitingNews")) {
                // Use search parameters if provided
                if ((searchTitle != null && !searchTitle.trim().isEmpty()) ||
                    (searchAuthor != null && !searchAuthor.trim().isEmpty())) {
                    // Search in waiting news
                    n = dao.getWaitingNewsSortedByDateAndSearch(index, sortOrder, searchTitle, searchAuthor);
                    int count = dao.countWaitingWithSearch(searchTitle, searchAuthor);
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                } else {
                    // No search parameters, use regular waiting news list
                    if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                        n = dao.getWaitingNewsSortedByDate(index, sortOrder);
                    } else {
                        n = dao.paggingWaitingList(index);
                    }
                    int count = dao.countWaiting();
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                }
                request.setAttribute("type", "WaitingNews");
            } else {
                // Mặc định hiển thị tất cả tin đã đăng cho Admin
                if ((searchTitle != null && !searchTitle.trim().isEmpty()) ||
                    (searchAuthor != null && !searchAuthor.trim().isEmpty())) {
                    // Search in published news
                    n = dao.getNewsByTitleAndAuthor(searchTitle, searchAuthor, index, sortOrder);
                    int count = dao.countNewsByTitleAndAuthor(searchTitle, searchAuthor);
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                } else {
                    // No search parameters, use regular published news list
                    if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                        n = dao.getNewsSortedByDate(index, sortOrder);
                    } else {
                        n = dao.pagging(index);
                    }
                    int count = dao.count("");
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                }
                request.setAttribute("type", "News");
            }
        } // Nếu là role khác, hiển thị theo quyền
        else {
            if (view != null && view.equals("myNews") && staffId > 0) {
                // Hiển thị tin cá nhân đã đăng (có thể chỉnh sửa/xóa)
                if ((searchTitle != null && !searchTitle.trim().isEmpty()) ||
                    (searchAuthor != null && !searchAuthor.trim().isEmpty())) {
                    // Search in personal news
                    n = dao.getStaffNewsSortedByDateAndSearch(staffId, index, sortOrder, searchTitle, searchAuthor);
                    int count = dao.countStaffNewsWithSearch(staffId, searchTitle, searchAuthor);
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                } else {
                    // No search parameters, use regular personal news list
                    if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                        n = dao.getStaffNewsSortedByDate(staffId, index, sortOrder);
                    } else {
                        n = dao.getNewsByStaffId(staffId, index);
                    }
                    int count = dao.countNewsByStaffId(staffId);
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                }
                request.setAttribute("type", "News");
                request.setAttribute("view", "myNews");
            } else if (view != null && view.equals("pendingNews") && staffId > 0) {
                // Hiển thị tin cá nhân đang chờ duyệt
                if ((searchTitle != null && !searchTitle.trim().isEmpty()) ||
                    (searchAuthor != null && !searchAuthor.trim().isEmpty())) {
                    // Search in pending personal news
                    n = dao.getPendingStaffNewsSortedByDateAndSearch(staffId, index, sortOrder, searchTitle, searchAuthor);
                    int count = dao.countPendingStaffNewsWithSearch(staffId, searchTitle, searchAuthor);
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                } else {
                    // No search parameters, use regular pending personal news list
                    if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                        n = dao.getPendingStaffNewsSortedByDate(staffId, index, sortOrder);
                    } else {
                        n = dao.getPendingNewsByStaffId(staffId, index);
                    }
                    int count = dao.countPendingNewsByStaffId(staffId);
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                }
                request.setAttribute("type", "News");
                request.setAttribute("view", "pendingNews");
            } else if (view != null && view.equals("roleNews")) {
                // Hiển thị tin của role tương ứng
                if ((searchTitle != null && !searchTitle.trim().isEmpty()) ||
                    (searchAuthor != null && !searchAuthor.trim().isEmpty())) {
                    // Search in role news
                    n = dao.getRoleNewsSortedByDateAndSearch(roleId, index, sortOrder, searchTitle, searchAuthor);
                    int count = dao.countRoleNewsWithSearch(roleId, searchTitle, searchAuthor);
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                } else {
                    // No search parameters, use regular role news list
                    if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                        n = dao.getRoleNewsSortedByDate(roleId, index, sortOrder);
                    } else {
                        n = dao.getNewsByRoleId(roleId, index);
                    }
                    int count = dao.countNewsByRoleId(roleId);
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                }
                request.setAttribute("type", "News");
                request.setAttribute("view", "roleNews");
            } else {
                // Mặc định hiển thị tất cả tin đã đăng (chỉ xem)
                if ((searchTitle != null && !searchTitle.trim().isEmpty()) ||
                    (searchAuthor != null && !searchAuthor.trim().isEmpty())) {
                    // Search in all news
                    n = dao.getNewsByTitleAndAuthor(searchTitle, searchAuthor, index, sortOrder);
                    int count = dao.countNewsByTitleAndAuthor(searchTitle, searchAuthor);
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                } else {
                    // No search parameters, use regular all news list
                    if (sortOrder != null && (sortOrder.equals("newest") || sortOrder.equals("oldest"))) {
                        n = dao.getNewsSortedByDate(index, sortOrder);
                    } else {
                        n = dao.pagging(index);
                    }
                    int count = dao.count("");
                    pages = count == 0 ? 1 : (count % 5 != 0) ? (count / 5) + 1 : count / 5;
                }
                request.setAttribute("type", "News");
                request.setAttribute("view", "allNews");
            }
        }

        System.out.println("DEBUG - Search Results: Found " + n.size() + " news items");
        System.out.println("DEBUG - Total pages: " + pages);

        request.setAttribute("n", n);
        request.setAttribute("pages", pages);
        request.setAttribute("staffId", staffId);
        request.setAttribute("sortOrder", sortOrder); // Lưu thông tin sắp xếp hiện tại
        request.setAttribute("searchTitle", searchTitle);
        request.setAttribute("searchAuthor", searchAuthor);

        // Forward to JSP page
        request.getRequestDispatcher("news/newsListStaff.jsp").forward(request, response);
    }

}
