package com.kcc.trioffice.domain.schedule.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.kcc.trioffice.domain.schedule.dto.EmployeeSchedules;
import com.kcc.trioffice.domain.schedule.mapper.ScheduleMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ScheduleService {

  private final ScheduleMapper scheduleMapper;

  public List<EmployeeSchedules> getEmployeeSchedules(String startDate, String endDate) {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    String employeeId = authentication.getName();

    // String[] tmpStartMonth = startDate.split("-");
    // String[] tmpEndMonth = endDate.split("-");

    // int tmpStart = Integer.parseInt(tmpStartMonth[1]);
    // int tmpEnd = Integer.parseInt(tmpEndMonth[1]) + 1;
    // if (tmpStart < 1) {
    // tmpStart = 12;
    // }
    // if (tmpEnd > 12) {
    // tmpEnd = 1;
    // }
    // tmpStartMonth[1] = String.format("%02d", tmpStart);
    // tmpEndMonth[1] = String.format("%02d", tmpEnd);

    // startDate = String.join("-", tmpStartMonth);
    // endDate = String.join("-", tmpEndMonth);
    // System.out.println(startDate + "시작일 " + endDate + "도착일");
    List<EmployeeSchedules> schdules = scheduleMapper.getEmployeeSchedules(employeeId, startDate, endDate);

    for (int i = 0; i < schdules.size(); i++) {
      System.out.println((i + 1) + "번의 일정명은 " + schdules.get(i).getStartedDt());

    }
    return schdules;
  }

}
