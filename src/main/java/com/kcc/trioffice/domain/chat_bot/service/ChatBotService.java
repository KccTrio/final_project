package com.kcc.trioffice.domain.chat_bot.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatResponse;

import org.springframework.stereotype.Service;

import com.kcc.trioffice.domain.chat_bot.mapper.ChatBotMapper;
import com.kcc.trioffice.global.exception.type.NotFoundException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class ChatBotService {

  private final ChatBotMapper chatBotMapper;
  private final ChatClient chatClient;

  public Map<String, String> getResponseChatBotMessage(String message) {
    ChatResponse chatResponse;
    message = "안녕 반가워 ";
    Map<String, String> response = new HashMap<>();
    String responseMessage = "";
    try {
      responseMessage = chatClient.prompt()
          .user(message)
          .call()
          .content();
    } catch (Exception e) {
      log.info("ai로부터 응답 response 불가" + e);
      new NotFoundException("GPT의 응답을 생성할 수 없습니다." + e);
    }

    response.put("GPT 응답", responseMessage);

    return response;
  }

}
