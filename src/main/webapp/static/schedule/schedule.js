var requestCount = 0;
var firstDay;
var lastDay;
var employeeEvents = [];
var backgroundColors = [
  "#FFEB3B", // 밝은 노란색
  "#4CAF50", // 짙은 녹색
  "#2196F3", // 파란색
  "#F44336", // 빨간색
  "#9C27B0", // 보라색
];

var textColors = [
  "#000000", // 검은색
  "#FFFFFF", // 흰색
  "#FFFFFF", // 흰색
  "#FFFFFF", // 흰색
  "#FFFFFF", // 흰색
];

function getRandomColor() {
  const randomIndex = Math.floor(Math.random() * backgroundColors.length);
  return backgroundColors[randomIndex];
}

function getRandomTextColor() {
  const randomIndex = Math.floor(Math.random() * textColors.length);
  return textColors[randomIndex];
}

function getFirstAndLastDateOfMonth() {
  // 날짜를 'YYYY-MM-DD' 형식으로 포맷팅
  var formattedFirstDay = firstDay.toISOString().split("T")[0];
  var formattedLastDay = lastDay.toISOString().split("T")[0];

  console.log("요청횟수는 : " + requestCount);
  requestCount++;
  //json 형식으로 반환
  return {
    firstDay: formattedFirstDay,
    lastDay: formattedLastDay,
  };
}
function formatDateToISO(dateString) {
  // 'YYYY-MM-DD HH:mm:ss' 형식의 문자열을 Date 객체로 변환
  const [datePart, timePart] = dateString.split(" ");

  // 날짜 및 시간 부분을 조합하여 ISO 8601 형식으로 반환
  const isoDate = new Date(datePart + "T" + timePart).toISOString();

  // ISO 문자열을 그대로 반환 (초까지 포함된 형식)
  return isoDate.replace(".000Z", ""); // .000Z를 Z로 바꿔서 초까지 포함된 형식으로 변환
}

function fetchCalendarData() {
  var dateData = getFirstAndLastDateOfMonth();
  console.log(dateData);
  $.ajax({
    url: "/api/schedules/calendar",
    method: "GET",
    data: {
      startDate: dateData.firstDay,
      endDate: dateData.lastDay,
    },
    dataType: "json",
    success: function (schedules) {
      console.log("통신 성공");

      // 기존 이벤트 배열을 초기화
      employeeEvents = [];
      // FullCalendar에서 기존 이벤트 모두 제거
      calendar.removeAllEvents();

      schedules.forEach(function (schedule) {
        console.log("원래 시작시간 : " + schedule.startedDt);
        console.log("원래 끝시간 : " + schedule.endedDt);
        var event = {
          title: schedule.name,
          start: formatDateToISO(schedule.startedDt), // ISO 8601 형식으로 변환
          end: formatDateToISO(schedule.endedDt), // ISO 8601 형식으로 변환
        };
        employeeEvents.push(event);
        calendar.addEvent(event); // 이벤트를 FullCalendar에 추가
      });
      console.log("events:", employeeEvents);

      calendar.render(); // 캘린더 업데이트
    },
    error: function () {},
  });
}

// 캘린더 랜더링
document.addEventListener("DOMContentLoaded", function (employeeEvents) {
  var calendarEl = document.getElementById("calendar");
  calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: "dayGridMonth",
    headerToolbar: {
      left: "prev next today",
      center: "title",
      right: "dayGridMonth,dayGridWeek,dayGridDay",
    },
    buttonText: {
      today: "오늘",
      month: "월",
      week: "주",
      day: "일",
      list: "목록",
    },
    events: employeeEvents,

    eventDidMount: function (info) {
      // 시간도 있는 이벤트에 색상 변경
      if (!info.event.allDay) {
        info.el.style.backgroundColor = "#4CAF50"; // 시간대 이벤트 배경색
        info.el.style.color = "#FFFFFF"; // 시간대 이벤트 글자색
      }

      // 이벤트에 우클릭 이벤트 리스너 추가
      info.el.addEventListener("contextmenu", function (event) {
        event.preventDefault(); // 브라우저 기본 우클릭 메뉴를 막음
        alert("이벤트를 우클릭했습니다: " + info.event.title);
      });
    },
    // 상세보기 추후 구현
    eventClick: function (info) {
      alert("이벤트 제목: " + info.event.title);
      // 추가적인 로직을 여기에 작성
    },

    displayEventTime: true,
    displayEventEnd: true,
    locale: "ko",

    datesSet: function (info) {
      firstDay = info.view.currentStart;
      lastDay = info.view.currentEnd;

      fetchCalendarData();
      // calendar.refetchEvents(); // FullCalendar에 이벤트 업데이트
      console.log("dataset");
    },
  });

  calendar.render();
});
