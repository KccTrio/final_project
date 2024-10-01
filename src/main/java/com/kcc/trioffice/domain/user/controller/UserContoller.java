package com.kcc.trioffice.domain.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

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

  @PostMapping("/find-password/id")
  public String findPasswordCheckId(@ModelAttribute String entity) {
    // POST 요청 처리 로직
    return "redirect:/find-password/email";
  }

  @GetMapping("/find-password/email")
  public String findPasswordEmail() {
    return "user/find-password-email";
  }

  @GetMapping("/find-password/done")
  public String findPasswordDone() {
    return "user/find-password-done";
  }

  @PostMapping("/find-password/email")
  public String findPasswordSendEmail(@ModelAttribute String entity) {
    // POST 요청 처리 로직
    return "redirect:/find-password/done";
  }
}
