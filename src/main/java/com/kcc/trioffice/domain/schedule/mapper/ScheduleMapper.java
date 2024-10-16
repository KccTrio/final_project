package com.kcc.trioffice.domain.schedule.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kcc.trioffice.domain.schedule.dto.EmployeeSchedules;

@Mapper
public interface ScheduleMapper {

  List<EmployeeSchedules> getEmployeeSchedules(String employeeId, String startDate, String endDate);

}
