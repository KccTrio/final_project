package com.kcc.trioffice.domain.chat_bot.domain;

import com.kcc.trioffice.domain.schedule.dto.ComponentDto;

import lombok.Data;

@Data
public class ChatBot extends ComponentDto {

  private final String name;
  private final String message;
}
