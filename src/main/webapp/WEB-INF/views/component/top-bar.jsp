<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title></title>
    <link rel="stylesheet" href="/src/main/webapp/static/component/reset.css" />
    <link
      rel="stylesheet"
      href="/src/main/webapp/static/component/top-bar.css"
    />
    <script src="/src/main/webapp/static/component/top-bar.js"></script>
  </head>

  <body>
    <div class="top-bar">
      <div class="logo">
        <a href="/"
          ><img src="/src/main/webapp/static/component/kcc정보통신.png"
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
    <jsp:include page="first-side-bar.jsp" />
  </body>
</html>
