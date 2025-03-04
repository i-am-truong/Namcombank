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

            String packageName = request.getParameter("package_name").trim();
            String loanType = request.getParameter("loan_type").trim();
            String description = request.getParameter("description").trim();

            BigDecimal interestRate = new BigDecimal(request.getParameter("interest_rate").trim());
            BigDecimal maxAmount = new BigDecimal(request.getParameter("max_amount").trim());
            BigDecimal minAmount = new BigDecimal(request.getParameter("min_amount").trim());
            int loanTerm = Integer.parseInt(request.getParameter("loan_term").trim());

            Date updatedDate = new Date(System.currentTimeMillis());

            // Tạo đối tượng LoanPackage
            LoanPackage loanPackage = new LoanPackage(
                    packageId, staffId, packageName, loanType, description,
                    interestRate, maxAmount, minAmount, loanTerm, updatedDate);

            // Cập nhật database
            LoanPackageDAO dao = new LoanPackageDAO();
            boolean isUpdated = dao.updateLoanPackage(loanPackage);

            if (isUpdated) {
                response.sendRedirect("loanpackage-list.jsp?success=true");
            } else {
                response.sendRedirect("update-loan-package.jsp?package_id=" + packageId + "&error=Update failed");
            }

        } catch (NumberFormatException e) {
            Logger.getLogger(UpdateLoanPackageController.class.getName()).log(Level.SEVERE, "Lỗi định dạng dữ liệu đầu vào", e);
            response.sendRedirect("update-loan-package.jsp?error=Invalid input");

        } catch (Exception e) {
            Logger.getLogger(UpdateLoanPackageController.class.getName()).log(Level.SEVERE, "Lỗi hệ thống", e);
            response.sendRedirect("update-loan-package.jsp?error=System error");
        }
    }
}
