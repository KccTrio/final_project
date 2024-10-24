package com.kcc.trioffice.domain.chat_bot.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kcc.trioffice.domain.chat_bot.domain.ChatBot;
import com.kcc.trioffice.domain.chat_bot.service.ChatBotService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import lombok.RequiredArgsConstructor;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class ChatBotRestController {

  private final ChatBotService chatBotService;

  @PostMapping("/chat-bot")
  public ResponseEntity<Map<String, String>> getClientMessages(@RequestParam String clientMessage) {
    System.out.println("받은 메세지: " + clientMessage);
    Map<String, String> response = chatBotService.getResponseChatBotMessage(clientMessage);
    return ResponseEntity.ok(response);
  }

}
