package com.kcc.trioffice.domain.chat_status.mapper;

import com.kcc.trioffice.domain.chat_status.dto.response.ChatStatusInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.Optional;

@Mapper
public interface ChatStatusMapper {

    int saveChatStatus(Long chatRoomId, Long chatId, Long employeeId, Long writer);
    int saveChatStatusRead(Long chatRoomId, Long chatId, Long employeeId, Long writer);
    Optional<ChatStatusInfo> getChatStatusByChatIdAndEmployeeId(Long chatId, Long employeeId);
    int updateEmoticon(Long chatId, Long employeeId, Long emoticonType, boolean isEmoticon);
}
