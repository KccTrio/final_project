package com.kcc.trioffice.domain.chat_bot.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.kcc.trioffice.domain.schedule.dto.ComponentDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
public class ChatBot extends ComponentDto {
  private String name;
  private String message;

}
