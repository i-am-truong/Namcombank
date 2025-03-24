/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.chat;

import context.MessageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Message;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "CustomerChatServlet", urlPatterns = {"/CustomerChatServlet"})
public class CustomerChatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customer_id");

        if (customerId == null) {
            response.sendRedirect("../login");
            return;
        }

        int staffId = 1;
        MessageDAO messageDAO = new MessageDAO();
        List<Message> messages = messageDAO.getMessagesBetween(customerId, staffId);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Lặp qua danh sách tin nhắn, kiểm tra nếu người gửi là "customer" thì hiển thị tin nhắn bên phải, còn "staff" hiển thị bên trái.
        for (Message msg : messages) {
            out.println("<div class=\"message "
                    + (msg.getSenderType().equals("customer") ? "customer" : "staff")
                    + "\">" + msg.getContent() + "</div>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customer_id");

        if (customerId == null) {
            response.sendRedirect("login");
            return;
        }

        String content = request.getParameter("content");
        int staffId = Integer.parseInt(request.getParameter("staff_id"));

        if (content != null && !content.trim().isEmpty()) {
            
            Message newMessage = new Message();
            newMessage.setSenderId(customerId);
            newMessage.setReceiverId(staffId);
            newMessage.setSenderType("customer");
            newMessage.setContent(content);
            newMessage.setStatus("sent");

            MessageDAO messageDAO = new MessageDAO();
            messageDAO.insertMessage(newMessage);
        }

        response.sendRedirect("chat/chat_customer.jsp");
    }
}
