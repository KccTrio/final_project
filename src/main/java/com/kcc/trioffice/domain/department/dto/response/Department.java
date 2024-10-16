package com.kcc.trioffice.domain.department.dto.response;

import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class Department {
    private Long deptId;
    private String departmentName;
    private Long upperDeptId;
    private int deptLevel;
    private List<Department> subDepartments = new ArrayList<>();
    private List<EmployeeInfo> employees = new ArrayList<>();

    public Department() {
        this.subDepartments = new ArrayList<>();
        this.employees = new ArrayList<>();
    }

    // 추가적으로 직원 수를 반환하는 메서드
    public int getEmployeeCount() {
        return employees.size();
    }
}
