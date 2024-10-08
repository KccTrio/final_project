package com.kcc.trioffice.domain.chat_room.dto.response;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatMessage;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.global.enums.ChatType;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class ChatMessageInfo {
    private Long roomId;
    private Long chatId;
    private Long senderId;
    private String senderName;
    private String senderProfileUrl;
    private String chatContents;
    private LocalDateTime chatTime;
    private String chatType;
    private int unreadMessageCount;

    public static ChatMessageInfo of(EmployeeInfo employeeInfo, ChatMessage chatMessage, int unreadMessageCount) {
        return new ChatMessageInfo(
                chatMessage.getRoomId(),
                chatMessage.getChatId(),
                employeeInfo.getEmployeeId(),
                employeeInfo.getName(),
                employeeInfo.getProfileUrl(),
                chatMessage.getMessage(),
                LocalDateTime.now(),
                ChatType.toName(chatMessage.getChatType()),
                unreadMessageCount);
    }
}
