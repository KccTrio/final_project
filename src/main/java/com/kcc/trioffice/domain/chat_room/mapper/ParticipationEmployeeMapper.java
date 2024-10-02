package com.kcc.trioffice.domain.chat_room.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ParticipationEmployeeMapper {

    public int saveParticipationEmployee(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId, @Param("writer") Long writer);
}
