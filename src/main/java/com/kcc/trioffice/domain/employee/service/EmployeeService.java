package com.kcc.trioffice.domain.employee.service;

import com.kcc.trioffice.domain.employee.dto.request.SaveEmployee;
import com.kcc.trioffice.domain.employee.dto.response.EmployeeInfo;
import com.kcc.trioffice.domain.employee.dto.response.SearchEmployee;
import com.kcc.trioffice.domain.employee.mapper.EmployeeMapper;
import com.kcc.trioffice.global.exception.type.EmployeeSaveException;
import com.kcc.trioffice.global.exception.type.NotFoundException;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class EmployeeService {

    private final BCryptPasswordEncoder passwordEncoder;
    private final EmployeeMapper employeeMapper;
    private final JavaMailSender mailSender;
    // private final EmployeeInfo employeeInfo = new EmployeeInfo();

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
                helper.setText("임시 비밀번호는: " + tmpPassword + " 입니다.", true);

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

}
