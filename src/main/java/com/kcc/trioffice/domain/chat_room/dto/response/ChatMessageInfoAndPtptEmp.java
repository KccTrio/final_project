package com.kcc.trioffice.domain.chat_room.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class ChatMessageInfoAndPtptEmp {

    private List<ParticipantEmployeeInfo> participantEmployeeInfos;
    private ChatMessageInfo chatMessageInfo;
}
