package com.kcc.trioffice.domain.schedule.service;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import org.apache.coyote.BadRequestException;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

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
  private final JavaMailSender mailSender;

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
  public void saveSchedule(String employeeEmail, SaveSchedule saveSchedule)
      throws BadRequestException, ParseException, MessagingException {
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
    List<String> employeesEmail = new ArrayList<>();

    // mail을 보내기 위한 검사
    if (saveSchedule.getEmailCheck() == 1) {
      List<String> sendEmailEmployeesList = saveSchedule.getEmployeeIds();
      try {
        employeesEmail = employeeMapper.getEmployeeEmailforSend(sendEmailEmployeesList);
      } catch (Exception e) {
        log.info("회원 이메일 가져오기 실패 : " + e);
        throw new BadRequestException("회원 이메일 가져오기 실패 ");
      }
      for (int i = 0; i < employeesEmail.size(); i++) {
        System.out.println("회원들의 이메일 : " + employeesEmail.get(i));
      }

      try {
        Set<String> uniqueEmails = new HashSet<>(employeesEmail);

        for (String oneEmployeeEmail : uniqueEmails) {

          // 이메일 메시지 설정
          MimeMessage message = mailSender.createMimeMessage();
          MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

          helper.setFrom("noreply@kcc.com");
          helper.setTo(oneEmployeeEmail);
          helper.setSubject("KCC정보통신 | " + saveSchedule.getName() + " 일정 초대 알림");
          String htmlContent = "    <div class='email-container'>" +
              "        <div class='content'>" +
              "            <h2>안녕하세요,</h2>" +
              "            <p>귀하는 다음 일정에 초대되었습니다:</p>" +
              "            <p><strong>일정 제목:</strong> " + saveSchedule.getName() + "</p>" +
              "            <p><strong>일정 기간:</strong> " + saveSchedule.getStartedDt() + " ~ "
              + saveSchedule.getEndedDt() + "</p>" +
              "            <a href='#' class='button'>일정 확인하기</a>" +
              "        </div><br>" +
              "        <div class='footer'>" +
              "            <p>본 알림은 시스템에 의해 자동 생성되었습니다.</p>" +
              "        </div>" +
              "    </div>";
          helper.setText(htmlContent, true);

          mailSender.send(message);
        }
      } catch (MailException e) {
        e.printStackTrace(); // 예외 처리 로직 추가 가능
      }
    }

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
