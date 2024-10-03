package com.kcc.trioffice.domain.chat_room.dto.response;

import com.kcc.trioffice.domain.chat_room.dto.request.ChatMessage;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class ChatMessageInfo {
    private Long roomId;
    private Long senderId;
    private String senderName;
    private String senderProfileUrl;
    private String chatContents;
    private LocalDateTime chatTime;
    private String type;

    public static ChatMessageInfo of(EmployeeInfo employeeInfo, ChatMessage chatMessage) {
        return new ChatMessageInfo(
                chatMessage.getRoomId(),
                employeeInfo.getEmployeeId(),
                employeeInfo.getName(),
                employeeInfo.getProfileUrl(),
                chatMessage.getMessage(),
                LocalDateTime.now(),
                "CHAT");
    }
}
