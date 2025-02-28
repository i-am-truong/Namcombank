/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import Utils.FormatUtils;
import Utils.SearchUtils;
import context.CustomerDAO;
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

/**
 *
 * @author TQT
 */
public class manageCustomerVer2 extends HttpServlet {

    private final CustomerDAO cdao = new CustomerDAO();
    private static final int PAGE_SIZE = 5;

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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        List<Customer> errorCustomers = (List<Customer>) session.getAttribute("errorCustomers");
        String alertImportSuccess = (String) session.getAttribute("alertImportSuccess");
        String alertImportFail = (String) session.getAttribute("alertImportFail");

        if (alertImportSuccess != null) {
            request.setAttribute("alertImportSuccess", alertImportSuccess);
            session.removeAttribute("alertImportSuccess");
            session.removeAttribute("errorCustomers");
        } else if (alertImportFail != null) {
            request.setAttribute("alertImportFail", alertImportFail);
            session.removeAttribute("alertImportFail");
            session.removeAttribute("errorCustomers");
        }

        String pageParam = request.getParameter("page");
        String paraSearch = SearchUtils.preprocessSearchQuery(request.getParameter("search"));
        int page = (FormatUtils.tryParseInt(pageParam) != null) ? FormatUtils.tryParseInt(pageParam) : 1;
        // Lấy page-size từ request, mặc định là PAGE_SIZE
        String pageSizeParam = request.getParameter("page-size");
        String sort = request.getParameter("sort");
        String order = request.getParameter("order");
        Integer pageSize;
        pageSize = (FormatUtils.tryParseInt(pageSizeParam) != null) ? FormatUtils.tryParseInt(pageSizeParam) : PAGE_SIZE;
        //--------------------------------------------------------------------------

        List<Customer> customers = new ArrayList<>();
        int totalCustomers = paraSearch == null || paraSearch.isBlank() ? cdao.getTotalCustomersPage() : cdao.getTotalSearchCustomers(paraSearch);
        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);
        if (page > totalPages) {
            page = totalPages;
        }
        page = page < 1 ? 1 : page;
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
                customers = paraSearch == null || paraSearch.isBlank() ? cdao.getCustomersByPageSorted(page, pageSize, sortSQL, order)
                        : cdao.searchCustomersByPageSorted(paraSearch, page, pageSize, sortSQL, order);
            } else {
                customers = paraSearch == null || paraSearch.isBlank() ? cdao.getCustomersByPage(page, pageSize) : cdao.searchCustomersByPage(paraSearch, page, pageSize);
            }
        } else {
            customers = paraSearch == null || paraSearch.isBlank() ? cdao.getCustomersByPage(page, pageSize) : cdao.searchCustomersByPage(paraSearch, page, pageSize);
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
        pagination.setUrlPattern("/manageCustomerVer2");
        pagination.setSearchFields(new String[]{"search"});
        pagination.setSearchValues(new String[]{paraSearch});
        request.setAttribute("pagination", pagination);
        // Đặt các thuộc tính cho request
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("customers", customers);
        // Chuyển tiếp đến trang JSP để hiển thị
        request.getRequestDispatcher("customer/ManageCustomerVer2.jsp").forward(request, response);
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
        processRequest(request, response);
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
