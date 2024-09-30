package com.kcc.trioffice.domain.chat_room.controller;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ChatRoomSocketController {

    private final SimpMessagingTemplate simpMessagingTemplate;

    @MessageMapping("/chat/send")
    public void sendChatMessage(ChatMessage chatMessage) {
        log.info("chatMessage: {}", chatMessage);
        simpMessagingTemplate.convertAndSend("/sub/chat/room/" + chatMessage.getRoomId(), chatMessage);
    }
}
