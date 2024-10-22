<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title></title>
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/static/component/reset.css"
    />
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/static/component/first-side-bar.css"
    />
  </head>

  <body>
    <div class="side-bar-menu">
      <div class="side-bar-menu-icon-with-name">
        <div class="alram">
          <a
            href="/notifications"
            class="alram-atag"
            style="text-decoration: none"
          >
            <div class="icons"><i class="fa-regular fa-2x fa-bell"></i></div>
            <div class="menu-text">알림</div>
          </a>
        </div>
        <div id="chat">
          <a href="/chatrooms" style="text-decoration: none">
            <div class="icons">
              <i class="fa-regular fa-2x fa-comments"></i>
            </div>
            <div class="menu-text">채팅</div>
          </a>
        </div>
        <div class="date">
          <a href="/schedules" style="text-decoration: none">
            <div class="icons">
              <i class="fa-regular fa-2x fa-calendar"></i>
            </div>
            <div class="menu-text">일정</div>
          </a>
        </div>
        <div class="company">
          <a href="/departments" style="text-decoration: none">
            <div class="icons">
              <i class="fa-solid fa-2x fa-sitemap"></i>
            </div>
            <div class="menu-text">조직도</div>
          </a>
        </div>
      </div>
      <div class="chat-bot">
        <div class="icons" id="bot-icon">
          <i class="fa-brands fa-2x fa-bots"></i>
        </div>
      </div>

      <div id="chat-bot-container" class="hidden">
        <div id="chat-bot-contents">
          <div id="chat-bot-top-bar">
            <div id="chat-bot-title">트리오챗</div>
            <div id="chat-bot-right-buttons">
              <div id="chat-bot-return">🔄</div>
              <div id="chat-bot-close">❌</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="<%= request.getContextPath() %>/static/component/first-side-bar.js"></script>
  </body>
</html>
