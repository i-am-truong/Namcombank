/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.loanpackage;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.LoanPackage;
import context.LoanPackageDAO;
import java.io.PrintWriter;
import java.util.Date;

/**
 *
 * @author lenovo
 */
public class UpdateLoanPackageController extends HttpServlet {

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
            out.println("<title>Servlet UpdateLoanPackageController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateLoanPackageController at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Lấy dữ liệu từ form
            int packageId = Integer.parseInt(request.getParameter("package_id"));
            String staffId = request.getParameter("staff_id");
            String packageName = request.getParameter("package_name");
            String loanType = request.getParameter("loan_type");
            String description = request.getParameter("description");
            double interestRate = Double.parseDouble(request.getParameter("interest_rate"));
            double maxAmount = Double.parseDouble(request.getParameter("max_amount"));
            double minAmount = Double.parseDouble(request.getParameter("min_amount"));
            int loanTerm = Integer.parseInt(request.getParameter("loan_term"));
            
            // Kiểm tra staffId có hợp lệ không
            int staffIdInt = (staffId != null && !staffId.isEmpty()) ? Integer.parseInt(staffId) : 1;
            
            Date createdDate = new Date();
            // Tạo đối tượng LoanPackage
            LoanPackage loanPackage = new LoanPackage(
                    0, staffIdInt, packageName, loanType, description,
                    interestRate, maxAmount, minAmount, loanTerm, new java.sql.Date(createdDate.getTime()));

            // Gọi DAO để cập nhật database
            LoanPackageDAO dao = new LoanPackageDAO();
            boolean isUpdated = dao.updateLoanPackage(loanPackage);
            
            if (isUpdated) {
                response.sendRedirect("loanpackage-list.jsp?success=true");
            } else {
                response.sendRedirect("loanpackage-update.jsp?packageId=" + packageId + "&error=update_failed");
            }

        } catch (NumberFormatException e) {
            Logger.getLogger(UpdateLoanPackageController.class.getName()).log(Level.SEVERE, "Lỗi định dạng dữ liệu đầu vào", e);
            response.sendRedirect("loanpackage-update.jsp?error=invalid_input");

        } catch (Exception e) {
            Logger.getLogger(UpdateLoanPackageController.class.getName()).log(Level.SEVERE, "Lỗi hệ thống", e);
            response.sendRedirect("loanpackage-update.jsp?error=system_error");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for updating loan package details";
    }
}
