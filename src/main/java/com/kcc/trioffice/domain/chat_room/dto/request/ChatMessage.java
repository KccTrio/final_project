package com.kcc.trioffice.domain.chat_room.dto.request;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ChatMessage {

    private String roomId;
    private String sender;
    private String message;
    private LocalDateTime time = LocalDateTime.now();
}
