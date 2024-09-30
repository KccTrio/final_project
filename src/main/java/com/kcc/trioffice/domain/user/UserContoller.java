package com.kcc.trioffice.domain.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserContoller {

  @GetMapping("/login")
  public String login() {
    return "user/login";
  }

}
