package com.kcc.trioffice.domain.chat_status.dto.response;

import lombok.Data;

@Data
public class ChatStatusInfo {

    private Long chatRoomId;
    private Long employeeId;
    private Long chatId;
    private Boolean isRead;
    private Long emoticonType;
    private Boolean isEmoticon;
}
