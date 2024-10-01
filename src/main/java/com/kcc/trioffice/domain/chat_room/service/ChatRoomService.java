package com.kcc.trioffice.domain.chat_room.service;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatRoomCreate;
import com.kcc.trioffice.domain.chat_room.mapper.ChatRoomMapper;
import com.kcc.trioffice.domain.chat_room.mapper.ParticipationEmployeeMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class ChatRoomService {

    private final ChatRoomMapper chatRoomMapper;
    private final ParticipationEmployeeMapper participationEmployeeMapper;

    @Transactional
    public void createChatRoom(ChatRoomCreate chatRoomCreate, Long employeeId) {
        saveChatRoom(chatRoomCreate, employeeId);
        saveParticipantEmployee(chatRoomCreate, employeeId);
    }

    private void saveChatRoom(ChatRoomCreate chatRoomCreate, Long employeeId) {
        int result = chatRoomMapper.saveChatRoom(chatRoomCreate, employeeId);
        if (result == 0) {
            throw new RuntimeException("채팅방 생성에 실패하였습니다.");
        }
    }

    private void saveParticipantEmployee(ChatRoomCreate chatRoomCreate, Long employeeId) {
        List<Long> employees = chatRoomCreate.getEmployees();
        for (Long participantEmployeeId : employees) {
                participationEmployeeMapper.saveParticipationEmployee(chatRoomCreate.getChatRoomId(), participantEmployeeId, employeeId);
        }
        participationEmployeeMapper.saveParticipationEmployee(chatRoomCreate.getChatRoomId(), employeeId, employeeId);
    }

}
