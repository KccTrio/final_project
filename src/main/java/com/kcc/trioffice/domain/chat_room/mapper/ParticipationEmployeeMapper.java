package com.kcc.trioffice.domain.chat_room.mapper;

import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Optional;

@Mapper
public interface ParticipationEmployeeMapper {

    int saveParticipationEmployee(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId, @Param("writer") Long writer);
    Optional<EmployeeInfo> getEmployeeByChatRoomIdExceptOneSelf(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId);

}
