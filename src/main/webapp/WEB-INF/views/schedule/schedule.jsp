<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>kcc정보통신 | 일정</title>
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/static/schedule/schedule.css"
    />

    <script src="<%= request.getContextPath() %>/static/component/fullcalendar/dist/index.global.js"></script>
  </head>

  <body>
    <jsp:include page="/WEB-INF/views/component/top-bar.jsp"></jsp:include>
    <jsp:include
      page="/WEB-INF/views/component/first-side-bar.jsp"
    ></jsp:include>
    <div id="contents">
      <div id="add-schedule">
        <div id="add-schedule-button">
          <span><i class="fa-solid fa-calendar-plus"></i> 일정 등록</span>
        </div>
      </div>
      <div id="name-bar">
        <div id="employee-name-location">
          <span id="employee-name">홍길동</span>님의 일정
        </div>
      </div>
      <!-- <div id="calendar-bar">
        <input type="month" id="date-picker" />
        <button id="today-button"></button>
        <button id="left-button"><</button>
        <button id="right-button">></button>
      </div> -->

      <div id="calendar"></div>
    </div>
    <script src="<%= request.getContextPath() %>/static/schedule/schedule.js"></script>
  </body>
</html>
