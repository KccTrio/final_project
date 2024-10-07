package com.kcc.trioffice.domain.employee.dto.response;

import java.io.Serializable;

import lombok.Data;

@Data
public class AdminInfo implements Serializable {
  private String name;
  private String phoneNum;

}
