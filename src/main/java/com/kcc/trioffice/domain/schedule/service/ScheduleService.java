package com.kcc.trioffice.domain.schedule.service;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.coyote.BadRequestException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.mapper.EmployeeMapper;
import com.kcc.trioffice.domain.schedule.dto.EmployeeSchedules;
import com.kcc.trioffice.domain.schedule.dto.SaveSchedule;
import com.kcc.trioffice.domain.schedule.mapper.ScheduleMapper;
import com.kcc.trioffice.global.exception.type.NotFoundException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ScheduleService {

  private final ScheduleMapper scheduleMapper;
  private final EmployeeMapper employeeMapper;

  Timestamp timestamp = Timestamp.valueOf(LocalDateTime.now());

  public List<EmployeeSchedules> getEmployeeSchedules(String startDate, String endDate) {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    String employeeId = authentication.getName();
    System.out.println(employeeId);
    List<EmployeeSchedules> schdules = scheduleMapper.getEmployeeSchedules(employeeId, startDate, endDate);

    for (int i = 0; i < schdules.size(); i++) {
      System.out.println((i + 1) + "번의 일정명은 " + schdules.get(i).getStartedDt());

    }
    return schdules;
  }

  @Transactional
  public void saveSchedule(String employeeEmail, SaveSchedule saveSchedule) throws BadRequestException, ParseException {
    EmployeeInfo employeeInfo = employeeMapper.getEmployeeInfoFindByEmail(employeeEmail)
        .orElseThrow(() -> new NotFoundException("일치하는 회원이 없습니다."));

    // 문자열을 Timestamp로 변환
    String startedDtStr = saveSchedule.getStartedDt(); // "2024-10-16" 또는 "2024-10-16 17:50"
    String endedDtStr = saveSchedule.getEndedDt(); // "2024-10-16" 또는 "2024-10-16 17:50"

    // 시간을 포함한 형식과 날짜만 있는 형식 모두 처리
    SimpleDateFormat fullDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    SimpleDateFormat shortDateFormat = new SimpleDateFormat("yyyy-MM-dd");

    java.util.Date parsedDateStart;
    java.util.Date parsedDateEnd;

    try {
      if (startedDtStr.length() > 10) {
        parsedDateStart = fullDateFormat.parse(startedDtStr); // 시간이 포함된 경우
      } else {
        parsedDateStart = shortDateFormat.parse(startedDtStr); // 날짜만 있는 경우
      }

      if (endedDtStr.length() > 10) {
        parsedDateEnd = fullDateFormat.parse(endedDtStr); // 시간이 포함된 경우
      } else {
        parsedDateEnd = shortDateFormat.parse(endedDtStr); // 날짜만 있는 경우
        // 종료 날짜를 +1일 증가시킴
        Calendar cal = Calendar.getInstance();
        cal.setTime(parsedDateEnd);
        cal.add(Calendar.DATE, 1); // +1일
        parsedDateEnd = cal.getTime();
      }
    } catch (ParseException e) {
      throw new BadRequestException("잘못된 날짜 형식입니다.");
    }

    Timestamp startedDt = new Timestamp(parsedDateStart.getTime());
    Timestamp endedDt = new Timestamp(parsedDateEnd.getTime());

    saveSchedule.setWriter(employeeInfo.getEmployeeId());
    saveSchedule.setModifier(employeeInfo.getEmployeeId());
    saveSchedule.setIsDeleted("0");

    try {
      // saveSchedule 메서드 호출
      scheduleMapper.saveSchedule(saveSchedule, startedDt, endedDt);
      // 이후 saveScheduleInvite 호출
      scheduleMapper.saveScheduleInvite(saveSchedule);
    } catch (Exception e) {
      log.info("에러 발생: ", e);
      throw new BadRequestException("saveSchedule 또는 saveScheduleInvite 중 오류 발생");
    }
  }

}
