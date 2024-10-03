package com.kcc.trioffice.domain.chat_room.mapper;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatMessage;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatMapper {

    int saveChatMessage(ChatMessage chatMessage);
}
