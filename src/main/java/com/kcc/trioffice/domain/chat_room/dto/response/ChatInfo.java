package com.kcc.trioffice.domain.chat_room.dto.response;

import com.kcc.trioffice.global.enums.ChatType;
import lombok.Data;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

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
    private List<String> tags;
    private Boolean isDeleted;

    public void setChatType(Long chatType) {
        this.chatType = ChatType.toName(chatType);
    }

    public void setTags(String tags) {
        if (tags != null && !tags.isEmpty()) {
            this.tags = Arrays.asList(tags.split(","));
        } else {
            this.tags = Collections.emptyList();
        }
    }
}
