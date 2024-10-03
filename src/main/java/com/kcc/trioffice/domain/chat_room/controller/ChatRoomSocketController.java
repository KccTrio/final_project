package com.kcc.trioffice.domain.chat_room.controller;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatMessage;
import com.kcc.trioffice.domain.chat_room.dto.response.ChatMessageInfo;
import com.kcc.trioffice.domain.chat_room.service.ChatRoomService;
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
    private final ChatRoomService chatRoomService;

    @MessageMapping("/chat/send")
    public void sendChatMessage(ChatMessage chatMessage) {
        log.info("chatMessage: {}", chatMessage);
        ChatMessageInfo chatMessageInfo = chatRoomService.saveChatMessage(chatMessage);
        log.info("chatMessageInfo: {}", chatMessageInfo);

        simpMessagingTemplate.convertAndSend("/sub/chat/room/" + chatMessage.getRoomId(), chatMessageInfo);
    }
}
