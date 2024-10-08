package com.kcc.trioffice.domain.chat_room.controller;

import com.kcc.trioffice.domain.chat_room.dto.response.ChatRoomDetailInfo;
import com.kcc.trioffice.domain.chat_room.dto.response.ChatRoomInfo;
import com.kcc.trioffice.domain.chat_room.service.ChatRoomService;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.global.auth.PrincipalDetail;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/chatrooms")
public class ChatRoomRestController {

    private final ChatRoomService chatRoomService;

    @GetMapping("/{chatRoomId}")
    public ResponseEntity<ChatRoomDetailInfo> getChatRoomDetailInfo(@PathVariable Long chatRoomId,
                                                                    @RequestParam int limit,
                                                                    @RequestParam int offset,
                                                                    @AuthenticationPrincipal PrincipalDetail principalDetail) {

        ChatRoomDetailInfo chatRoomDetailInfo = chatRoomService
                .getChatRoomDetailInfo(chatRoomId, principalDetail.getEmployeeId(), limit, offset);

        return ResponseEntity.ok(chatRoomDetailInfo);
    }

    @GetMapping("/{chatRoomId}/employees")
    public ResponseEntity<List<EmployeeInfo>> getChatRoomEmployees(@PathVariable Long chatRoomId) {
        return ResponseEntity.ok(chatRoomService.getChatRoomEmployees(chatRoomId));
    }

    @GetMapping
    public ResponseEntity<List<ChatRoomInfo>> chatRoomList(@AuthenticationPrincipal PrincipalDetail principalDetail) {
        return ResponseEntity.ok(chatRoomService.getChatRoomList(principalDetail.getEmployeeId()));
    }


}
