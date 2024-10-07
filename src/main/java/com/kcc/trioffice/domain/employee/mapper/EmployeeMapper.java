package com.kcc.trioffice.domain.employee.mapper;

import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.dto.response.SearchEmployee;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface EmployeeMapper {
    Optional<EmployeeInfo> getEmployeeInfo(Long employeeId);
    List<SearchEmployee> getEmployeeByCompanyIdExceptOneSelf(@Param("companyId") Long companyId, @Param("employeeId") Long employeeId);
    List<String> getEmployeeInfoList(List<Long> employees);
}
