package com.kcc.trioffice.domain.schedule.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class ScheduleMaster implements Serializable {
  private String employeeName;
  private String deptName;
}