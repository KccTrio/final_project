package com.kcc.trioffice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

  @GetMapping("/nav")
  public String viewNav() {
    return "/component/nav";
  }

  @GetMapping("/test")
  public String getMethodName() {
    return "/component/test";
  }

  @GetMapping("/top-bar")
  public String topBar() {
    return "/component/top-bar";
  }

  @GetMapping("/admin")
  public String admin() {
    return "/admin/admin";
  }

  @GetMapping("/realAdmin")
  public String realAdmin() {
    return "/admin/realAdmin";
  }



}
