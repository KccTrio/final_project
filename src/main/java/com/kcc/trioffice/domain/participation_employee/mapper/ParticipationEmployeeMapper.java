package com.kcc.trioffice.domain.participation_employee.mapper;

import com.kcc.trioffice.domain.chat_room.dto.response.ParticipantEmployeeInfo;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.dto.response.SearchEmployee;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ParticipationEmployeeMapper {

    int saveParticipationEmployee(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId, @Param("writer") Long writer);
    List<EmployeeInfo> getEmployeeByChatRoomIdExceptOneSelf(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId);
    List<ParticipantEmployeeInfo> getParticipantEmployeeInfoByChatRoomId(@Param("chatRoomId") Long chatRoomId);
    List<EmployeeInfo> getEmployeeInfoByChatRoomId(@Param("chatRoomId") Long chatRoomId);
    List<SearchEmployee> getEmployeeByChatRoomIdExceptParticipants(@Param("companyId") Long companyId, @Param("chatRoomId") Long chatRoomId);

}
