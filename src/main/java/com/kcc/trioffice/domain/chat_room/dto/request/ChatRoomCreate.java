package com.kcc.trioffice.domain.chat_room.dto.request;

import lombok.Data;

import java.util.List;

@Data
public class ChatRoomCreate {

    private Long chatRoomId;
    private String chatRoomName;
    private List<Long> employees;

}
