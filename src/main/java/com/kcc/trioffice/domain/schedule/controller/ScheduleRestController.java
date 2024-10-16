package com.kcc.trioffice.domain.schedule.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kcc.trioffice.domain.schedule.dto.EmployeeSchedules;
import com.kcc.trioffice.domain.schedule.service.ScheduleService;

import lombok.RequiredArgsConstructor;

import java.util.HashMap;
import java.util.List;

import org.springframework.http.ResponseEntity;

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
    // Map<String, String> schedules = new HashMap<>();
    // schedules.put("startDate", "2024-10-12");

    return ResponseEntity.ok(schedules);

  }

}
