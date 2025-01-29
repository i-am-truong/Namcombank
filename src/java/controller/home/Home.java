package controller.home;

import context.HomeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.News;

public class Home extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HomeDAO homeDAO = new HomeDAO();
//        ArrayList<Category> categories = homeDAO.getAllCate();
//        List<String> randomImages = homeDAO.getRandomImages(3); // Fetch three random images for hero area
//        List<String> bannerImages = homeDAO.getRandomImages(4); // Fetch four random images for banner area
//        List<Product> products = homeDAO.getAllProducts(); // Fetch all products
//        List<Product> products2 = homeDAO.getLatestProducts(6);
//        List<Product> saleProducts = homeDAO.getAllProducts();
//        List<Product> bestSellingProducts = homeDAO.getAllProducts();
//        List<News> latestNews = homeDAO.getLatestNews(3);
//        // Log the size of products2
//        System.out.println("Number of latest products: " + products2.size());
//        
//        request.setAttribute("categories", categories);
//        request.setAttribute("randomImages", randomImages); // Set random images for hero area
//        request.setAttribute("bannerImages", bannerImages); // Set random images for banner area
//        request.setAttribute("products", products); // Set products as request attribute
//        request.setAttribute("products2", products2);
//        request.setAttribute("saleProducts", saleProducts);
//        request.setAttribute("bestSellingProducts", bestSellingProducts);
//        request.setAttribute("latestNews", latestNews); // Set the latest news as request attribute
        request.getRequestDispatcher("homepage/home.jsp").forward(request, response);
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
        return "HomeServlet";
    }
}
