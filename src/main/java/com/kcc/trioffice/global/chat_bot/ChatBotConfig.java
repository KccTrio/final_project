package com.kcc.trioffice.global.chat_bot;

import org.springframework.ai.chat.client.ChatClient;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.time.Duration;

@Configuration
public class ChatBotConfig {

  @Bean
  ChatClient chatClient(ChatClient.Builder builder) {

    // CustomChatOptions 인스턴스 생성
    CustomChatBotOptions options = new CustomChatBotOptions("gpt-3.5-turbo", 500) // 모델 이름 및 최대 토큰 수 설정
        .setFrequencyPenalty(0.5) // 예시로 주어진 옵션 설정
        .setPresencePenalty(0.5)
        .setTemperature(0.7)
        .setTopK(40)
        .setTopP(0.9);

    return builder
        .defaultOptions(options)
        .build();
  }
}
