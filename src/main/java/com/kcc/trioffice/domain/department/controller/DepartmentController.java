package com.kcc.trioffice.domain.department.controller;

import com.kcc.trioffice.domain.department.dto.response.Department;
import com.kcc.trioffice.domain.department.service.DepartmentService;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/departments")
@Slf4j
public class DepartmentController {

    private final DepartmentService departmentService;

    // 모든 부서 조회
    @GetMapping
    public String getDepartment(Model model) {
        List<Department> departments = departmentService.getDepartmentDetails();
        model.addAttribute("departmentTree", departments);
        log.info("departments : {}", departments);
        return "department/department"; // JSP 또는 Thymeleaf 템플릿 이름
    }

    // 특정 부서의 직원 정보 조회
    @GetMapping("/{deptId}/employees")
    public String getEmployeesByDepartment(@PathVariable Long deptId, Model model) {
        List<EmployeeInfo> employees = departmentService.getEmployeesByDeptId(deptId);
        model.addAttribute("employees", employees);
        model.addAttribute("deptId", deptId);
        log.info("employees in department {}: {}", deptId, employees);
        return "department/employees"; // 직원 목록을 표시할 JSP 또는 Thymeleaf 템플릿 이름
    }

    @GetMapping("/admin")
    public String detAdminDepartment(Model model) {
        List<Department> departments = departmentService.getDepartmentDetails();
        model.addAttribute("departmentTree", departments);
        return "department/adminDepartment";
    }
}
