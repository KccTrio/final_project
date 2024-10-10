package com.kcc.trioffice.global.event;

import com.kcc.trioffice.domain.chat_room.dto.response.ChatRoomEnter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ptptEvent {

    private final SimpMessagingTemplate simpMessagingTemplate;

    @EventListener
    public void handleChatRoomEnterEvent(ChatRoomEnter chatRoomEnter) {
        simpMessagingTemplate.convertAndSend("/sub/chat/room/" + chatRoomEnter.getRoomId(), chatRoomEnter);
    }
}
