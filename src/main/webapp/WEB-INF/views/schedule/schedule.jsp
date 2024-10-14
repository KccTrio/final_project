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
      <!-- 일정등록 모달 -->
      <div id="add-schedule-container" class="hidden">
        <div class="add-schedule-content">
          <div id="title-add-sche">일정 등록</div>
          <form id="schedule-form">
            <div class="add-sche-text">
              <div id="add-schedule-name">일정명</div>
              <input
                type="text"
                id="schedule-name"
                name="schedule-name"
                placeholder="일정명을 입력해주세요."
                required
              />
            </div>

            <div class="add-sche-date">
              <label for="start-date">시작일:</label>
              <input
                type="text"
                placeholder="날짜를 선택해주세요."
                id="start-date"
                name="start-date"
                required
              />

              <label for="end-date" id="end-date-label">종료일:</label>
              <input
                type="text"
                placeholder="날짜를 선택해주세요."
                id="end-date"
                name="end-date"
                required
              />
            </div>

            <div id="invite">
              <div id="invite-title">
                <div id="title-text">인원 초대</div>
                <input type="text" name="employees[]" />
              </div>
              <div class="checkbox-group">
                <label>
                  <input
                    type="checkbox"
                    id="email-alram"
                    name="email-alram"
                    class="checkbox"
                  />
                  이메일 알림
                </label>

                <label id="messenger-alram-label">
                  <input
                    type="checkbox"
                    id="messenger-alram"
                    name="messenger-alram"
                    class="checkbox"
                  />
                  메신저 알림
                </label>
              </div>
            </div>

            <div id="wyswyg">
              <div id="schedule-contents-title">일정내용</div>
              <div id="schedule-contents"></div>
            </div>
            <div id="add-schedule-modal-buttons">
              <button type="submit" id="submit-add-schedule">일정 추가</button>
              <button id="close-button">닫기</button>
            </div>
          </form>
          <span id="close-button"></span>
        </div>
      </div>
    </div>
    <script src="<%= request.getContextPath() %>/static/schedule/schedule.js"></script>
  </body>
</html>
