package com.kcc.trioffice.domain.employee.dto.response;

import lombok.Data;

@Data
public class SearchEmployee {

    private String id;
    private String name;
    private String deptName;
    private String position;
}
