package com.kcc.trioffice.domain.chat_room.dto.response;

import com.kcc.trioffice.global.enums.ChatType;
import lombok.Data;

import java.sql.Timestamp;

@Data
public class ChatInfo {

    private Long chatId;
    private String chatContents;
    private String chatType;
    private Long senderId;
    private String senderName;
    private String senderProfileUrl;
    private Timestamp chatTime;
    private int checkEmoticonCount;
    private Boolean isClickedCheckEmoticon;
    private int heartEmoticonCount;
    private Boolean isClickedHeartEmoticon;
    private int thumbsUpEmoticonCount;
    private Boolean isClickedThumbsUpEmoticon;
    private int smileEmoticonCount;
    private Boolean isClickedSmileEmoticon;
    private int sadEmoticonCount;
    private Boolean isClickedSadEmoticon;
    private int unreadMessageCount;

    public void setChatType(Long chatType) {
        this.chatType = ChatType.toName(chatType);
    }
}
