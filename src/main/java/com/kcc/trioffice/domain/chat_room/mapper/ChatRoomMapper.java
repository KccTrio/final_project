package com.kcc.trioffice.domain.chat_room.mapper;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatRoomCreate;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ChatRoomMapper {

    int saveChatRoom(@Param("chatRoomCreate") ChatRoomCreate chatRoomCreate, @Param("writer") Long writer);

}
