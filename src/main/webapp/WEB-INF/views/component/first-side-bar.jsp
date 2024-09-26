<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title></title>
    <link rel="stylesheet" href="../../../static/component/reset.css" />
    <link
      rel="stylesheet"
      href="../../../static/component/first-side-bar.css"
    />
    <script src="/src/main/webapp/static/component/first-side-bar.js"></script>
  </head>

  <body>
    <div class="side-bar-menu">
      <div class="side-bar-menu-icon-with-name">
        <div class="alram">
          <a href="/notifications" class="alram-atag">
            <i class="fa-regular fa-bell"></i>알림</a
          >
        </div>
        <div class="chat">채팅</div>
        <div class="date">일정</div>
        <div class="company">조직도</div>
      </div>
      <div class="chat-bot">bot</div>
    </div>
  </body>
</html>
