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
        <div id="logo"></div>
        <div id="company-name"><span>KCC 정보통신</span></div>

        <div id="input1">
          <input type="text" placeholder="아이디(메일)" />
        </div>

        <div id="input2">
          <input type="text" placeholder="비밀번호" />
        </div>

        <button id="login-button" class="btn-primary"></button>
      </div>
    </div>
  </body>
</html>
