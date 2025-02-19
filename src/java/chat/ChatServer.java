///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//import jakarta.mail.Session;
//import jakarta.websocket.OnClose;
//import jakarta.websocket.OnMessage;
//import jakarta.websocket.OnOpen;
//import jakarta.websocket.server.PathParam;
//import jakarta.websocket.server.ServerEndpoint;
//import java.io.IOException;
//import java.util.Map;
//import java.util.concurrent.ConcurrentHashMap;
//import javax.websocket.*;
//import javax.websocket.server.PathParam;
//import javax.websocket.server.ServerEndpoint;
//
//package chat;
//
//@ServerEndpoint("/chat/{username}")
//public class ChatServer {
//    // Lưu danh sách user online
//    private static Map<String, Session> users = new ConcurrentHashMap<>();
//
//    @OnOpen
//    public void onOpen(Session session, @PathParam("username") String username) {
//        users.put(username, session);
//    }
//
//    @OnMessage
//    public void onMessage(String message, @PathParam("username") String sender) throws IOException {
//        String[] parts = message.split(":", 2); // message format: "receiver:message"
//        if (parts.length == 2) {
//            String receiver = parts[0].trim();
//            String msg = parts[1].trim();
//            
//            // Gửi tin nhắn đến người nhận
//            Session receiverSession = users.get(receiver);
//            if (receiverSession != null && receiverSession.isOpen()) {
//                receiverSession.getBasicRemote().sendText(sender + ": " + msg);
//            }
//        }
//    }
//
//    @OnClose
//    public void onClose(Session session, @PathParam("username") String username) {
//        users.remove(username);
//    }
//}