package controller.Asset;

import context.AssetDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import model.Asset;
import model.auth.Staff;

/**
 * Controller for displaying assets list
 *
 * @author Asus
 */
public class AssetListController extends BaseRBACControlller {

    private AssetDAO assetDAO;

    @Override
    public void init() {
        assetDAO = new AssetDAO();
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        doAuthorizedGet(request, response, account);
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            // Ngăn cache để đảm bảo hiển thị dữ liệu mới nhất
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            // Lấy tham số tìm kiếm
            String assetName = request.getParameter("assetName");
            String assetType = request.getParameter("assetType");
            String customerName = request.getParameter("customerName");
            String minValueStr = request.getParameter("minValue");
            String maxValueStr = request.getParameter("maxValue");
            String status = request.getParameter("status");
            String createdDateFrom = request.getParameter("createdDateFrom");
            String createdDateTo = request.getParameter("createdDateTo");
            String approvedBy = request.getParameter("approvedBy"); // Tham số mới
            String approvedDateFrom = request.getParameter("approvedDateFrom");
            String approvedDateTo = request.getParameter("approvedDateTo");


            // Chuyển đổi giá trị tìm kiếm
            BigDecimal minValue = null;
            BigDecimal maxValue = null;

            if (minValueStr != null && !minValueStr.isEmpty()) {
                try {
                    minValue = new BigDecimal(minValueStr);
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Giá trị tối thiểu không hợp lệ");
                }
            }

            if (maxValueStr != null && !maxValueStr.isEmpty()) {
                try {
                    maxValue = new BigDecimal(maxValueStr);
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Giá trị tối đa không hợp lệ");
                }
            }

            // Lấy danh sách tài sản theo điều kiện tìm kiếm
            ArrayList<Asset> assets = assetDAO.searchAssets(
                    assetName, assetType, customerName,
                    minValue, maxValue, status,
                    createdDateFrom, createdDateTo,
                    approvedBy, approvedDateFrom, approvedDateTo
            );


            // Tính toán số lượng tài sản theo trạng thái (cho các card thống kê)
            int totalAssets = assetDAO.countAllAssets();
            int pendingAssets = assetDAO.countAssetsByStatus("PENDING");
            int approvedAssets = assetDAO.countAssetsByStatus("APPROVED");
            int rejectedAssets = assetDAO.countAssetsByStatus("REJECTED");

            // Đặt các thuộc tính vào request
            request.setAttribute("assets", assets);
            request.setAttribute("totalAssets", totalAssets);
            request.setAttribute("pendingAssets", pendingAssets);
            request.setAttribute("approvedAssets", approvedAssets);
            request.setAttribute("rejectedAssets", rejectedAssets);

            // Lưu các tham số tìm kiếm để hiển thị lại trên form
            request.setAttribute("assetName", assetName);
            request.setAttribute("assetType", assetType);
            request.setAttribute("customerName", customerName);
            request.setAttribute("minValue", minValueStr);
            request.setAttribute("maxValue", maxValueStr);
            request.setAttribute("status", status);
            request.setAttribute("createdDateFrom", createdDateFrom);
            request.setAttribute("createdDateTo", createdDateTo);
            request.setAttribute("approvedBy", approvedBy);
            request.setAttribute("approvedDateFrom", approvedDateFrom);
            request.setAttribute("approvedDateTo", approvedDateTo);

            // Chuyển đến trang danh sách tài sản
            request.getRequestDispatcher("/customer-assets/viewCustomerAsset.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Lỗi Controller: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }
}
