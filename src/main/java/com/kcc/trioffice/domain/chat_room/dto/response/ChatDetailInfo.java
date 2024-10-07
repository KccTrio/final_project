package com.kcc.trioffice.domain.chat_room.dto.response;

import lombok.Data;

@Data
public class ChatDetailInfo {

    private Long chatId;
    private Long chatroomId;
    private String contents;
    private Long chatType;
    private Long senderId;
}
