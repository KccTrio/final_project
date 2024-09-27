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
    <link
      rel="stylesheet"
      href="/src/main/webapp/static/component/second-side-bar.css"
    />
    <link
      rel="stylesheet"
      href="/src/main/webapp/static/component/main-contents.css"
    />
    <script src="/src/main/webapp/static/component/first-side-bar.js"></script>
  </head>

  <body>
    <div class="side-bar-menu">
      <div class="side-bar-menu-icon-with-name">
        <div class="alram">
          <a href="/notifications" class="alram-atag">
            <div class="icons"><i class="fa-regular fa-2x fa-bell"></i></div>
            <div class="menu-text">알림</div>
          </a>
        </div>
        <div class="chat">
          <a href="/chatrooms">
            <div class="icons">
              <i class="fa-regular fa-2x fa-comments"></i>
            </div>
            <div class="menu-text">채팅</div>
          </a>
        </div>
        <div class="date">
          <a href="/schedules">
            <div class="icons">
              <i class="fa-regular fa-2x fa-calendar"></i>
            </div>
            <div class="menu-text">일정</div>
          </a>
        </div>
        <div class="company">
          <a href="">
            <div class="icons">
              <i class="fa-solid fa-2x fa-sitemap"></i>
            </div>
            <div class="menu-text">조직도</div>
          </a>
        </div>
      </div>
      <div class="chat-bot">
        <div class="icons"><i class="fa-brands fa-2x fa-bots"></i></div>
      </div>
    </div>
  </body>
</html>
