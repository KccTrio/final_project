package com.kcc.trioffice.domain.department.service;

import com.kcc.trioffice.domain.department.dto.response.Department;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.department.mapper.DepartmentMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DepartmentService {

    private final DepartmentMapper departmentMapper;

    public List<Department> getDepartmentDetails() {
        // 모든 최상위 부서 가져오기
        List<Department> departments = departmentMapper.getDepartmentDetails();

        // 각 부서에 대해 직원 정보를 추가
        for (Department department : departments) {
            List<EmployeeInfo> employees = departmentMapper.getEmployeesByDeptId(department.getDeptId());
            department.setEmployees(employees);
        }

        return departments;
    }

    // 특정 부서의 직원 정보를 가져오는 메서드
    public List<EmployeeInfo> getEmployeesByDeptId(Long deptId) {
        return departmentMapper.getEmployeesByDeptId(deptId);
    }


}
