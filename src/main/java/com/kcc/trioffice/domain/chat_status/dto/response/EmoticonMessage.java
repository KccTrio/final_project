package com.kcc.trioffice.domain.chat_status.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EmoticonMessage {
    private String type;
    private Long chatId;
    private Long senderId;
    private String emoticonType;
    private Boolean isEmoticon;
}
