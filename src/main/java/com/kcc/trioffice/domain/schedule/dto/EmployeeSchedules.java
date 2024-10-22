package com.kcc.trioffice.domain.schedule.dto;

import lombok.Data;

@Data
public class EmployeeSchedules extends ComponentDto {
  private Long scheduleId;
  private String name;
  private String startedDt;
  private String endedDt;
  private String contents;
  private Long writer;
  private int isMySchedule;

}
