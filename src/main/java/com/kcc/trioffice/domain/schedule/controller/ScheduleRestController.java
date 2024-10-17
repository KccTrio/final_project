package com.kcc.trioffice.domain.schedule.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kcc.trioffice.domain.schedule.dto.EmployeeSchedules;
import com.kcc.trioffice.domain.schedule.dto.ScheduleDetail;
import com.kcc.trioffice.domain.schedule.service.ScheduleService;
import com.kcc.trioffice.global.auth.PrincipalDetail;

import lombok.RequiredArgsConstructor;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class ScheduleRestController {

  private final ScheduleService scheduleService;

  @GetMapping("/schedules/calendar")
  public ResponseEntity<List<EmployeeSchedules>> getEmployeeSchedules(@RequestParam String startDate,
      @RequestParam String endDate) {

    System.out.println("request Date : " + startDate + endDate);
    List<EmployeeSchedules> schedules = scheduleService.getEmployeeSchedules(startDate, endDate);

    return ResponseEntity.ok(schedules);
  }

  @GetMapping("/schedules/detail")
  public ResponseEntity<ScheduleDetail> getScheduleDetail(@AuthenticationPrincipal PrincipalDetail principal,
      @RequestParam String scheduleId) {
    System.out.println("서버에서 넘어온 schedule id : " + scheduleId);
    ScheduleDetail scheduleDetail = scheduleService.getScheduleDetail(scheduleId, principal.getEmployeeId());
    return ResponseEntity.ok(scheduleDetail);
  }

}
