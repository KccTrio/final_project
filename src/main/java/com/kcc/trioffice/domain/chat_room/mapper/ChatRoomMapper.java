package com.kcc.trioffice.domain.chat_room.mapper;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatRoomCreate;
import com.kcc.trioffice.domain.chat_room.dto.response.ChatRoomInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ChatRoomMapper {

    int saveChatRoom(@Param("chatRoomCreate") ChatRoomCreate chatRoomCreate, @Param("writer") Long writer);
    List<ChatRoomInfo> getChatRoomListByEmployeeId(Long employeeId);

}
