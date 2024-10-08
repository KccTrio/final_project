package com.kcc.trioffice.global.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncoderUtil {
  public static void main(String[] args) {
    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    String rawPassword = "your_password_here"; // 원본 비밀번호
    String encodedPassword = passwordEncoder.encode(rawPassword);
    System.out.println("Encoded Password: " + encodedPassword);
  }
}
