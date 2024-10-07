package com.kcc.trioffice.domain.chat_room.mapper;

import com.kcc.trioffice.domain.chat_room.dto.response.ParticipantEmployeeInfo;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface ParticipationEmployeeMapper {

    int saveParticipationEmployee(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId, @Param("writer") Long writer);
    Optional<EmployeeInfo> getEmployeeByChatRoomIdExceptOneSelf(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId);
    List<ParticipantEmployeeInfo> getParticipantEmployeeInfoByChatRoomId(@Param("chatRoomId") Long chatRoomId);
    List<EmployeeInfo> getEmployeeInfoByChatRoomId(@Param("chatRoomId") Long chatRoomId);

}
