package com.kcc.trioffice.domain.schedule.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class SaveSchedule extends ComponentDto {
  private String name;
  private Timestamp startedDt;
  private Timestamp endedDt;
  private String contents;

}
