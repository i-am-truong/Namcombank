package controller.Asset;

import context.AssetDAO;
import context.CustomerDAO;
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
import model.Customer;

/**
 * Controller to display asset details and handle approval/rejection/deletion of assets
 */
@WebServlet(name = "AssetDetailController", urlPatterns = {"/asset-detail"}) // Added WebServlet annotation
public class AssetDetailController extends BaseRBACControlller {

    private static final Logger LOGGER = Logger.getLogger(AssetDetailController.class.getName());
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
            // Get parameters from form
            String assetIdParam = request.getParameter("asset_id");
            String action = request.getParameter("action");

            LOGGER.info("Processing POST request: asset_id=" + assetIdParam + ", action=" + action);

            // Validate required parameters
            if (assetIdParam == null || assetIdParam.isEmpty() || action == null || action.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Invalid data.");
                response.sendRedirect("assets-filter");
                return;
            }

            // Parse asset ID
            int assetId;
            try {
                assetId = Integer.parseInt(assetIdParam);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid asset ID.");
                response.sendRedirect("assets-filter");
                return;
            }
            
            // Get asset information
            Asset asset = assetDAO.get(assetId);
            if (asset == null) {
                request.getSession().setAttribute("errorMessage", "Asset does not exist.");
                response.sendRedirect("assets-filter");
                return;
            }

            // Get roleId from session or account object
            HttpSession session = request.getSession();
            Integer roleId = (Integer) session.getAttribute("roleId");

            // Set default value if roleId is still null
            if (roleId == null) {
                roleId = 0; // Default value with no permissions
            }

            // Determine approval or deletion rights
            boolean canApprove = (roleId == 1 || roleId == 3);
            boolean canDeletePending = canApprove && "PENDING".equals(asset.getStatus());
            boolean canDelete = canApprove; // Admin and HeadOfStaff can delete all assets
            
            if (("approve".equals(action) || "reject".equals(action)) && !canApprove) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have permission to perform this action");
                return;
            }
            
            if ("delete".equals(action) && !canDelete) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have permission to delete assets");
                return;
            }
            
            boolean success = false;

            // Handle approval, rejection, or deletion
            if ("approve".equals(action)) {
                String note = request.getParameter("note");
                LOGGER.info("Approving asset ID: " + assetId + " with note: " + note);
                
                success = assetDAO.approveAsset(assetId, account.getId(), note);

                if (success) {
                    request.getSession().setAttribute("successMessage", "Asset has been approved successfully.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Could not approve asset. Please try again.");
                }
            } else if ("reject".equals(action)) {
                String reason = request.getParameter("reason");
                LOGGER.info("Rejecting asset ID: " + assetId + " with reason: " + reason);

                if (reason == null || reason.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMessage", "Rejection reason cannot be empty.");
                    response.sendRedirect("asset-detail?id=" + assetId);
                    return;
                }

                success = assetDAO.rejectAsset(assetId, account.getId(), reason);

                if (success) {
                    request.getSession().setAttribute("successMessage", "Asset has been rejected.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Could not reject asset. Please try again.");
                }
            } else if ("delete".equals(action)) {
                // Perform asset deletion
                LOGGER.info("Deleting asset ID: " + assetId);
                success = assetDAO.deleteAsset(assetId);
                
                if (success) {
                    request.getSession().setAttribute("successMessage", "Asset has been deleted successfully.");
                    // Redirect to assets list after deletion
                    response.sendRedirect("assets-filter");
                    return;
                } else {
                    request.getSession().setAttribute("errorMessage", "Could not delete asset. Please try again.");
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Invalid action.");
            }

            // Redirect back to asset detail page or asset list
            if ("delete".equals(action) && success) {
                response.sendRedirect("assets-filter");
            } else {
                response.sendRedirect("asset-detail?id=" + assetId);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing request: ", e);
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("assets-filter");
        }
    }

    @Override
    protected void doAuthorizedGet(HttpServletRequest request, HttpServletResponse response, Staff account) throws ServletException, IOException {
        try {
            String assetIdParam = request.getParameter("id");
            if (assetIdParam == null || assetIdParam.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Asset ID was not provided.");
                response.sendRedirect("assets-filter");
                return;
            }

            int assetId;
            try {
                assetId = Integer.parseInt(assetIdParam);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid asset ID: " + assetIdParam);
                response.sendRedirect("assets-filter");
                return;
            }

            Asset asset = assetDAO.get(assetId);
            if (asset == null) {
                request.getSession().setAttribute("errorMessage", "Asset does not exist.");
                response.sendRedirect("assets-filter");
                return;
            }
            
            // Get customer details
            Customer customer = customerDAO.getCustomerDetail(asset.getCustomerId());
            if (customer != null) {
                request.setAttribute("customer", customer);
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

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error displaying asset details: ", e);
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("assets-filter");
        }
    }
}
