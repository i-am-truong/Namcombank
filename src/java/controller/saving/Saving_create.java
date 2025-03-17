/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.saving;

import context.SavingDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import model.Customer;
import model.SavingPackage_id;

/**
 *
 * @author admin
 */
public class Saving_create extends HttpServlet {

    private SavingDao dao = new SavingDao();
    DecimalFormat df = new DecimalFormat("#,###");

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
            out.println("<title>Servlet Saving_create</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Saving_create at " + request.getContextPath() + "</h1>");
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
        if (session.getAttribute("customer") == null) {
            response.sendRedirect("login");
            return;
        } else {

            Integer customer_id = Integer.parseInt(session.getAttribute("customer_id").toString());
            request.setAttribute("customer_id", customer_id);

            String saving_package_withdrawableStr = request.getParameter("saving_package_withdrawable");
            if (saving_package_withdrawableStr == null || saving_package_withdrawableStr.isEmpty()) {
                request.getRequestDispatcher("Saving/Saving_create.jsp").forward(request, response);
                return;
            }
            int saving_package_withdrawable = Integer.parseInt(saving_package_withdrawableStr);

            if (saving_package_withdrawable == 5) {
                request.setAttribute("errorMessage", "Vui lòng chọn gói tiết kiệm hợp lệ.");
                request.getRequestDispatcher("Saving/Saving_create_type.jsp").forward(request, response);
                return;
            }

            List<SavingPackage_id> list = dao.get_saving_package_withdrawable(saving_package_withdrawable);

            String currentDate = getCurrentDate();
            request.setAttribute("currentDate", currentDate);

            request.setAttribute("list", list);
            request.getRequestDispatcher("Saving/Saving_create_type.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        if (session.getAttribute("customer") == null) {
            response.sendRedirect("login");
            return;
        } else {
            String saving_package_idStr = request.getParameter("saving_package_id");
            if (saving_package_idStr == null || saving_package_idStr.trim().isEmpty()) {
                request.setAttribute("message", "Vui lòng chọn gói tiết kiệm.");
                request.getRequestDispatcher("Saving/Saving_create.jsp").forward(request, response);
                return;
            }
            int saving_package_id = Integer.parseInt(saving_package_idStr);
            double money = Double.parseDouble(request.getParameter("money"));
            Integer customer_id = (Integer) session.getAttribute("customer_id");
            String created_at = request.getParameter("created_at");
            String method_money = request.getParameter("method_money");

            double rate = dao.selectRate(saving_package_id) / 100.0; // Chuyển lãi suất từ số bình thường sang phần trăm
            double interest_rate = dao.selectRate(saving_package_id);
            int term_months = dao.selectTerm(saving_package_id); // Lấy số tháng kỳ hạn của gói tiết kiệm
            String saving_package_name = dao.selectSavingPackageName(saving_package_id);
            int saving_package_term_months = dao.selectSaving_package_term_months(saving_package_id);
            Double minMoney = dao.selectMinMoney(saving_package_id);
            Double maxMoney = dao.selectMaxMoney(saving_package_id);
            String customer_name = dao.selectCustomerName(customer_id);

            double amount;
            if (saving_package_term_months > 0) {
                amount = money + money * rate * term_months / 12;
            } else {
                amount = money;
            }
            if (money < minMoney) {
                request.setAttribute("message", "Số tiền quá nhỏ! Vui lòng nhập tối thiểu " + df.format(minMoney));
                request.getRequestDispatcher("Saving/Saving_create.jsp").forward(request, response);
                return;
            }
            if (maxMoney != null && money > maxMoney) {
                request.setAttribute("message", "Số tiền quá lớn! Giới hạn tối đa là " + df.format(maxMoney));
                request.getRequestDispatcher("Saving/Saving_create.jsp").forward(request, response);
                return;
            }
            if (method_money.equals("TRANSFER")) {
                double balance = dao.selectBalance(customer_id);
                if (check(balance, money)) {
                    int saving_request_id = dao.insertSavingRequest_Balance(customer_id, saving_package_id, money, created_at, amount, saving_package_name, customer_name);
                    if (saving_request_id > 0) {
                        LocalDate openedLocalDate = LocalDate.parse(created_at, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        LocalDate moneyGetLocalDate = openedLocalDate.plusMonths(term_months);
                        String money_get_date = moneyGetLocalDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        int saving_withdrawable = dao.selectSaving_package_withdrawable(saving_package_id);

                        dao.AddSavingFinal(customer_id, amount, interest_rate, term_months, created_at, saving_request_id, 0, money_get_date, customer_name, saving_withdrawable);
                        request.setAttribute("message", "Yêu cầu của bạn đã thành công, vui lòng kiểm tra lại tại danh sách tiết kiệm.");
                        request.getRequestDispatcher("Saving/Saving_create.jsp").forward(request, response);
                        return;
                    }
                } else {
                    request.setAttribute("message", "Số tiền còn lại trong tài khoản không đủ " + df.format(balance));
                    request.getRequestDispatcher("Saving/Saving_create.jsp").forward(request, response);
                    return;
                }

            }
            if (method_money.equals("CASH")) {
                dao.insertSavingRequest_Cash(customer_id, saving_package_id, money, created_at, amount, saving_package_name, customer_name);
                request.setAttribute("message", "Yêu cầu của bạn đã được gửi. Vui lòng chờ xác nhận từ ngân hàng.");
                request.getRequestDispatcher("Saving/Saving_create.jsp").forward(request, response);
                return;
            }
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

    private String getCurrentDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(new Date());
    }

    private boolean check(double a, double b) {

        if (a > b) {
            return true;
        } else {
            return false;
        }
    }

}
