package com.kcc.trioffice.domain.participation_employee.dto.request;

import lombok.Data;

import java.util.List;

@Data
public class AddParticipants {

    List<Long> employees;
}
