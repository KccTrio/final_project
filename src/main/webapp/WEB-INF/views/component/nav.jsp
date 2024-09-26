<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title></title>
    <link rel="stylesheet" href="../../../static/component/reset.css" />
    <link rel="stylesheet" href="../../../static/component/nav.css" />
    <script src="/src/main/webapp/static/component/nav.js"></script>
  </head>

  <body>
    <div class="full">
      <div class="top-bar">
        <div class="logo">
          <a href="/"
            ><img src="../../../static/component/kcc정보통신.png"
          /></a>
        </div>
        <!-- 검색창 -->
        <div class="search">
          <input type="text" placeholder="검색어 입력" />
          <img
            src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"
          />
        </div>
        <!-- 사용자 -->
        <div class="employee">
          <i class="fa-solid fa-user fa-2x employee-icon"></i>
        </div>
        <!-- 사용자 상태 조회 모달 -->
        <div id="modalContainer" class="hidden">
          <div id="modalContent">
            <p>호소세 화이팅</p>
            <button id="modalCloseButton">닫기</button>
          </div>
        </div>
      </div>
      <div class="main">
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
        <div class="second-side-bar">
          <div class="second-side-bar-menu">
            <div>123</div>
            <div>gkdldy</div>
          </div>
        </div>
        <!-- contents 안에서만 작업해주세요. -->
        <div class="contents">
          <div class="contents-test"></div>
        </div>
      </div>
    </div>
  </body>
</html>
