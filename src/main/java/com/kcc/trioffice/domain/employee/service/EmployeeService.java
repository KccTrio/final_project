package com.kcc.trioffice.domain.employee.service;

import com.kcc.trioffice.domain.employee.dto.request.SaveEmployee;
import com.kcc.trioffice.domain.employee.dto.request.SaveFcmToken;
import com.kcc.trioffice.domain.employee.dto.request.UpdateStatus;
import com.kcc.trioffice.domain.employee.dto.response.AdminInfo;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.dto.response.SearchEmployee;
import com.kcc.trioffice.domain.employee.mapper.EmployeeMapper;
import com.kcc.trioffice.global.enums.StatusType;
import com.kcc.trioffice.global.exception.type.EmployeeSaveException;
import com.kcc.trioffice.global.exception.type.NotFoundException;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.MailException;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class EmployeeService {

    private final BCryptPasswordEncoder passwordEncoder;
    private final EmployeeMapper employeeMapper;
    private final JavaMailSender mailSender;

    // 임시비밀번호 생성
    private String generateTempPassword() {
        return UUID.randomUUID().toString().substring(0, 8); // example
    }

    public List<SearchEmployee> getEmployeeByCompanyId(Long employeeId) {

        EmployeeInfo employeeInfo = employeeMapper.getEmployeeInfo(employeeId)
                .orElseThrow(() -> new NotFoundException("해당 직원이 존재하지 않습니다."));

        return employeeMapper.getEmployeeByCompanyIdExceptOneSelf(employeeInfo.getCompanyId(), employeeId);
    }

    @Transactional
    public int employeeSave(SaveEmployee saveEmployee) throws EmployeeSaveException {
        // 비밀번호 인코딩
        String password = saveEmployee.getPassword();
        String incodingPassword = passwordEncoder.encode(password);
        saveEmployee.setPassword(incodingPassword);

        // 회원저장
        int isSuccess = employeeMapper.saveEmployee(saveEmployee);

        if (isSuccess == 1) {
            System.out.println("Employee 저장이 성공하였습니다.");
            return isSuccess;
        } else {
            throw new EmployeeSaveException("Employee 저장이 실패하였습니다.");
        }
    }

    @Transactional
    public void checkEmployeeEmail(String email) {
        employeeMapper.findByEmail(email)
                .orElseThrow(() -> new NotFoundException("일치하는 회원의 아이디가 없습니다."));

        // 사내이메일과 외부이메일 매칭을 위한 값 저장.
        // employeeInfo.setEmail(email);
        // return findedEmail;
    }

    @Transactional
    public void temporaryPassword(String email, String externalEmail) throws MessagingException {
        String employeeMail = email;

        String findedExternalEmail = employeeMapper.getExternalEmail(employeeMail).get();

        if (externalEmail.equals(findedExternalEmail)) {
            // 임시비밀번호 발급
            String tmpPassword = generateTempPassword();
            System.out.println("임시 비밀번호 : " + tmpPassword);

            try {
                // 이메일 메시지 설정
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

                helper.setFrom(employeeMail);
                helper.setTo(externalEmail);
                helper.setSubject("KCC정보통신 사내계정 임시비밀번호");
                String htmlContent = "<div style='font-family: Arial, sans-serif; color: #333;'>"
                        + "<h2 style='color: #4CAF50;'>임시 비밀번호</h2></br>"
                        + "<p>요청하신 임시 비밀번호가 생성되었습니다. 아래의 임시 비밀번호를 사용하여 로그인해 주세요:</p>"
                        + "<div style='background-color: #f9f9f9; border: 1px solid #ddd; padding: 10px; margin: 15px 0;'>"
                        + "<strong>임시 비밀번호:</strong> <span style='color: #e74c3c; font-size: 18px;'>" + tmpPassword
                        + "</span>"
                        + "</div>"
                        + "<p>보안을 위해 로그인 후 비밀번호를 반드시 변경해 주시기 바랍니다.</p>"
                        + "<br>"
                        + "<p>감사합니다.</p>"
                        + "</div>";
                helper.setText(htmlContent, true);

                mailSender.send(message);
            } catch (MailException e) {
                e.printStackTrace(); // 예외 처리 로직 추가 가능
            }

            // DB에 담기 위해 incoding
            String incodingPassword = passwordEncoder.encode(tmpPassword);
            employeeMapper.temporaryPassword(incodingPassword, employeeMail);

        } else {
            throw new NotFoundException("등록하신 외부이메일과 다릅니다.");
        }
    }

    public Map<String, Object> getAdminInfo() {
        Map<String, Object> getAdminNameAndPhone = new HashMap<>();

        AdminInfo adminInfo = employeeMapper.getAdminInfo()
                .orElseThrow(() -> new NotFoundException("admin 정보를 찾을 수 없습니다."));
        getAdminNameAndPhone.put("adminName", adminInfo.getName());
        getAdminNameAndPhone.put("adminPhone", adminInfo.getPhoneNum());

        return getAdminNameAndPhone;
    }

    public EmployeeInfo getEmployeeInfo(Long employeeId) {
        return employeeMapper.getEmployeeInfo(employeeId).orElseThrow(() -> new NotFoundException("해당 직원이 존재하지 않습니다."));
    }

    public Optional<List<SearchEmployee>> getAllEmployeesInfo() {
        List<SearchEmployee> employees = employeeMapper.getAllEmployeesInfo();

        if (employees.isEmpty()) {
            throw new NotFoundException("등록된 직원이 없습니다.");
        } else {
            return Optional.of(employees);
        }
    }

    public EmployeeInfo getEmployeeInfoFindByEmail(String email) {

        return employeeMapper.getEmployeeInfoFindByEmail(email)
                .orElseThrow(() -> new NotFoundException("해당 직원이 존재하지 않습니다."));

    }

    public EmployeeInfo findById(Long id) {
        return employeeMapper.getEmployeeInfo(id).orElseThrow(() -> new NotFoundException("사원이 없습니다."));
    }

    @Transactional
    public void saveFcmToken(SaveFcmToken saveFcmToken, Long employeeId) {
        employeeMapper.saveFcmToken(employeeId, saveFcmToken.getFcmToken());
    }

    @Transactional
    public void changeEmployeeStatus(Long employeeId, UpdateStatus updateStatus) {
        employeeMapper.changeEmployeeStatus(employeeId, StatusType.toEnum(updateStatus.getStatus()).getValue());
    }
}
