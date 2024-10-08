// window.onload = function () {
//   var today = new Date();
//   var year = today.getFullYear();
//   var month = String(today.getMonth() + 1).padStart(2, "0"); // 1을 더해서 0~11 범위를 1~12로 맞춤

//   var dateInput = document.getElementById("date-picker");
//   dateInput.value = year + "-" + month;
// };
// document.getElementById("today-button").onclick = function () {
//   var dateInput = document.getElementById("date-picker");

//   // 현재 시스템 날짜 가져오기
//   var today = new Date();

//   // yyyy-mm 형식으로 변환
//   var year = today.getFullYear();
//   var month = (today.getMonth() + 1).toString().padStart(2, "0"); // 월은 0부터 시작하므로 +1 필요

//   // date input에 값을 설정
//   dateInput.value = year + "-" + month;
// };

// document.getElementById("left-button").onclick = function () {
//   var datePicker = document.getElementById("date-picker");
//   var nowMonth = datePicker.value;

//   // 현재 값이 없으면 오늘 날짜로 설정
//   if (!nowMonth) {
//     var today = new Date();
//     nowMonth =
//       today.getFullYear() + "-" + String(today.getMonth() + 1).padStart(2, "0");
//   }

//   // 현재 값을 Date 객체로 변환 (yyyy-mm 형식의 문자열을 처리)
//   var currentDate = new Date(nowMonth + "-01"); // 첫 번째 날을 고정하여 계산

//   // 한 달 빼기
//   currentDate.setMonth(currentDate.getMonth() - 1);

//   // 새 값 yyyy-mm 형식으로 업데이트
//   var newMonth =
//     currentDate.getFullYear() +
//     "-" +
//     String(currentDate.getMonth() + 1).padStart(2, "0");

//   // 값 업데이트
//   datePicker.value = newMonth;
// };

// document.getElementById("right-button").onclick = function () {
//   var datePicker = document.getElementById("date-picker");
//   var nowMonth = datePicker.value;

//   // 현재 값이 없으면 오늘 날짜로 설정
//   if (!nowMonth) {
//     var today = new Date();
//     nowMonth =
//       today.getFullYear() + "-" + String(today.getMonth() + 1).padStart(2, "0");
//   }

//   // 현재 값을 Date 객체로 변환 (yyyy-mm 형식의 문자열을 처리)
//   var currentDate = new Date(nowMonth + "-01"); // 첫 번째 날을 고정하여 계산

//   // 한 달 더하기
//   currentDate.setMonth(currentDate.getMonth() + 1);

//   // 새 값 yyyy-mm 형식으로 업데이트
//   var newMonth =
//     currentDate.getFullYear() +
//     "-" +
//     String(currentDate.getMonth() + 1).padStart(2, "0");

//   // 값 업데이트
//   datePicker.value = newMonth;
// };

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

// 캘린더 랜더링
document.addEventListener("DOMContentLoaded", function () {
  var calendarEl = document.getElementById("calendar");
  var calendar = new FullCalendar.Calendar(calendarEl, {
    themeSystem: "bootstrap4",
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
    eventSources: [
      {
        events: [
          {
            title: "오전회의",
            start: "2024-10-08",
            end: "2024-10-10",
            allDay: true,
          },
          {
            title: "오후회의",
            start: "2024-10-09T12:10:00",
            end: "2024-10-09T12:30:00",
            allDay: false,
          },
        ],
      },
    ],

    eventDidMount: function (info) {
      // 시간도 있는 이벤트에 색상 변경
      if (!info.event.allDay) {
        // info.el.style.backgroundColor = "#4CAF50"; // 시간대 이벤트 배경색
        // info.el.style.color = "#FFFFFF"; // 시간대 이벤트 글자색
      }
    },
    // 상세보기 추후 구현
    eventClick: function (info) {
      alert("이벤트 제목: " + info.event.title);
      // 추가적인 로직을 여기에 작성
    },
    eventDidMount: function (info) {
      // 이벤트에 우클릭 이벤트 리스너 추가
      info.el.addEventListener("contextmenu", function (event) {
        event.preventDefault(); // 브라우저 기본 우클릭 메뉴를 막음
        alert("이벤트를 우클릭했습니다: " + info.event.title);
      });
    },
    displayEventTime: true,
    displayEventEnd: true,
    locale: "ko",
  });

  calendar.render();
});
