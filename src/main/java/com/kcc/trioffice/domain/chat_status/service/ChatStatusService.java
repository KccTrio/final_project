package com.kcc.trioffice.domain.chat_status.service;

import com.kcc.trioffice.domain.chat_room.dto.response.ChatDetailInfo;
import com.kcc.trioffice.domain.chat_room.mapper.ChatMapper;
import com.kcc.trioffice.domain.chat_status.dto.response.ChatStatusInfo;
import com.kcc.trioffice.domain.chat_status.dto.response.EmoticonMessage;
import com.kcc.trioffice.domain.chat_status.dto.response.EmoticonStatus;
import com.kcc.trioffice.domain.chat_status.mapper.ChatStatusMapper;
import com.kcc.trioffice.global.enums.EmoticonType;
import com.kcc.trioffice.global.exception.type.NotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ChatStatusService {

    private final ChatStatusMapper chatStatusMapper;
    private final ChatMapper chatMapper;

    @Transactional
    public EmoticonMessage updateEmoticon(Long chatId, String emoticonType, Long employeeId) {

        ChatDetailInfo chatDetailInfo = chatMapper.getChatDetailInfo(chatId).orElseThrow(
                () -> new NotFoundException("채팅 정보가 존재하지 않습니다."));

        ChatStatusInfo chatStatusInfo = chatStatusMapper.getChatStatusByChatIdAndEmployeeId(chatId, employeeId).orElseThrow(
                () -> new NotFoundException("채팅 상태 정보가 존재하지 않습니다."));


        long emoticonTypeNumber = EmoticonType.toValue(emoticonType);

        if (chatStatusInfo.getEmoticonType() == null || chatStatusInfo.getEmoticonType() != emoticonTypeNumber ||
                (chatStatusInfo.getEmoticonType() == emoticonTypeNumber && !chatStatusInfo.getIsEmoticon())) {
            chatStatusMapper.updateEmoticon(chatId, employeeId, emoticonTypeNumber, true);
            EmoticonMessage emoticonMessage = new EmoticonMessage("EMOTICON", chatId, chatDetailInfo.getSenderId(), employeeId, emoticonType, true);
            return emoticonMessage;

        } else {
            chatStatusMapper.updateEmoticon(chatId, employeeId, emoticonTypeNumber, false);
            EmoticonMessage emoticonMessage = new EmoticonMessage("EMOTICON", chatId, chatDetailInfo.getSenderId(), employeeId, emoticonType, false);

            return emoticonMessage;
        }
    }

    @Transactional
    public void updateChatStatusRead(Long chatRoomId, Long employeeId) {
        chatStatusMapper.updateChatStatusRead(chatRoomId, employeeId);
    }

    public EmoticonStatus getEmoticonCount(Long chatId, Long employeeId) {
        return chatStatusMapper.getEmoticonCount(chatId, employeeId).orElseThrow(
                () -> new NotFoundException("채팅 상태 정보가 존재하지 않습니다."));
    }
}
