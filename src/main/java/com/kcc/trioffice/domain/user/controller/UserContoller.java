package com.kcc.trioffice.domain.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserContoller {

  @GetMapping("/login")
  public String login() {
    return "user/login";
  }

  @GetMapping("/find-password")
  public String findPassword() {
    return "user/find-password";
  }

}
