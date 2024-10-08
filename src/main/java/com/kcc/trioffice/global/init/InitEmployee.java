package com.kcc.trioffice.global.init;

import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDate;

import org.apache.ibatis.javassist.tools.framedump;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.Transactional;

import com.kcc.trioffice.domain.employee.dto.request.SaveEmployee;
import com.kcc.trioffice.domain.employee.service.EmployeeService;

import lombok.RequiredArgsConstructor;

@Configuration
@Transactional
@RequiredArgsConstructor
public class InitEmployee implements ApplicationRunner {

  private final EmployeeService employeeService;
  private final Timestamp timestamp = new Timestamp(System.currentTimeMillis());
  private final LocalDate tmpBirth = LocalDate.of(1995, 10, 2);

  @Override
  public void run(ApplicationArguments args) throws Exception {
    // 사원 3명 생성하는 code
    // for (Long i = (long) 0; i < 3; i++) {
    // SaveEmployee saveEmployee = SaveEmployee.builder()
    // .deptId((long) 1)
    // .companyId((long) 1)
    // .email("exam" + i + "@exam.com")
    // .password("1234")
    // .phoneNum("010-1234-222" + i)
    // .externalEmail("exter" + i + "@google.com")
    // .name("홍길동")
    // .birth(tmpBirth)
    // .fax("02-222-2222")
    // .location("동측 기둥 " + i + "번자리")
    // .isReceiveNotification(false)
    // .position("사원")
    // .profileUrl("null")
    // .status(0)
    // .statusMessage("null")
    // .writer(i)
    // .writeDt(timestamp)
    // .modifier(i)
    // .modifiedDt(timestamp)
    // .isDeleted(false)
    // .build();
    // employeeService.employeeSave(saveEmployee);
    // }
  }

}
