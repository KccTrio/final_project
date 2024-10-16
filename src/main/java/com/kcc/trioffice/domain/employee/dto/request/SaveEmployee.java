package com.kcc.trioffice.domain.employee.dto.request;

import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDate;


import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SaveEmployee implements Serializable {
  private Long employeeId;
  private Long deptId;
  private Long companyId;
  private String email;
  private String password;
  private String phoneNum;
  private String externalEmail;
  private String name;
  private LocalDate birth;
  private String profileUrl;
  private String fax;
  private String location;
  private Boolean isReceiveNotification;
  private String position;
  private int status;
  private String statusMessage;
  private Long writer;
  private Timestamp writeDt;
  private Long modifier;
  private Timestamp modifiedDt;
  private Boolean isDeleted;

}
