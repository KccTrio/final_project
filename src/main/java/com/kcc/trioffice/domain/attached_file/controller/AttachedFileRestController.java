package com.kcc.trioffice.domain.attached_file.controller;

import com.kcc.trioffice.domain.attached_file.dto.response.AttachedFileInfo;
import com.kcc.trioffice.domain.attached_file.service.AttachedFileService;
import com.kcc.trioffice.domain.chat_room.dto.response.ChatMessageInfo;
import com.kcc.trioffice.global.auth.PrincipalDetail;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequiredArgsConstructor
@Slf4j
public class AttachedFileRestController {

    private final AttachedFileService attachedFileService;
    private final SimpMessagingTemplate simpMessagingTemplate;

    @PostMapping("/api/chatrooms/{chatRoomId}/attached-file/send")
    public void sendAttachedFile(@RequestParam(value = "tags", required = false) List<String> tags,
                                 @PathVariable Long chatRoomId,
                                 @AuthenticationPrincipal PrincipalDetail principalDetail,
                                 HttpServletRequest request) {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        List<MultipartFile> multipartFiles = new ArrayList<>(multipartRequest.getFileMap().values());

        List<ChatMessageInfo> chatMessageInfos = attachedFileService.sendAttachedFile(multipartFiles, tags, chatRoomId, principalDetail.getEmployeeId());
        for (ChatMessageInfo chatMessageInfo : chatMessageInfos) {
            simpMessagingTemplate.convertAndSend("/sub/chat/room/" + chatRoomId, chatMessageInfo);
        }
    }

    @GetMapping("/api/chatrooms/{chatRoomId}/chats/{chatId}/attached-file/download")
    public ResponseEntity<byte[]> downloadAttachedFile(@PathVariable Long chatRoomId,
                                                       @PathVariable Long chatId,
                                                       @AuthenticationPrincipal PrincipalDetail principalDetail) {
        return attachedFileService.downloadAttachedFile(chatRoomId, chatId, principalDetail.getEmployeeId());
    }

    @GetMapping("/api/chatrooms/{chatRoomId}/attached-files")
    public ResponseEntity<List<AttachedFileInfo>> getAttachedFile(@PathVariable Long chatRoomId,
                                             @RequestParam int limit,
                                             @RequestParam int offset,
                                             @RequestParam(required = false) List<String> tags,
                                             @AuthenticationPrincipal PrincipalDetail principalDetail) {
        List<AttachedFileInfo> attachedFile = attachedFileService.getAttachedFile(chatRoomId, principalDetail.getEmployeeId(), limit, offset, tags);
        return ResponseEntity.ok(attachedFile);
    }

}
