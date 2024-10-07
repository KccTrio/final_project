package com.kcc.trioffice.domain.chat_room.dto.response;

import lombok.Data;

@Data
public class ParticipantEmployeeInfo {

    private Long chatRoomId;
    private Long employeeId;
    private Boolean isFavorited;
    private String chatRoomProfileUrl;
    private Boolean isEntered;
}
