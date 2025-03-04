package com.chat.websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@ServerEndpoint("/chat")
public class ChatEndpoint {

    private static final Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
    private static final Map<Session, String> userRoles = Collections.synchronizedMap(new HashMap<>());
    private static final Map<Session, Session> chatPairs = Collections.synchronizedMap(new HashMap<>());

    @OnOpen
    public void onOpen(Session session) {
        // Mặc định mọi user mới vào là khách hàng
        userRoles.put(session, "customer");
        clients.add(session);
        assignChat(session);
    }

    @OnMessage
    public void onMessage(String message, Session senderSession) {
        // Tìm người nhận trong cặp chat
        Session receiverSession = chatPairs.get(senderSession);
        if (receiverSession != null && receiverSession.isOpen()) {
            sendMessageToUser(receiverSession, message);
        } else {
            sendMessageToUser(senderSession, "⚠️ Không có người nhận tin nhắn.");
        }
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        userRoles.remove(session);

        // Nếu user này đang trong một cặp chat
        Session pairedSession = chatPairs.remove(session);
        if (pairedSession != null) {
            chatPairs.remove(pairedSession);
            sendMessageToUser(pairedSession, "⚠️ Đối tác đã ngắt kết nối. Đang tìm người khác...");
            assignChat(pairedSession);
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("WebSocket Error: " + throwable.getMessage());
    }

    // Gán khách hàng với nhân viên rảnh
    private void assignChat(Session userSession) {
        String role = userRoles.getOrDefault(userSession, "customer");
        
        if ("customer".equals(role) && !chatPairs.containsKey(userSession)) {
            for (Session staffSession : clients) {
                if ("staff".equals(userRoles.get(staffSession)) && !chatPairs.containsKey(staffSession) && staffSession.isOpen()) {
                    chatPairs.put(userSession, staffSession);
                    chatPairs.put(staffSession, userSession);
                    
                    sendMessageToUser(userSession, "✅ Bạn đã được kết nối với nhân viên hỗ trợ.");
                    sendMessageToUser(staffSession, "📢 Một khách hàng đã được kết nối với bạn.");
                    return;
                }
            }
            sendMessageToUser(userSession, "⏳ Không có nhân viên nào sẵn sàng. Vui lòng đợi...");
        }
    }

    private void sendMessageToUser(Session session, String message) {
        try {
            session.getBasicRemote().sendText(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
