package com.kcc.trioffice.domain.participation_employee.controller;

import com.kcc.trioffice.domain.chat_room.dto.response.ChatMessageInfo;
import com.kcc.trioffice.domain.employee.dto.response.SearchEmployee;
import com.kcc.trioffice.domain.participation_employee.dto.request.AddParticipants;
import com.kcc.trioffice.domain.participation_employee.service.ParticipationEmployeeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/chatrooms/")
public class ParticipationEmployeeRestController {

    private final ParticipationEmployeeService participationEmployeeService;
    private final SimpMessagingTemplate simpMessagingTemplate;

    @GetMapping("/{chatRoomId}/except-participants")
    public ResponseEntity<List<SearchEmployee>> getEmployeesExceptParticipants(@PathVariable Long chatRoomId) {
        return ResponseEntity.ok(participationEmployeeService.getEmployeesExceptParticipants(chatRoomId, 1L));
    }

    @PostMapping("/{chatRoomId}/participants")
    public void addChatRoomEmployee(@PathVariable Long chatRoomId, @RequestBody AddParticipants addParticipants) {
        ChatMessageInfo chatMessageInfo = participationEmployeeService.addParticipants(chatRoomId, addParticipants.getEmployees(), 1L);
        simpMessagingTemplate.convertAndSend("/sub/chat/room/" + chatRoomId, chatMessageInfo);
    }

}
