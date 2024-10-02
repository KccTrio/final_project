package com.kcc.trioffice.domain.employee.controller;

import com.kcc.trioffice.domain.employee.dto.response.SearchEmployee;
import com.kcc.trioffice.domain.employee.service.EmployeeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class EmployeeRestController {

    private final EmployeeService employeeService;

    @GetMapping("/api/employees/all")
    public ResponseEntity<List<SearchEmployee>> getEmployeesByCompany() {
        return ResponseEntity.ok(employeeService.getEmployeeByCompanyId(2L));
    }

}