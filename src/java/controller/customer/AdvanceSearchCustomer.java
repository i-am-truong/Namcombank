/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import Utils.FormatUtils;
import Utils.SearchUtils;
import context.CustomerDAO;
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
import model.Customer;
import model.Pagination;
import java.sql.Date;
import model.auth.Staff;

/**
 *
 * @author TQT
 */
public class AdvanceSearchCustomer extends BaseRBACControlller {

    private final CustomerDAO cdao = new CustomerDAO();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doAuthorizedPost(HttpServletRequest req, HttpServletResponse resp, Staff account) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        //
        String pageParam = request.getParameter("page");
        String paraSearchUserName = SearchUtils.preprocessSearchQuery(request.getParameter("searchUserName"));
        String paraSearchFullName = SearchUtils.preprocessSearchQuery(request.getParameter("searchFullName"));
        if (paraSearchUserName == null) {
            paraSearchUserName = "";
        }
        if (paraSearchFullName == null) {
            paraSearchFullName = "";
        }
        int page = (FormatUtils.tryParseInt(pageParam) != null) ? FormatUtils.tryParseInt(pageParam) : 1;
        // Lấy page-size từ request, mặc định là PAGE_SIZE
        String pageSizeParam = request.getParameter("page-size");
        String sort = request.getParameter("sort");
        String order = request.getParameter("order");
        String gender = request.getParameter("searchGender");
        Integer genderID = cdao.getGenderID(gender);
        String accountStatus = request.getParameter("searchAccountStatus");
        Integer activeID = cdao.getActiveID(accountStatus);
        String cid = request.getParameter("searchCID");
        String address = request.getParameter("searchAddress");
        String email = request.getParameter("searchEmail");
        String phonenumber = request.getParameter("searchPhoneNumber");
        Integer pageSize;
        pageSize = (FormatUtils.tryParseInt(pageSizeParam) != null) ? FormatUtils.tryParseInt(pageSizeParam) : PAGE_SIZE;
        String paraSearchBalanceMin = request.getParameter("searchBalanceMin");
        String paraSearchBalanceMax = request.getParameter("searchBalanceMax");
        Float searchBalanceMin = (FormatUtils.tryParseFloat(paraSearchBalanceMin) != null) ? FormatUtils.tryParseFloat(paraSearchBalanceMin) : 0;
        Float searchBalanceMax = (FormatUtils.tryParseFloat(paraSearchBalanceMax) != null) ? FormatUtils.tryParseFloat(paraSearchBalanceMax) : cdao.getBalanceMax();

        // Thêm xử lý date range
        String paraSearchDateMin = request.getParameter("searchDateMin");
        String paraSearchDateMax = request.getParameter("searchDateMax");
        Date searchDateMin = null;
        Date searchDateMax = null;

        try {
            if (paraSearchDateMin != null && !paraSearchDateMin.isEmpty()) {
                searchDateMin = Date.valueOf(paraSearchDateMin);
            }
            if (paraSearchDateMax != null && !paraSearchDateMax.isEmpty()) {
                searchDateMax = Date.valueOf(paraSearchDateMax);
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }

        if (searchDateMin == null) {
            searchDateMin = cdao.getMinBirthday();
        }
        if (searchDateMax == null) {
            searchDateMax = cdao.getMaxBirthday();
        }

        // Update customer search to include date range
        List<Customer> customers = new ArrayList<>();
        int totalCustomers = cdao.getTotalSearchCustomersByFields(
                paraSearchUserName, paraSearchFullName, genderID, activeID,
                cid, address, email, phonenumber,
                searchBalanceMin, searchBalanceMax,
                searchDateMin, searchDateMax); // Thêm tham số date range

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

        // Thêm kiểm tra này để đảm bảo totalPages luôn ít nhất là 1
        if (totalPages < 1) {
            totalPages = 1;
        }

        // Kiểm tra trang hiện tại
        if (page > totalPages) {
            page = totalPages;
        }
        if (page < 1) {
            page = 1;
        }

        // Chỉ truy vấn dữ liệu nếu thực sự có kết quả
        if (totalCustomers > 0) {
            if (order != null && sort != null && (order.equals("asc") || order.equals("desc"))) {
                //xac nhan cac tham so de sort truyen vao la dung
                if (sort.equals("email") || sort.equals("fullname") || sort.equals("username") || sort.equals("address")) {
                    String sortSQL;
                    sortSQL = switch (sort) {
                        case "email" ->
                            "email";
                        case "fullname" ->
                            "fullname";
                        case "username" ->
                            "username";
                        default ->
                            "address";
                    };
                    customers = cdao.searchCustomersByFieldsPageSorted(paraSearchUserName, paraSearchFullName, page, pageSize, sortSQL, order, genderID, activeID, cid, address, email, phonenumber, searchBalanceMin, searchBalanceMax, searchDateMin, searchDateMax);
                } else {
                    customers = cdao.searchCustomersByFieldsPage(paraSearchUserName, paraSearchFullName, page, pageSize, genderID, activeID, cid, address, email, phonenumber, searchBalanceMin, searchBalanceMax, searchDateMin, searchDateMax);
                }
            } else {
                customers = cdao.searchCustomersByFieldsPage(paraSearchUserName, paraSearchFullName, page, pageSize, genderID, activeID, cid, address, email, phonenumber, searchBalanceMin, searchBalanceMax, searchDateMin, searchDateMax);
            }
        } else {
            // Nếu không có kết quả, để customers là danh sách rỗng
            customers = new ArrayList<>();
        }

        //Phan trang
        Pagination pagination = new Pagination();
        pagination.setListPageSize(totalCustomers);
        pagination.setCurrentPage(page);
        pagination.setTotalPages(totalPages);
        pagination.setTotalPagesToShow(5);
        pagination.setPageSize(pageSize);
        pagination.setSort(sort);
        pagination.setOrder(order);
        pagination.setUrlPattern("/manageCustomerVer2/Search");
        pagination.setSearchFields(new String[]{"searchFullname", "searchUsername", "searchGender", "searchAccountStatus", "searchCID", "searchAddress", "searchEmail", "searchPhoneNumber"});
        pagination.setSearchValues(new String[]{paraSearchFullName, paraSearchUserName, gender, accountStatus, cid, address, email, phonenumber});
        pagination.setRangeFields(new String[]{"searchBalanceMin", "searchBalanceMax", "searchDateMin", "searchDateMax"});
        pagination.setRangeValues(new Object[]{searchBalanceMin, searchBalanceMax, searchDateMin, searchDateMax});
        request.setAttribute("pagination", pagination);

        // Đặt các thuộc tính cho request
        //        request.setAttribute("quantityMin", componentDAO.getQuantityMin());
//        request.setAttribute("quantityMax", componentDAO.getQuantityMax());
//        request.setAttribute("priceMin", componentDAO.getPriceMin());
//        request.setAttribute("priceMax", componentDAO.getPriceMax());
        request.setAttribute("balanceMin", cdao.getBalanceMin());
        request.setAttribute("balanceMax", cdao.getBalanceMax());
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("genderList", cdao.getListGender());
        request.setAttribute("activeList", cdao.getListActive());
        request.setAttribute("customers", customers);
        // Chuyển tiếp đến trang JSP để hiển thị
        request.getRequestDispatcher("/customer/AdvanceSearchCustomer.jsp").forward(request, response);
    }

}
