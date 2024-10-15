package com.kcc.trioffice.domain.schedule.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.service.EmployeeService;
import com.kcc.trioffice.domain.schedule.dto.EmployeeSchedules;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ScheduleContorller {

  private final EmployeeService employeeService;

  @GetMapping("/schedules")
  public String schedule(Principal principal, Model model) {
    EmployeeInfo employeeInfo = employeeService.getEmployeeInfoFindById(principal.getName());
    model.addAttribute("name", employeeInfo.getName());
    return "schedule/schedule";
  }

  @PostMapping("/schedules/save")
  public ResponseEntity<?> saveSchdule(Principal principal,
      @RequestBody EmployeeSchedules employeeSchedules) {
    String name = employeeSchedules.getName();
    String startedDt = employeeSchedules.getStartedDt();
    String endedDt = employeeSchedules.getEndedDt();
    String contents = employeeSchedules.getContents();
    List<String> employeeIds = employeeSchedules.getEmployeeIds();
    String loginName = principal.getName();

    System.out
        .println("주최자" + loginName + "request : " + name + startedDt + endedDt + contents + employeeIds.toString());
    return ResponseEntity.ok("성공");
  }

}
