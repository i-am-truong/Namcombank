/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.Asset;

import context.AssetDAO;
import context.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import model.Asset;

/**
 *
 * @author Asus
 */
public class AssetAddController extends HttpServlet {

    private AssetDAO assetDAO;

    @Override
    public void init() {
        assetDAO = new AssetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách khách hàng để hiển thị trong form
        CustomerDAO customerDAO = new CustomerDAO();
        request.setAttribute("customers", customerDAO.list());

        request.getRequestDispatcher("/WEB-INF/jsp/asset-add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin từ form
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            int staffId = Integer.parseInt(request.getParameter("staff_id"));
            String assetType = request.getParameter("asset_type");
            String assetName = request.getParameter("asset_name");
            BigDecimal assetValue = new BigDecimal(request.getParameter("asset_value"));
            String description = request.getParameter("description");

            // Tạo đối tượng Asset
            Asset asset = new Asset();
            asset.setCustomerId(customerId);
            asset.setStaffId(staffId);
            asset.setAssetType(assetType);
            asset.setAssetName(assetName);
            asset.setAssetValue(assetValue);
            asset.setDescription(description);
            asset.setStatus("PENDING");

            // Lưu vào database
            assetDAO.insert(asset);

            // Chuyển hướng về trang danh sách tài sản với thông báo thành công
            request.getSession().setAttribute("successMessage", "Tạo tài sản thành công!");
            response.sendRedirect("assets");

        } catch (Exception e) {
            // Xử lý lỗi
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("asset-add");
        }
    }
}
