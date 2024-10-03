package com.kcc.trioffice.domain.chat_room.dto.request;

import lombok.Data;

@Data
public class ChatMessage {

    private Long roomId;
    private Long senderId;
    private String message;
    private String chatType;
    private Long chatId;

}
