package com.kcc.trioffice.domain.schedule.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class ScheduleDetailEmployees implements Serializable {
  private Long employeeId;
  private String employeeName;
  private String deptName;
  private String position;
  private String isParticipated;

}
