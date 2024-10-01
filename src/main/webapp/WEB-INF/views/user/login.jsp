<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>kcc정보통신 | login</title>
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/static/user/login.css"
    />
  </head>
  <body>
    <%-- <jsp:include page="/WEB-INF/views/component/top-bar.jsp"></jsp:include>
    --%>

    <div class="full">
      <div class="login-box">
        <div id="logo">
          <img
            src="<%= request.getContextPath() %>/static/component/kcc-logo-no-title.png"
          />
        </div>
        <div id="company-name"><span>KCC 정보통신</span></div>

        <div id="input1">
          <input type="text" placeholder="아이디(메일)" />
        </div>

        <div id="input2">
          <input type="text" placeholder="비밀번호" />
        </div>

        <button id="login-button" class="btn-primary">로그인</button>
        <div id="login-options">
          <label id="remember-id">
            <input type="checkbox" name="remember-id" value="remember-id" />
            <span style="position: relative; top: -3px">아이디 저장하기</span>
          </label>
          <div class="bar">|</div>
          <div id="find-id">
            <a href="/find-id">아이디 찾기</a>
          </div>

          <div class="bar">|</div>
          <div id="find-password">
            <a href="/find-password">비밀번호 찾기</a>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
