package com.kcc.trioffice.domain.chat_room.service;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatMessage;
import com.kcc.trioffice.domain.chat_room.dto.request.ChatRoomCreate;
import com.kcc.trioffice.domain.chat_room.dto.response.*;
import com.kcc.trioffice.domain.chat_room.mapper.ChatMapper;
import com.kcc.trioffice.domain.chat_room.mapper.ChatRoomMapper;
import com.kcc.trioffice.domain.chat_status.mapper.ChatStatusMapper;
import com.kcc.trioffice.domain.chat_room.mapper.ParticipationEmployeeMapper;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.service.EmployeeService;
import com.kcc.trioffice.global.exception.type.BadRequestException;
import com.kcc.trioffice.global.exception.type.NotFoundException;
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
    private final EmployeeService employeeService;
    private final ChatMapper chatMapper;
    private final ChatStatusMapper chatStatusMapper;

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

    public ChatRoomDetailInfo getChatRoomDetailInfo(Long chatRoomId, Long employeeId, int limit, int offset) {
        ChatRoomDetailInfo chatRoomDetailInfo = chatRoomMapper.getChatRoomInfo(chatRoomId, employeeId)
                .orElseThrow(() -> new NotFoundException("채팅방이 존재하지 않습니다."));
        List<ChatInfo> chatInfos = chatRoomMapper.getChatInfoByPage(chatRoomId, employeeId, chatRoomDetailInfo.getParticipantCount(), limit, offset);
        chatRoomDetailInfo.setChatInfoList(chatInfos);

        // 해야할 것
        // 해당 채팅방 unreadMessage 읽음처리
        // 해당 채팅방 프로필 사진, 이름, 참여자 수, 채팅 내역, 채팅별 이모티콘 개수, 채팅별 안 읽음 개수, 내가 보냈는지 여부
        log.info("chatRoomDetailInfo : {}", chatRoomDetailInfo);
        return chatRoomDetailInfo;
    }

    @Transactional
    public ChatMessageInfo saveChatMessage(ChatMessage chatMessage) {
        chatMapper.saveChatMessage(chatMessage);

        //채팅 참여자 조회
        List<ParticipantEmployeeInfo> participantEmployeeInfos = participationEmployeeMapper.getEmployeeInfoByChatRoomId(chatMessage.getRoomId());

        //채팅 상태 생성
        for (ParticipantEmployeeInfo participantEmployeeInfo : participantEmployeeInfos) {
            if (participantEmployeeInfo.getEmployeeId().equals(chatMessage.getSenderId()) || participantEmployeeInfo.getIsEntered()) {
                chatStatusMapper.saveChatStatusRead(chatMessage.getRoomId(), chatMessage.getChatId(), chatMessage.getSenderId(), chatMessage.getSenderId());
            } else {
                chatStatusMapper.saveChatStatus(chatMessage.getRoomId(), chatMessage.getChatId(), participantEmployeeInfo.getEmployeeId(), chatMessage.getSenderId());
            }
        }

        EmployeeInfo employeeInfo = employeeService.getEmployeeInfo(chatMessage.getSenderId());
        ChatMessageInfo chatMessageInfo = ChatMessageInfo.of(employeeInfo, chatMessage, participantEmployeeInfos.size()-1);


        return chatMessageInfo;
    }





}
