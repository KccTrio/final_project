package com.kcc.trioffice.domain.employee.controller;

import com.kcc.trioffice.domain.employee.dto.response.SearchEmployee;
import com.kcc.trioffice.domain.employee.service.EmployeeService;

import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class EmployeeRestController {

    private final EmployeeService employeeService;

    @GetMapping("/employees/all")
    public ResponseEntity<List<SearchEmployee>> getEmployeesByCompany() {
        return ResponseEntity.ok(employeeService.getEmployeeByCompanyId(2L));
    }

    @GetMapping("/find-password/id")
    public HttpStatus findPasswordCheckId(@RequestParam final String email) {
        System.out.println("요청한 회원 이메일 :" + email);
        employeeService.checkEmployeeEmail(email);
        // String responseEmail = employeeService.checkEmployeeEmail(email);
        // Map<String, Object> response = new HashMap<>();
        // response.put("email", responseEmail);
        return HttpStatus.OK;
    }

    @PostMapping("/find-password/email")
    public HttpStatus passwordChange(@RequestParam final String email, @RequestParam final String externalEmail)
            throws MessagingException {
        System.out.println("요청한 사외 이메일 :" + externalEmail);
        employeeService.temporaryPassword(email, externalEmail);
        return HttpStatus.OK;
    }

    @GetMapping("/find-admin")
    public ResponseEntity<Map<String, Object>> findAdminNameAndPhoneNum() {
        return ResponseEntity.ok(employeeService.getAdminInfo());
    }

}
