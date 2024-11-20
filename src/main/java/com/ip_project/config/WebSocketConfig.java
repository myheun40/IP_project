package com.ip_project.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.logging.Logger;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new VideoWebSocketHandler(), "/video-stream")
                .setAllowedOrigins("*");  // 실제 운영환경에서는 구체적인 도메인을 지정하는 것이 좋습니다
    }

    public class VideoWebSocketHandler implements WebSocketHandler {
        private static final Logger logger = Logger.getLogger(VideoWebSocketHandler.class.getName());
        private final List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

        @Override
        public void afterConnectionEstablished(WebSocketSession session) throws Exception {
            logger.info("New WebSocket connection established: " + session.getId());
            sessions.add(session);
        }

        @Override
        public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
            // 비디오 데이터 처리
            if (message instanceof BinaryMessage) {
                // 비디오 스트림 데이터 처리
                BinaryMessage binaryMessage = (BinaryMessage) message;
                byte[] videoData = binaryMessage.getPayload().array();

                // 다른 모든 세션에 비디오 데이터 브로드캐스트
                broadcast(session, new BinaryMessage(videoData));
            } else if (message instanceof TextMessage) {
                // 텍스트 메시지 처리 (메타데이터나 제어 메시지)
                TextMessage textMessage = (TextMessage) message;
                String payload = textMessage.getPayload();
                logger.info("Received message: " + payload);

                // 필요한 경우 텍스트 메시지 처리 로직 추가
            }
        }

        @Override
        public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
            logger.severe("Transport error: " + exception.getMessage());
            sessions.remove(session);
            if (session.isOpen()) {
                session.close();
            }
        }

        @Override
        public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
            logger.info("WebSocket connection closed: " + session.getId() + " with status " + status);
            sessions.remove(session);
        }

        @Override
        public boolean supportsPartialMessages() {
            return false;  // 부분 메시지를 지원하지 않음
        }

        private void broadcast(WebSocketSession sender, WebSocketMessage<?> message) {
            for (WebSocketSession session : sessions) {
                if (!session.equals(sender) && session.isOpen()) {
                    try {
                        session.sendMessage(message);
                    } catch (IOException e) {
                        logger.severe("Failed to send message to session: " + session.getId());
                    }
                }
            }
        }
    }
}