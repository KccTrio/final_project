package com.kcc.trioffice.domain.chat_status.controller;

import com.kcc.trioffice.domain.chat_status.dto.request.UpdateEmoticon;
import com.kcc.trioffice.domain.chat_status.dto.response.EmoticonMessage;
import com.kcc.trioffice.domain.chat_status.dto.response.EmoticonStatus;
import com.kcc.trioffice.domain.chat_status.service.ChatStatusService;
import com.kcc.trioffice.global.auth.PrincipalDetail;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/")
@Slf4j
public class ChatStatusRestController {

    private final ChatStatusService chatStatusService;
    private final SimpMessagingTemplate simpMessagingTemplate;

    @PostMapping("/chatrooms/{chatRoomId}/chats/{chatId}/emoticon")
    public void updateEmoticon(@PathVariable Long chatRoomId,
                               @PathVariable Long chatId,
                               @RequestBody UpdateEmoticon updateEmoticon,
                               @AuthenticationPrincipal PrincipalDetail principalDetail) {
        EmoticonMessage emoticonMessage = chatStatusService
                .updateEmoticon(chatId, updateEmoticon.getEmoticonType(), principalDetail.getEmployeeId());

        simpMessagingTemplate.convertAndSend("/sub/chat/room/" + chatRoomId, emoticonMessage);
    }

    @GetMapping("/chatrooms/{chatRoomId}/chats/{chatId}/emoticon")
    public ResponseEntity<EmoticonStatus> getEmoticonStatus(@PathVariable Long chatRoomId,
                                                            @PathVariable Long chatId,
                                                            @AuthenticationPrincipal PrincipalDetail principalDetail) {
        EmoticonStatus emoticonStatus = chatStatusService
                .getEmoticonCount(chatId, principalDetail.getEmployeeId());
        return ResponseEntity.ok(emoticonStatus);
    }

}
