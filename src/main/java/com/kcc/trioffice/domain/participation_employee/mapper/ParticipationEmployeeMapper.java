package com.kcc.trioffice.domain.participation_employee.mapper;

import com.kcc.trioffice.domain.chat_room.dto.response.ParticipantEmployeeInfo;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.dto.response.SearchEmployee;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface ParticipationEmployeeMapper {

    int saveParticipationEmployee(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId, @Param("writer") Long writer);
    List<EmployeeInfo> getEmployeeByChatRoomIdExceptOneSelf(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId);
    List<ParticipantEmployeeInfo> getParticipantEmployeeInfoByChatRoomId(@Param("chatRoomId") Long chatRoomId);
    List<EmployeeInfo> getEmployeeInfoByChatRoomId(@Param("chatRoomId") Long chatRoomId);
    List<SearchEmployee> getEmployeeByChatRoomIdExceptParticipants(@Param("companyId") Long companyId, @Param("chatRoomId") Long chatRoomId);
    int deleteParticipationEmployee(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId);
    int updateIsEntered(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId, @Param("isEntered") boolean isEntered);
    int disconnectChatRoom(Long employeeId);
    List<EmployeeInfo> getPtptEmpInfoByChatIdExceptOneself(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId);
    List<EmployeeInfo> getFcmTokenByChatRoomId(@Param("chatRoomId") Long chatRoomId);
    Optional<ParticipantEmployeeInfo> getPtptptEmpInfo(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId);
    int favoriteChatRoom(@Param("chatRoomId") Long chatRoomId, @Param("employeeId") Long employeeId, @Param("isFavorited") boolean isFavorited);
}
