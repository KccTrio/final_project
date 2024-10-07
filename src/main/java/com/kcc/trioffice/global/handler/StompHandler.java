package com.kcc.trioffice.global.handler;

import com.kcc.trioffice.domain.chat_status.service.ChatStatusService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;

@Configuration
@RequiredArgsConstructor
public class StompHandler implements ChannelInterceptor {

    private final ChatStatusService chatStatusService;

    @Override
    public Message<?> preSend(Message<?> message, MessageChannel channel) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);

        if(accessor.getCommand() == StompCommand.CONNECT) {
        } else if(accessor.getCommand() == StompCommand.SUBSCRIBE) {

            String destination = accessor.getDestination();
            Long chatRoomId = Long.valueOf(destination.split("/")[4]);
            chatStatusService.updateChatStatusRead(chatRoomId, 1L);

        } else if (accessor.getCommand() == StompCommand.UNSUBSCRIBE) {

        } else if (accessor.getCommand() == StompCommand.DISCONNECT) {
        }

        return message;
    }

}
