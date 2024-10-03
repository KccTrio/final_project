package com.kcc.trioffice.domain.chat_room.controller;

import com.kcc.trioffice.domain.chat_room.dto.response.ChatRoomDetailInfo;
import com.kcc.trioffice.domain.chat_room.service.ChatRoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ChatRoomRestController {

    private final ChatRoomService chatRoomService;

    @GetMapping("/api/chatrooms/{chatRoomId}")
    public ResponseEntity<ChatRoomDetailInfo> getChatRoomDetailInfo(@PathVariable Long chatRoomId, @RequestParam int limit, @RequestParam int offset) {

        ChatRoomDetailInfo chatRoomDetailInfo = chatRoomService.getChatRoomDetailInfo(chatRoomId, 1L, limit, offset);

        return ResponseEntity.ok(chatRoomDetailInfo);
    }

}
