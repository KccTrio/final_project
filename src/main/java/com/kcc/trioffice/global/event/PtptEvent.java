package com.kcc.trioffice.global.event;

import com.kcc.trioffice.domain.chat_room.dto.response.ChatRoomEnter;
import com.kcc.trioffice.domain.chat_room.dto.response.ParticipantEmployeeInfo;
import com.kcc.trioffice.domain.participation_employee.dto.response.PtptEmpInfos;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
@Slf4j
public class PtptEvent {

    private final SimpMessagingTemplate simpMessagingTemplate;

    @EventListener
    public void handleChatRoomEnterEvent(ChatRoomEnter chatRoomEnter) {
        simpMessagingTemplate.convertAndSend("/sub/chat/room/" + chatRoomEnter.getRoomId(), chatRoomEnter);
    }

    @EventListener
    public void handleChatRoomMessageEvent(PtptEmpInfos ptptEmpInfos) {
        log.info("채팅 목록 메세지 전송 완료");
        ptptEmpInfos.getParticipantEmployeeInfos().forEach(participantEmployeeInfo -> {
            simpMessagingTemplate
                    .convertAndSend("/sub/chatrooms/employees/" + participantEmployeeInfo.getEmployeeId()
                            , participantEmployeeInfo);
        });
    }
}
