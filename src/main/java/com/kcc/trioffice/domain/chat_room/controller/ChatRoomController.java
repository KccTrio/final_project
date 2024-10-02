package com.kcc.trioffice.domain.chat_room.controller;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatRoomCreate;
import com.kcc.trioffice.domain.chat_room.service.ChatRoomService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ChatRoomController {

    private final ChatRoomService chatRoomService;

    @GetMapping("/chatrooms")
    public String chatRoomList() {
        return "chat_room/chat-room-list";
    }

    @GetMapping("/chatrooms/save")
    public String chatRooms() {
        return "chat_room/chat-room-save";
    }

    @PostMapping("/chatrooms/save")
    public String saveChatRoom(@ModelAttribute ChatRoomCreate chatRoomCreate) { // 유저 아이디 세션에서 받아야 함
        chatRoomService.createChatRoom(chatRoomCreate, 1L);

        return "redirect:/chatrooms";
    }

}
