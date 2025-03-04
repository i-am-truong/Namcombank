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
import model.Asset;

/**
 *
 * @author Asus
 */

public class AssetDetailController extends HttpServlet {
    private AssetDAO assetDAO;

    @Override
    public void init() {
        assetDAO = new AssetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int assetId = Integer.parseInt(request.getParameter("id"));
            Asset asset = assetDAO.get(assetId);

            if (asset == null) {
                request.getSession().setAttribute("errorMessage", "Tài sản không tồn tại.");
                response.sendRedirect("assets");
                return;
            }

            request.setAttribute("asset", asset);
            request.getRequestDispatcher("/customer-assets/viewCustomerAssetDetail.jsp").forward(request, response);

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("assets");
        }
    }
}