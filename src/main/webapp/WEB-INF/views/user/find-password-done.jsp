<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>kcc정보통신 | 비밀번호 찾기</title>
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/static/user/find-password.css"
    />
  </head>
  <body>
    <div id="full">
      <div id="find-password-container">
        <!-- main contents -->
        <div id="find-password-contents">
          <div id="logo">
            <img
              src="<%= request.getContextPath() %>/static/component/kcc-logo-no-title.png"
            />
          </div>
          <div id="find-password-title">임시 비밀번호 발송</div>
          <div id="find-password-message">
            임시 비밀번호가 발송되었습니다.<br /><br />

            등록하신 외부 메일에서 임시 비밀번호를 확인하세요.
          </div>
          <button id="close-password-page">닫기</button>
        </div>
      </div>
    </div>
  </body>
  <script src="<%= request.getContextPath() %>/static/user/find-password.js"></script>
</html>
