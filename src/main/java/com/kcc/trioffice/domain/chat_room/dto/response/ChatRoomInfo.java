package com.kcc.trioffice.domain.chat_room.dto.response;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ChatRoomInfo {

    private Long chatRoomId;
    private String chatRoomName;
    private String chatRoomProfileImageUrl;
    private String lastMessage;
    private Timestamp lastMessageTime;
    private int unreadMessageCount;
    private int participantCount;
}
