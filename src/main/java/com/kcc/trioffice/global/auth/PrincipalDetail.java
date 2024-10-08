package com.kcc.trioffice.global.auth;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;

import lombok.Data;

@Data
public class PrincipalDetail implements UserDetails {
  private EmployeeInfo employeeInfo;

  public PrincipalDetail(EmployeeInfo employeeInfo) {
    this.employeeInfo = employeeInfo;
  }

  @Override
  public Collection<? extends GrantedAuthority> getAuthorities() {
    return List.of();
  }

  @Override
  public String getPassword() {
    return employeeInfo.getPassword();
  }

  @Override
  public String getUsername() {
    return employeeInfo.getEmail();
  }

  @Override
  public boolean isAccountNonExpired() {
    return true;
  }

  @Override
  public boolean isAccountNonLocked() {
    return true;
  }

  @Override
  public boolean isCredentialsNonExpired() {
    return true;
  }

  @Override
  public boolean isEnabled() {
    return true;
  }

  public Long getEmployeeId() {
    return employeeInfo.getEmployeeId();
  }
}