package com.kcc.trioffice.global.chat_bot;

import java.util.List;
import org.springframework.ai.chat.prompt.ChatOptions;

public class CustomChatBotOptions implements ChatOptions {
  private String model;
  private Double frequencyPenalty = 0.0; // 기본 값 설정
  private Integer maxTokens;
  private Double presencePenalty = 0.0; // 기본 값 설정
  private List<String> stopSequences;
  private Double temperature = 1.0; // 기본 값 설정
  private Integer topK = 0; // 기본 값 설정
  private Double topP = 1.0; // 기본 값 설정

  // 생성자
  public CustomChatBotOptions(String model, Integer maxTokens) {
    this.model = model;
    this.maxTokens = maxTokens;
  }

  @Override
  public String getModel() {
    return model;
  }

  @Override
  public Double getFrequencyPenalty() {
    return frequencyPenalty;
  }

  @Override
  public Integer getMaxTokens() {
    return maxTokens;
  }

  @Override
  public Double getPresencePenalty() {
    return presencePenalty;
  }

  @Override
  public List<String> getStopSequences() {
    return stopSequences;
  }

  @Override
  public Double getTemperature() {
    return temperature;
  }

  @Override
  public Integer getTopK() {
    return topK;
  }

  @Override
  public Double getTopP() {
    return topP;
  }

  @Override
  public ChatOptions copy() {
    CustomChatBotOptions copy = new CustomChatBotOptions(model, maxTokens);
    copy.frequencyPenalty = this.frequencyPenalty;
    copy.presencePenalty = this.presencePenalty;
    copy.stopSequences = this.stopSequences;
    copy.temperature = this.temperature;
    copy.topK = this.topK;
    copy.topP = this.topP;
    return copy;
  }

  // 추가적인 설정 메서드들
  public CustomChatBotOptions setFrequencyPenalty(Double frequencyPenalty) {
    this.frequencyPenalty = frequencyPenalty;
    return this;
  }

  public CustomChatBotOptions setPresencePenalty(Double presencePenalty) {
    this.presencePenalty = presencePenalty;
    return this;
  }

  public CustomChatBotOptions setStopSequences(List<String> stopSequences) {
    this.stopSequences = stopSequences;
    return this;
  }

  public CustomChatBotOptions setTemperature(Double temperature) {
    this.temperature = temperature;
    return this;
  }

  public CustomChatBotOptions setTopK(Integer topK) {
    this.topK = topK;
    return this;
  }

  public CustomChatBotOptions setTopP(Double topP) {
    this.topP = topP;
    return this;
  }
}
