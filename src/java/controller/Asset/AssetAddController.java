package controller.Asset;

import context.AssetDAO;
import context.CustomerDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import model.Asset;
import model.auth.Staff;

/**
 * @author Asus
 */
public class AssetAddController extends BaseRBACControlller {

    private AssetDAO assetDAO;
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        assetDAO = new AssetDAO();
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        // Lấy thông tin từ form
        String customerIdStr = request.getParameter("customer_id");
        String assetType = request.getParameter("asset_type");
        String assetName = request.getParameter("asset_name");
        String assetValueStr = request.getParameter("asset_value");
        String description = request.getParameter("description");

        // Lấy thông tin nhân viên từ session
        int staffId = account.getId();

        // Tạo map để lưu lỗi
        Map<String, String> errors = new HashMap<>();

        // Validate dữ liệu
        // 1. Kiểm tra customer_id
        int customerId = 0;
        if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
            errors.put("customer_id", "Vui lòng chọn khách hàng");
        } else {
            try {
                customerId = Integer.parseInt(customerIdStr);
                // Kiểm tra khách hàng tồn tại
                if (customerDAO.getCustomerById(customerId) == null) {
                    errors.put("customer_id", "Khách hàng không tồn tại");
                }
            } catch (NumberFormatException e) {
                errors.put("customer_id", "ID khách hàng không hợp lệ");
            }
        }

        // 3. Kiểm tra asset_type
        if (assetType == null || assetType.trim().isEmpty()) {
            errors.put("asset_type", "Vui lòng chọn loại tài sản");
        } else if (!assetType.equals("REAL_ESTATE") && !assetType.equals("VEHICLE")
                && !assetType.equals("INCOME") && !assetType.equals("OTHER")) {
            errors.put("asset_type", "Loại tài sản không hợp lệ");
        }

        // 4. Kiểm tra asset_name
        if (assetName == null || assetName.trim().isEmpty()) {
            errors.put("asset_name", "Vui lòng nhập tên tài sản");
        } else if (assetName.length() > 100) {
            errors.put("asset_name", "Tên tài sản không được vượt quá 100 ký tự");
        }

        // 5. Kiểm tra asset_value
        BigDecimal assetValue = null;
        if (assetValueStr == null || assetValueStr.trim().isEmpty()) {
            errors.put("asset_value", "Vui lòng nhập giá trị tài sản");
        } else {
            try {
                // Loại bỏ dấu phẩy nếu có
                assetValueStr = assetValueStr.replace(",", "");
                assetValue = new BigDecimal(assetValueStr);
                if (assetValue.compareTo(BigDecimal.ZERO) <= 0) {
                    errors.put("asset_value", "Giá trị tài sản phải lớn hơn 0");
                }
            } catch (NumberFormatException e) {
                errors.put("asset_value", "Giá trị tài sản không hợp lệ");
            }
        }

        // Nếu có lỗi, quay lại form với thông báo lỗi
        if (!errors.isEmpty()) {
            // Lưu lại các giá trị đã nhập
            request.setAttribute("customer_id", customerIdStr);
            request.setAttribute("asset_type", assetType);
            request.setAttribute("asset_name", assetName);
            request.setAttribute("asset_value", assetValueStr);
            request.setAttribute("description", description);

            // Lưu lỗi
            request.setAttribute("errors", errors);

            // Lấy lại danh sách khách hàng
            request.setAttribute("customers", customerDAO.getAllCustomers());

            // Quay lại form
            request.getRequestDispatcher("/customer-assets/addCutomerAsset.jsp").forward(request, response);
            return;
        }

        try {
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

            // Lấy ID của tài sản vừa thêm
            int newAssetId = asset.getAssetId();

            // Đặt thông báo thành công
            request.getSession().setAttribute("successMessage", "Tạo tài sản thành công!");

            // Chuyển hướng đến trang chi tiết tài sản vừa thêm
            response.sendRedirect("assets-add?asset_id=" + newAssetId);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());

            // Lưu lại các giá trị đã nhập
            request.setAttribute("customer_id", customerIdStr);
            request.setAttribute("asset_type", assetType);
            request.setAttribute("asset_name", assetName);
            request.setAttribute("asset_value", assetValueStr);
            request.setAttribute("description", description);

            // Lấy lại danh sách khách hàng
            request.setAttribute("customers", customerDAO.getAllCustomers());

            // Quay lại form
            request.getRequestDispatcher("/customer-assets/addCutomerAsset.jsp").forward(request, response);
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            // Lấy danh sách khách hàng với đầy đủ thông tin cần thiết
            request.setAttribute("customers", customerDAO.getAllCustomers());

            // Lấy asset_id từ tham số URL (nếu có)
            String assetIdParam = request.getParameter("asset_id");
            if (assetIdParam != null && !assetIdParam.isEmpty()) {
                try {
                    int assetId = Integer.parseInt(assetIdParam);
                    Asset asset = assetDAO.get(assetId);
                    if (asset != null) {
                        request.setAttribute("asset", asset);
                        request.setAttribute("viewMode", true); // Chế độ xem thông tin
                    }
                } catch (NumberFormatException e) {
                    // Không làm gì nếu asset_id không hợp lệ
                }
            }

            request.getRequestDispatcher("/customer-assets/addCutomerAsset.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("assets");
        }
    }
}
