package com.kcc.trioffice.domain.chat_room.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatRoomController {

    @GetMapping("/chatrooms")
    public String chatRoomList() {
        return "chat_room/chat-room-list";
    }

    @GetMapping("/chatrooms/save")
    public String chatRooms() {
        return "chat_room/chat-room-save";
    }

}
