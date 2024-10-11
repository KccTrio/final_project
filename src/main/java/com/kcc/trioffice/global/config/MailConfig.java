package com.kcc.trioffice.global.config;

import java.util.Properties;
import java.util.jar.JarFile;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {

  @Value("${mail.password}")
  private String googlePassword;

  @Bean
  public JavaMailSender javaMailService() {
    JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();

    javaMailSender.setHost("smtp.gmail.com");
    javaMailSender.setUsername("sunggu3012@gmail.com"); // 구글 계정 이메일
    javaMailSender.setPassword(googlePassword); // 구글 계정 비밀번호

    javaMailSender.setPort(587); // Gmail SMTP 포트

    javaMailSender.setJavaMailProperties(getMailProperties());

    return javaMailSender;
  }

  private Properties getMailProperties() {
    Properties properties = new Properties();
    properties.setProperty("mail.transport.protocol", "smtp");
    properties.setProperty("mail.smtp.auth", "true");
    properties.setProperty("mail.smtp.starttls.enable", "true"); // STARTTLS 활성화
    properties.setProperty("mail.debug", "true");
    return properties;
  }
}
