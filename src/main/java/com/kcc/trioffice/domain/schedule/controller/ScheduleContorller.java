package com.kcc.trioffice.domain.schedule.controller;

import java.security.Principal;
import java.text.ParseException;
import java.util.List;

import org.apache.coyote.BadRequestException;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.kcc.trioffice.domain.employee.dto.request.SaveEmployee;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.service.EmployeeService;
import com.kcc.trioffice.domain.schedule.dto.EmployeeSchedules;
import com.kcc.trioffice.domain.schedule.dto.SaveSchedule;
import com.kcc.trioffice.domain.schedule.service.ScheduleService;

import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ScheduleContorller {

  private final EmployeeService employeeService;
  private final ScheduleService scheduleService;

  @GetMapping("/schedules")
  public String schedule(Principal principal, Model model) {
    EmployeeInfo employeeInfo = employeeService.getEmployeeInfoFindByEmail(principal.getName());
    model.addAttribute("name", employeeInfo.getName());
    return "schedule/schedule";
  }

  @PostMapping("/schedules/save")
  public ResponseEntity<?> saveSchdule(Principal principal,
      @RequestBody SaveSchedule saveSchedule) throws BadRequestException, ParseException, MessagingException {
    scheduleService.saveSchedule(principal.getName(), saveSchedule);

    System.out.println("넘어온 이메일체크 값 : " + saveSchedule.getEmailCheck());
    return ResponseEntity.ok("성공");
  }

}
