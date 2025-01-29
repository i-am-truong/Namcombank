package controller.home;

import context.HomeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
//import model.Product;

public class GenderProductServlet extends HttpServlet {

    private int getGenderId(String gender) {
        return switch (gender.toLowerCase()) {
            case "men" -> 1;
            case "women" -> 2;
            default -> 3;
        };
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

//        String gender = request.getParameter("gender");
//        String sortBy = request.getParameter("sortBy");
//        if (sortBy == null) {
//            sortBy = "name";
//        }
//
//        int page = 1;
//        int pageSize = 6;
//        if (request.getParameter("page") != null) {
//            page = Integer.parseInt(request.getParameter("page"));
//        }
//
//        int genderId = getGenderId(gender);
//
//        HomeDAO homeDAO = new HomeDAO();
////        List<Product> products = homeDAO.getProductsByGender(genderId, sortBy, page, pageSize);
//        int totalProducts = homeDAO.getTotalProductsByGender(genderId);
//        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
//
//        if (products.isEmpty()) {
//            request.setAttribute("message", "No products available for the selected gender.");
//        }
//
//        request.setAttribute("products", products);
//        request.setAttribute("currentPage", page);
//        request.setAttribute("totalPages", totalPages);
//        request.setAttribute("sortBy", sortBy);
//        request.setAttribute("gender", gender);

        request.getRequestDispatcher("homepage/genderproduct.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
