package com.kcc.trioffice.domain.participation_employee.service;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatMessage;
import com.kcc.trioffice.domain.chat_room.dto.response.ChatMessageInfo;
import com.kcc.trioffice.domain.chat_room.mapper.ChatMapper;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.dto.response.SearchEmployee;
import com.kcc.trioffice.domain.employee.mapper.EmployeeMapper;
import com.kcc.trioffice.domain.participation_employee.mapper.ParticipationEmployeeMapper;
import com.kcc.trioffice.global.enums.ChatType;
import com.kcc.trioffice.global.exception.type.NotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ParticipationEmployeeService {

    private final ParticipationEmployeeMapper participationEmployeeMapper;
    private final EmployeeMapper employeeMapper;
    private final ChatMapper chatMapper;

    public List<SearchEmployee> getEmployeesExceptParticipants(Long chatroomId, Long employeeId) {
        EmployeeInfo employeeInfo = employeeMapper.getEmployeeInfo(employeeId).orElseThrow(() -> new NotFoundException("해당 직원이 존재하지 않습니다."));

        return participationEmployeeMapper.getEmployeeByChatRoomIdExceptParticipants(employeeInfo.getCompanyId(), chatroomId);
    }

    @Transactional
    public ChatMessageInfo addParticipants(Long chatRoomId, List<Long> employees, Long employeeId) {
        List<String> employeeNames = employeeMapper.getEmployeeInfoList(employees);
        EmployeeInfo employeeInfo = employeeMapper.getEmployeeInfo(employeeId).orElseThrow(() -> new NotFoundException("해당 직원이 존재하지 않습니다."));

        String message =  employeeInfo.getName() + "님이 " + String.join(", ", employeeNames) + "님을 초대하였습니다.";

        for (Long participantEmployeeId : employees) {
            participationEmployeeMapper.saveParticipationEmployee(chatRoomId, participantEmployeeId, employeeId);
        }

        ChatMessage chatMessage = ChatMessage.builder()
                .roomId(chatRoomId)
                .senderId(employeeId)
                .message(message)
                .chatType(ChatType.ENTER.getValue())
                .build();

        chatMapper.saveChatMessage(chatMessage);
        return ChatMessageInfo
                .of(employeeInfo, chatMessage, 0);

    }
}