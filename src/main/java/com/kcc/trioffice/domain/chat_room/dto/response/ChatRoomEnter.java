package com.kcc.trioffice.domain.chat_room.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class ChatRoomEnter {

    private Long roomId;
    private String chatType;
    private Long senderId;
    private List<Long> unreadMessageIds;
}
