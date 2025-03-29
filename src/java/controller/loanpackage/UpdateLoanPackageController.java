package controller.loanpackage;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.LoanPackage;
import context.LoanPackageDAO;

public class UpdateLoanPackageController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int packageId = Integer.parseInt(request.getParameter("package_id").trim());
            int staffId = Integer.parseInt(request.getParameter("staff_id").trim());

            String packageName = request.getParameter("packageName").trim();  // Sửa lại đúng tên tham số trong JSP
            String loanType = request.getParameter("loanType").trim();
            String description = request.getParameter("description").trim();

            BigDecimal interestRate = new BigDecimal(request.getParameter("interestRate").trim());
            BigDecimal maxAmount = new BigDecimal(request.getParameter("maxAmount").trim());
            BigDecimal minAmount = new BigDecimal(request.getParameter("minAmount").trim());
            int loanTerm = Integer.parseInt(request.getParameter("loanTerm").trim());

            Date updatedDate = new Date(System.currentTimeMillis());

            // Tạo đối tượng LoanPackage
            LoanPackage loanPackage = new LoanPackage(
                    packageId, staffId, packageName, loanType, description,
                    interestRate, maxAmount, minAmount, loanTerm, updatedDate);

            // Cập nhật database
            LoanPackageDAO dao = new LoanPackageDAO();
            boolean isUpdated = dao.updateLoanPackage(loanPackage);

            if (isUpdated) {
                response.sendRedirect("loanpackage-list.jsp?success=Update successful");
            } else {
                response.sendRedirect("loanpackage-update.jsp?id=" + packageId + "&error=Update failed");
            }

        } catch (NumberFormatException e) {
            Logger.getLogger(UpdateLoanPackageController.class.getName()).log(Level.SEVERE, "Lỗi định dạng dữ liệu đầu vào", e);
            response.sendRedirect("loanpackage-update.jsp?id=" + request.getParameter("package_id") + "&error=Invalid input");

        } catch (Exception e) {
            Logger.getLogger(UpdateLoanPackageController.class.getName()).log(Level.SEVERE, "Lỗi hệ thống", e);
            response.sendRedirect("loanpackage-update.jsp?id=" + request.getParameter("package_id") + "&error=System error");
        }
    }
}
