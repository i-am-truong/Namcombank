package controller.savingContract;

import context.SavingDao;
import controller.auth.BaseRBACControlller;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.SavingPackage_id;
import model.auth.Staff;

/**
 *
 * @author admin
 */
public class updateSaving extends BaseRBACControlller {

    private final SavingDao dao = new SavingDao();

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
            out.println("<title>Servlet updateSaving</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateSaving at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        String saving_package_idStr = request.getParameter("saving_package_id");
        String action = request.getParameter("action");
        int saving_package_id = Integer.parseInt(saving_package_idStr);

        String saving_package_updated_at = getCurrentDate();
        if ("approved".equals(action)) {
            dao.acceptSavingPackageRequest(saving_package_updated_at, saving_package_id);

        } else if ("rejected".equals(action)) {
            dao.rejectSavingPackageRequest(saving_package_updated_at, saving_package_id);
        }
        List<SavingPackage_id> list = dao.getAllSavingPackageRequest();
        request.setAttribute("list", list);
//        request.getRequestDispatcher("updateSaving").forward(request, response);
        response.sendRedirect("updateSaving");
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null || (int) session.getAttribute("roleId") != 1) {
            response.sendRedirect("admin.login");
            return;
        }

        List<SavingPackage_id> list = dao.getAllSavingPackageRequest();
        request.setAttribute("list", list);
        request.getRequestDispatcher("SavingPackage/updateSaving.jsp").forward(request, response);
    }

    private String getCurrentDate() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return currentDate.format(formatter);
    }
}
