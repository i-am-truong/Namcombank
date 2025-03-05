package controller.Asset;

import context.AssetDAO;
import controller.auth.BaseRBACControlller;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Asset;
import model.auth.Staff;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Controller để hiển thị chi tiết tài sản và xử lý phê duyệt/từ chối tài sản
 */
public class AssetDetailController extends BaseRBACControlller {

    private static final Logger LOGGER = Logger.getLogger(AssetDetailController.class.getName());
    private AssetDAO assetDAO;

    @Override
    public void init() {
        assetDAO = new AssetDAO();
    }

    @Override
    protected void doAuthorizedPost(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            // Lấy các tham số từ form
            String assetIdParam = request.getParameter("asset_id");
            String action = request.getParameter("action");

            // Kiểm tra các tham số bắt buộc
            if (assetIdParam == null || assetIdParam.isEmpty() || action == null || action.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Dữ liệu không hợp lệ.");
                response.sendRedirect("assets-filter");
                return;
            }

            // Parse ID tài sản
            int assetId;
            try {
                assetId = Integer.parseInt(assetIdParam);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "ID tài sản không hợp lệ.");
                response.sendRedirect("assets-filter");
                return;
            }

            // Lấy thông tin tài sản
            Asset asset = assetDAO.get(assetId);
            if (asset == null) {
                request.getSession().setAttribute("errorMessage", "Tài sản không tồn tại.");
                response.sendRedirect("assets-filter");
                return;
            }

            // Lấy roleId từ session hoặc từ đối tượng account
            HttpSession session = request.getSession();
            Integer roleId = (Integer) session.getAttribute("roleId");

            // Nếu vẫn không có roleId, đặt giá trị mặc định
            if (roleId == null) {
                roleId = 0; // Giá trị mặc định không có quyền
            }

            // Xác định quyền duyệt
            boolean canApprove = (roleId == 1 || roleId == 3) && "PENDING".equals(asset.getStatus());
            if (!canApprove) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện hành động này");
                return;
            }
            
            boolean success = false;

            // Xử lý phê duyệt hoặc từ chối
            if ("approve".equals(action)) {
                String note = request.getParameter("note");
                System.out.println("Duyệt tài sản ID: " + assetId + ", Note: " + note);

                success = assetDAO.approveAsset(assetId, account.getId(), note);

                if (success) {
                    System.out.println("Duyệt tài sản thành công, ID: " + assetId);
                    request.getSession().setAttribute("successMessage", "Tài sản đã được phê duyệt thành công.");
                } else {
                    System.out.println("Duyệt tài sản thất bại, ID: " + assetId);
                    request.getSession().setAttribute("errorMessage", "Không thể phê duyệt tài sản. Vui lòng thử lại.");
                }
            } else if ("reject".equals(action)) {
                String reason = request.getParameter("reason");

                if (reason == null || reason.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMessage", "Lý do từ chối không được để trống.");
                    response.sendRedirect("asset-detail?id=" + assetId);
                    return;
                }

                System.out.println("Từ chối tài sản ID: " + assetId + ", Reason: " + reason);
                success = assetDAO.rejectAsset(assetId, account.getId(), reason);

                if (success) {
                    System.out.println("Từ chối tài sản thành công, ID: " + assetId);
                    request.getSession().setAttribute("successMessage", "Tài sản đã bị từ chối.");
                } else {
                    System.out.println("Từ chối tài sản thất bại, ID: " + assetId);
                    request.getSession().setAttribute("errorMessage", "Không thể từ chối tài sản. Vui lòng thử lại.");
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Hành động không hợp lệ.");
            }

            // QUAN TRỌNG: Chuyển hướng về trang filter thay vì trang chi tiết
            // Thêm tham số timestamp để tránh cache
            response.sendRedirect("assets-filter?t=" + System.currentTimeMillis());
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");

        } catch (Exception e) {
            System.err.println("Lỗi khi xử lý phê duyệt/từ chối tài sản: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("assets-filter");
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            String assetIdParam = request.getParameter("id");
            if (assetIdParam == null || assetIdParam.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "ID tài sản không được cung cấp.");
                response.sendRedirect("assets");
                return;
            }

            int assetId;
            try {
                assetId = Integer.parseInt(assetIdParam);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "ID tài sản không hợp lệ: " + assetIdParam);
                response.sendRedirect("assets");
                return;
            }

            Asset asset = assetDAO.get(assetId);
            if (asset == null) {
                request.getSession().setAttribute("errorMessage", "Tài sản không tồn tại.");
                response.sendRedirect("assets");
                return;
            }

            request.setAttribute("asset", asset);

            HttpSession session = request.getSession();
            Integer roleId = (Integer) session.getAttribute("roleId");
            if (roleId == null) {
                roleId = 0;
            }

            boolean canApprove = (roleId == 1 || roleId == 3);

            request.setAttribute("canApprove", canApprove);
            request.setAttribute("isAdmin", roleId == 1);
            request.setAttribute("isHeadOfStaff", roleId == 3);

            request.getRequestDispatcher("/customer-assets/viewCustomerAssetDetail.jsp").forward(request, response);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi hiển thị chi tiết tài sản", e);
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("assets");
        }
    }
}
