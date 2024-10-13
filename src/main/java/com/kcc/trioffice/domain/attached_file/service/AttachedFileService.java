package com.kcc.trioffice.domain.attached_file.service;

import com.kcc.trioffice.domain.attached_file.mapper.AttachedFileMapper;
import com.kcc.trioffice.domain.attached_file.mapper.TagMapper;
import com.kcc.trioffice.domain.chat_room.dto.request.ChatMessage;
import com.kcc.trioffice.domain.chat_room.dto.response.ChatMessageInfo;
import com.kcc.trioffice.domain.chat_room.dto.response.ParticipantEmployeeInfo;
import com.kcc.trioffice.domain.chat_room.mapper.ChatMapper;
import com.kcc.trioffice.domain.chat_room.mapper.ChatRoomMapper;
import com.kcc.trioffice.domain.chat_status.mapper.ChatStatusMapper;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.service.EmployeeService;
import com.kcc.trioffice.domain.participation_employee.mapper.ParticipationEmployeeMapper;
import com.kcc.trioffice.global.enums.ChatType;
import com.kcc.trioffice.global.image.FilePathUtils;
import com.kcc.trioffice.global.image.S3SaveDir;
import com.kcc.trioffice.global.image.dto.response.S3UploadFile;
import com.kcc.trioffice.global.image.service.S3FileService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
@Slf4j
public class AttachedFileService {

    private final S3FileService s3FileService;
    private final ChatMapper chatMapper;
    private final AttachedFileMapper attachedFileMapper;
    private final TagMapper tagMapper;
    private final ChatRoomMapper chatRoomMapper;
    private final EmployeeService employeeService;
    private final ParticipationEmployeeMapper participationEmployeeMapper;
    private final ChatStatusMapper chatStatusMapper;

    @Transactional
    public List<ChatMessageInfo> sendAttachedFile(List<MultipartFile> multipartFiles, List<String> tags, Long chatRoomId, Long employeeId) {
        EmployeeInfo employeeInfo = employeeService.getEmployeeInfo(employeeId);
        log.info("multipartFiles.size : {}", multipartFiles.size());

        List<ChatMessageInfo> chatMessageInfos = new ArrayList<>();

        for (MultipartFile multipartFile : multipartFiles) {
            log.info("multipartFile: {}", multipartFile);

            String s3UploadFilePath = FilePathUtils.createS3UploadFilePath(multipartFile);
            S3UploadFile s3UploadFile = s3FileService.upload(multipartFile, s3UploadFilePath, S3SaveDir.CHAT);

            ChatMessage chatMessage = ChatMessage.builder()
                    .roomId(chatRoomId)
                    .senderId(employeeId)
                    .message(s3UploadFile.getFileName())
                    .chatType(ChatType.convertFileType(s3UploadFile.getFileType()))
                    .build();
            chatMapper.saveChatMessage(chatMessage);

            attachedFileMapper.saveAttachedFile(chatMessage.getChatId(), employeeId, s3UploadFile);
            if (tags != null) {
                tags.forEach(
                        tag -> tagMapper.saveTag(s3UploadFile.getFileId(), tag, employeeId)
                );
            }

            chatRoomMapper.updateChatRoomLastMessage(chatMessage.getRoomId(), chatMessage.getChatId());
            List<ParticipantEmployeeInfo> participantEmployeeInfos = participationEmployeeMapper.getParticipantEmployeeInfoByChatRoomId(chatMessage.getRoomId());

            int unreadCount = 0;

            //채팅 상태 생성
            for (ParticipantEmployeeInfo participantEmployeeInfo : participantEmployeeInfos) {
                if (participantEmployeeInfo.getEmployeeId().equals(chatMessage.getSenderId()) || participantEmployeeInfo.getIsEntered()) {
                    chatStatusMapper.saveChatStatusRead(chatMessage.getRoomId(), chatMessage.getChatId(), participantEmployeeInfo.getEmployeeId(), chatMessage.getSenderId());
                } else {
                    unreadCount++;
                    chatStatusMapper.saveChatStatus(chatMessage.getRoomId(), chatMessage.getChatId(), participantEmployeeInfo.getEmployeeId(), chatMessage.getSenderId());
                }
            }

            ChatMessageInfo chatMessageInfo = null;

            if(s3UploadFile.getFileType() == 1) {
                 chatMessageInfo = ChatMessageInfo.builder()
                        .chatTime(LocalDateTime.now())
                        .chatContents(s3UploadFile.getFileUrl())
                        .chatId(chatMessage.getChatId())
                        .senderName(employeeInfo.getName())
                        .senderId(employeeId)
                        .chatType(ChatType.IMAGE.toString())
                        .roomId(chatRoomId)
                         .tags(tags)
                         .unreadMessageCount(unreadCount)
                        .build();
            } else {
                chatMessageInfo = ChatMessageInfo.builder()
                        .chatTime(LocalDateTime.now())
                        .chatContents(s3UploadFile.getFileName())
                        .chatId(chatMessage.getChatId())
                        .senderName(s3UploadFile.getFileName())
                        .senderId(employeeId)
                        .chatType(ChatType.FILE.toString())
                        .roomId(chatRoomId)
                        .tags(tags)
                        .unreadMessageCount(unreadCount)
                        .build();
            }
            chatMessageInfos.add(chatMessageInfo);
        }
        return chatMessageInfos;
    }
}
