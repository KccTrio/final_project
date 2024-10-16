package com.kcc.trioffice.domain.schedule.dto;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data

public class EmployeeSchedules extends ComponentDto {

  private String name;
  private String startedDt;
  private String endedDt;
  private String contents;

}
