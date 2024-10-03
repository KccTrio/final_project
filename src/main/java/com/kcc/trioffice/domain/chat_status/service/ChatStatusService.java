package com.kcc.trioffice.domain.chat_status.service;

import com.kcc.trioffice.domain.chat_status.dto.response.ChatStatusInfo;
import com.kcc.trioffice.domain.chat_status.dto.response.EmoticonMessage;
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

    @Transactional
    public EmoticonMessage updateEmoticon(Long chatId, String emoticonType, Long employeeId) {
        ChatStatusInfo chatStatusInfo = chatStatusMapper.getChatStatusByChatIdAndEmployeeId(chatId, employeeId).orElseThrow(
                () -> new NotFoundException("채팅 상태 정보가 존재하지 않습니다."));
        long emoticonTypeNumber = EmoticonType.toValue(emoticonType);

        if (chatStatusInfo.getEmoticonType() == null || chatStatusInfo.getEmoticonType() == emoticonTypeNumber) {
            chatStatusMapper.updateEmoticon(chatId, employeeId, emoticonTypeNumber, true);
            return new EmoticonMessage("EMOTICON", chatId, employeeId, emoticonType, true);

        } else {
            chatStatusMapper.updateEmoticon(chatId, employeeId, emoticonTypeNumber, false);
            return new EmoticonMessage("EMOTICON", chatId, employeeId, emoticonType, false);
        }
    }
}
