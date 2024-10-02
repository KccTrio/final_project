package com.kcc.trioffice.global.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

  @Bean
  public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }

  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http)
      throws Exception {
    http
        .authorizeHttpRequests(authorizeHttpRequests -> authorizeHttpRequests
            .requestMatchers("/admin/**").hasRole("ADMIN") // ROLE_ADMIN 권한이 있는 사용자만 접근 가능
            .requestMatchers("/user/**").authenticated() // 로그인한 사용자만 회원조회
            .anyRequest().permitAll()) // 그 외의 모든 요청은 인증 없이 접근 가능
        .csrf(csrf -> csrf.disable())
        .formLogin(form -> form
            .loginPage("/login")
            .loginProcessingUrl("/login") // 로그인 처리 URL
            .failureHandler(authenticationFailureHandler()) // 로그인 실패 처리
            .usernameParameter("id")
            .passwordParameter("password")
            .successHandler((request, response, authentication) -> {
              // 로그인 성공 후 리디렉션 처리
              String redirectUrl = "/";
              System.out.println("Authorities: " + authentication.getAuthorities());

              if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
                redirectUrl = "/admin/main"; // ROLE_ADMIN일 경우 관리자 페이지로 리디렉션
              }
              response.sendRedirect(redirectUrl); // 로그인 성공 후 리디렉션
            }))
        .logout(logout -> logout
            .logoutUrl("/logout")
            .logoutSuccessUrl("/")
            .deleteCookies("JSESSIONID", "remember-me")
            .invalidateHttpSession(true));
    // .rememberMe(remember -> remember
    // .userDetailsService(customUserDetailService)
    // .key("uniqueAndSecret")
    // .tokenValiditySeconds(3600));

    return http.build();
  }

  @Bean
  public AuthenticationFailureHandler authenticationFailureHandler() {
    return new SimpleUrlAuthenticationFailureHandler("/login?error");
  }
}