/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.Asset;

import context.AssetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Asset;

/**
 *
 * @author Asus
 */
@WebServlet("/assets")
public class AssetListController extends HttpServlet {

    private AssetDAO assetDAO;

    @Override
    public void init() {
        assetDAO = new AssetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy tham số lọc theo trạng thái
            String status = request.getParameter("status");

            ArrayList<Asset> assets;

            // Lấy danh sách tài sản theo trạng thái
            if (status != null && !status.equals("all")) {
                assets = assetDAO.getByStatus(status.toUpperCase());
            } else {
                assets = assetDAO.list();
            }

            // Đặt danh sách tài sản vào request attribute
            request.setAttribute("assets", assets);

            // Chuyển đến trang danh sách tài sản
            request.getRequestDispatcher("/WEB-INF/jsp/asset-list.jsp").forward(request, response);

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }
}
