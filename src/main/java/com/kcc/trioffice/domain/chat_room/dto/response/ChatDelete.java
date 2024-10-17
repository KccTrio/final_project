package com.kcc.trioffice.domain.chat_room.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ChatDelete {

    private Long roomId;
    private String chatType;
    private Long senderId;
    private Long chatId;
}
