package controller.Asset;

import context.AssetDAO;
import context.CustomerDAO;
import controller.auth.BaseRBACControlller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import model.Asset;
import model.auth.Staff;

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
        try {
            // Get form information
            String customerIdStr = request.getParameter("customer_id");
            String assetType = request.getParameter("asset_type");
            String assetName = request.getParameter("asset_name");
            String assetValueStr = request.getParameter("asset_value");
            String description = request.getParameter("description");

            // Get staff ID from session
            int staffId = account.getId();

            // Create map to store errors
            Map<String, String> errors = new HashMap<>();

            // Validate data
            int customerId = 0;
            if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
                errors.put("customer_id", "Vui lòng chọn khách hàng");
            } else {
                try {
                    customerId = Integer.parseInt(customerIdStr);
                    // Check if customer exists
                    if (customerDAO.getCustomerById(customerId) == null) {
                        errors.put("customer_id", "Khách hàng không tồn tại");
                    }
                } catch (NumberFormatException e) {
                    errors.put("customer_id", "ID khách hàng không hợp lệ");
                }
            }

            if (assetType == null || assetType.trim().isEmpty()) {
                errors.put("asset_type", "Vui lòng chọn loại tài sản");
            } else if (!assetType.equals("REAL_ESTATE") && !assetType.equals("VEHICLE")
                    && !assetType.equals("INCOME") && !assetType.equals("OTHER")) {
                errors.put("asset_type", "Loại tài sản không hợp lệ");
            }

            if (assetName == null || assetName.trim().isEmpty()) {
                errors.put("asset_name", "Vui lòng nhập tên tài sản");
            } else if (assetName.length() > 100) {
                errors.put("asset_name", "Tên tài sản không được vượt quá 100 ký tự");
            }

            // Validate asset value (simplified - frontend already handles most validation)
            BigDecimal assetValue = null;
            if (assetValueStr == null || assetValueStr.trim().isEmpty()) {
                errors.put("asset_value", "Vui lòng nhập giá trị tài sản");
            } else {
                try {
                    // The JS already removes formatting before submission
                    assetValue = new BigDecimal(assetValueStr);
                    
                    // Simple validation for negative values
                    if (assetValue.compareTo(BigDecimal.ZERO) <= 0) {
                        errors.put("asset_value", "Giá trị tài sản phải lớn hơn 0");
                    }
                } catch (NumberFormatException e) {
                    errors.put("asset_value", "Giá trị tài sản không hợp lệ");
                }
            }

            // If there are errors, return to the form with error messages
            if (!errors.isEmpty()) {
                // Save entered values
                request.setAttribute("customer_id", customerIdStr);
                request.setAttribute("asset_type", assetType);
                request.setAttribute("asset_name", assetName);
                request.setAttribute("asset_value", assetValueStr);
                request.setAttribute("description", description);
                request.setAttribute("errors", errors);
                request.setAttribute("customers", customerDAO.getAllCustomers());
                request.setAttribute("viewMode", false);
                
                request.getRequestDispatcher("/customer-assets/addCustomerAsset.jsp").forward(request, response);
                return;
            }

            // Create Asset object
            Asset asset = new Asset();
            asset.setCustomerId(customerId);
            asset.setStaffId(staffId);
            asset.setAssetType(assetType);
            asset.setAssetName(assetName);
            asset.setAssetValue(assetValue);
            asset.setDescription(description);
            asset.setStatus("PENDING");

            // Save to database
            boolean success = assetDAO.insertAsset(asset);

            if (success) {
                // Redirect to asset list
                response.sendRedirect("assets-filter");
            } else {
                // Add failed, display form with error message
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi thêm tài sản. Vui lòng thử lại.");
                
                // Save entered values
                request.setAttribute("customer_id", customerIdStr);
                request.setAttribute("asset_type", assetType);
                request.setAttribute("asset_name", assetName);
                request.setAttribute("asset_value", assetValueStr);
                request.setAttribute("description", description);
                request.setAttribute("customers", customerDAO.getAllCustomers());
                request.setAttribute("viewMode", false);
                
                request.getRequestDispatcher("/customer-assets/addCustomerAsset.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            // Get customer list
            request.setAttribute("customers", customerDAO.getAllCustomers());

            // Get asset_id from URL parameter (if any)
            String assetIdParam = request.getParameter("asset_id");
            if (assetIdParam != null && !assetIdParam.isEmpty()) {
                try {
                    int assetId = Integer.parseInt(assetIdParam);
                    Asset asset = assetDAO.get(assetId);
                    if (asset != null) {
                        request.setAttribute("asset", asset);
                        request.setAttribute("viewMode", true); // View mode
                    }
                } catch (NumberFormatException e) {
                    // Do nothing if asset_id is invalid
                }
            }

            request.getRequestDispatcher("/customer-assets/addCustomerAsset.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("assets");
        }
    }
}
