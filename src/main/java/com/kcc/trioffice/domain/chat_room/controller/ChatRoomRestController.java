package com.kcc.trioffice.domain.chat_room.controller;

import com.kcc.trioffice.domain.chat_room.dto.response.ChatRoomDetailInfo;
import com.kcc.trioffice.domain.chat_room.service.ChatRoomService;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/chatrooms")
public class ChatRoomRestController {

    private final ChatRoomService chatRoomService;

    @GetMapping("/{chatRoomId}")
    public ResponseEntity<ChatRoomDetailInfo> getChatRoomDetailInfo(@PathVariable Long chatRoomId, @RequestParam int limit, @RequestParam int offset) {

        ChatRoomDetailInfo chatRoomDetailInfo = chatRoomService.getChatRoomDetailInfo(chatRoomId, 1L, limit, offset);

        return ResponseEntity.ok(chatRoomDetailInfo);
    }

    @GetMapping("/{chatRoomId}/employees")
    public ResponseEntity<List<EmployeeInfo>> getChatRoomEmployees(@PathVariable Long chatRoomId) {
        return ResponseEntity.ok(chatRoomService.getChatRoomEmployees(chatRoomId));
    }


}
