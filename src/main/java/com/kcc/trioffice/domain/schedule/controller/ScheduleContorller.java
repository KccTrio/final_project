package com.kcc.trioffice.domain.schedule.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ScheduleContorller {

  @GetMapping("/schedules")
  public String schedule() {
    return "schedule/schedule";
  }
}
