package com.kcc.trioffice.domain.participation_employee.dto.response;

import com.kcc.trioffice.domain.chat_room.dto.response.ParticipantEmployeeInfo;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class PtptEmpInfos {

    List<ParticipantEmployeeInfo> participantEmployeeInfos;
}
