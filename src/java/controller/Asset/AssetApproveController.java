/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Asset;

import context.AssetDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.auth.Role;
import model.auth.Staff;

/**
 *
 * @author Asus
 */

public class AssetApproveController extends HttpServlet {

    private AssetDAO assetDAO;

    @Override
    public void init() {
        assetDAO = new AssetDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int assetId = Integer.parseInt(request.getParameter("asset_id"));
            String note = request.getParameter("note");

            Staff staff = (Staff) request.getSession().getAttribute("staff");

            if (staff == null) {
                request.getSession().setAttribute("errorMessage", "Bạn cần đăng nhập để thực hiện chức năng này!");
                response.sendRedirect("login");
                return;
            }


            boolean success = assetDAO.approveAsset(assetId, staff.getId(), note);

            if (success) {
                request.getSession().setAttribute("successMessage", "Duyệt tài sản thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Không thể duyệt tài sản. Tài sản có thể đã được duyệt hoặc từ chối.");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }

        request.getRequestDispatcher("/customer-assets/viewCustomerAssetApprove.jsp").forward(request, response);
    }

}
