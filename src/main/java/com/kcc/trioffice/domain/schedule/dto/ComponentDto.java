package com.kcc.trioffice.domain.schedule.dto;

import java.io.Serializable;

import lombok.Data;
import lombok.experimental.SuperBuilder;
import java.sql.Timestamp;

@Data
public class ComponentDto implements Serializable {
  private Long writer;
  private Timestamp writeDt;
  private Long modifier;
  private Timestamp modifiedDt;
  private String isDeleted;

}
