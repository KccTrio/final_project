package com.kcc.trioffice.domain.employee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmployeeContoller {

  @GetMapping("/login")
  public String login() {
    return "user/login";
  }

  @GetMapping("/find-password")
  public String findPassword() {
    return "user/find-password";
  }

  @GetMapping("/find-password/email")
  public String findPasswordEmail() {
    return "user/find-password-email";
  }

  @GetMapping("/find-password/done")
  public String findPasswordDone() {
    return "user/find-password-done";
  }

}
