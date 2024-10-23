package com.kcc.trioffice.domain.chat_bot.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kcc.trioffice.domain.chat_bot.service.ChatBotService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;
import lombok.RequiredArgsConstructor;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class ChatBotRestController {

  private final ChatBotService chatBotService;

  @GetMapping("/chat-bot")
  public ResponseEntity<Map<String, String>> getClientMessages(@RequestBody String message) {
    Map<String, String> response = chatBotService.getResponseChatBotMessage(message);
    return ResponseEntity.ok(response);
  }

}
