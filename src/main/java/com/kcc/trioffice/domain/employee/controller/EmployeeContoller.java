package com.kcc.trioffice.domain.employee.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
