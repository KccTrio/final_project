package com.kcc.trioffice.domain.schedule.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class ComponentDto implements Serializable {
  private Long writer;
  private String writeDt;
  private Long modifier;
  private String modifiedDt;
  private String isDeleted;

}
