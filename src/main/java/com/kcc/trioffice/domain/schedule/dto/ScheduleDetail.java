package com.kcc.trioffice.domain.schedule.dto;

import java.util.List;

import lombok.Data;

@Data
public class ScheduleDetail {
  // 사원의 이름, 부서, 참석여부
  private List<ScheduleDetailEmployees> scheduleDetailEmployees;
  private String contents;
  private Long writer;
  private int isMySchedule;
  private ScheduleMaster scheduleMaster;
}
