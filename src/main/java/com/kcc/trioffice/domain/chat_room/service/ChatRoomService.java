package com.kcc.trioffice.domain.chat_room.service;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatRoomCreate;
import com.kcc.trioffice.domain.chat_room.dto.response.ChatRoomInfo;
import com.kcc.trioffice.domain.chat_room.mapper.ChatRoomMapper;
import com.kcc.trioffice.domain.chat_room.mapper.ParticipationEmployeeMapper;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.global.exception.type.BadRequestException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
@Slf4j
public class ChatRoomService {

    private final ChatRoomMapper chatRoomMapper;
    private final ParticipationEmployeeMapper participationEmployeeMapper;

    @Transactional
    public void createChatRoom(ChatRoomCreate chatRoomCreate, Long employeeId) {
        log.info("chatRoomCreate : {}", chatRoomCreate);
        saveChatRoom(chatRoomCreate, employeeId);
        log.info("chatRoomCreate.getChatRoomId() : {}", chatRoomCreate.getChatRoomId());
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

    public List<ChatRoomInfo> getChatRoomList(Long employeeId) {
        List<ChatRoomInfo> chatRoomInfoList = chatRoomMapper.getChatRoomListByEmployeeId(employeeId);

        for (ChatRoomInfo chatRoomInfo : chatRoomInfoList) {
            log.info("chatRoomInfo : {}", chatRoomInfo);
            if (chatRoomInfo.getParticipantCount() <= 2) {
                EmployeeInfo employeeInfo = participationEmployeeMapper.getEmployeeByChatRoomIdExceptOneSelf(chatRoomInfo.getChatRoomId(),employeeId).orElseThrow(() -> new BadRequestException("채팅방에 참여한 사람이 없습니다."));
                chatRoomInfo.setChatRoomProfileImageUrl(employeeInfo.getProfileUrl());
                if (chatRoomInfo.getChatRoomName() == null) {
                    chatRoomInfo.setChatRoomName(employeeInfo.getName());
                }

            }
            if (chatRoomInfo.getLastMessage() == null) {
                chatRoomInfo.setLastMessage("대화방 생성.");
            }
            if (chatRoomInfo.getLastMessageTime() == null) {
                chatRoomInfo.setLastMessageTime(new Timestamp(System.currentTimeMillis()));
            }
            log.info("chatRoomInfo : {}", chatRoomInfo);

        }

        return chatRoomInfoList;
    }

}
