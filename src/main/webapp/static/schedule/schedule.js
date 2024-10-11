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
  const [year, month, day] = datePart.split("-");
  const [hour, minute, second] = timePart.split(":");

  // Date 객체를 한국 시간(KST) 기준으로 생성
  const localDate = new Date(year, month - 1, day, hour, minute, second);

  const isoDate = new Date(
    localDate.getTime() - localDate.getTimezoneOffset() * 60000
  ).toISOString();

  return isoDate.replace(".000Z", ""); // 초까지 포함된 형식을 유지
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

      // 배열 및 캘린더 초기화
      employeeEvents = [];
      calendar.removeAllEvents();

      schedules.forEach(function (schedule) {
        // 시간부분
        var startTime = schedule.startedDt.split(" ")[1];
        var endTime = schedule.endedDt.split(" ")[1];
        var event = {
          title: schedule.name,
          // ISO 8601 형식으로 변환
          start: formatDateToISO(schedule.startedDt),
          end: formatDateToISO(schedule.endedDt),
        };

        if (startTime === "00:00:00" && endTime === "00:00:00") {
          event.allDay = true; // allDay 이벤트로 설정
        }
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

    // 일 빼기
    dayCellContent: function (info) {
      var number = document.createElement("a");
      number.classList.add("fc-daygrid-day-number");
      number.innerHTML = info.dayNumberText.replace("일", "");
      if (info.view.type === "dayGridMonth") {
        return {
          html: number.outerHTML,
        };
      }
      return {
        domNodes: [],
      };
    },
    selectable: true,
    dayMaxEventRows: true,
    dayMaxEventRows: 3, // 하루에 표시할 최대 이벤트 수
    events: employeeEvents,

    eventDidMount: function (info) {
      info.el.style.cursor = "pointer";
      // 시간도 있는 이벤트에 색상 변경
      if (!info.event.allDay) {
        info.el.style.color = "black"; // 시간대 이벤트 글자색
      } else {
        // info.el.style.backgroundColor = "#b4c8bb"; // 시간대 이벤트 배경색
        info.el.style.border = "0px"; // 시간대 이벤트 배경색
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

// 일정등록 모달
const addScheduleButton = document.getElementById("add-schedule-button");
var modalContainer = document.getElementById("add-schedule-container");
var closeButton = document.getElementById("close-button");

// 버튼 클릭 시 모달 열기
addScheduleButton.onclick = function () {
  modalContainer.classList.remove("hidden");
};

// 모달 닫기 버튼 클릭 시 모달 닫기
closeButton.onclick = function () {
  modalContainer.classList.add("hidden");
};

window.addEventListener("click", function (event) {
  if (event.target === modalContainer) {
    modalContainer.classList.add("hidden");
  }
});

// 일정 추가 양식 제출 시 이벤트 처리
document.getElementById("schedule-form").onsubmit = function (event) {
  event.preventDefault(); // 기본 제출 동작 방지

  // 입력 값 가져오기
  var scheduleName = document.getElementById("schedule-name").value;
  var startDate = document.getElementById("start-date").value;
  var endDate = document.getElementById("end-date").value;

  // 이벤트 추가 로직 (FullCalendar에 추가 등)
  console.log("일정 추가:", scheduleName, startDate, endDate);

  // 입력 필드 초기화
  document.getElementById("schedule-form").reset();
};

// Mobiscroll에 한국어 로케일 설정
mobiscroll.setOptions({
  locale: mobiscroll.localeKo,
});

// 시작 날짜와 시간 선택기
mobiscroll.datepicker("#start-date", {
  controls: ["datetime"], // 날짜와 시간 선택
  display: "bubble", // 팝업 형식 (bubble, inline 등 사용 가능)
  dateFormat: "YYYY-MM-DD", // 날짜 형식
  timeFormat: "HH:mm", // 시간 형식
  stepMinute: 5, // 분 단위 증가폭
  returnFormat: "iso8601", // ISO 8601 형식 반환
  onChange: function (event) {
    if (event.value) {
      validateDates();
    }
  },
});

// 끝 날짜와 시간 선택기
var endDatePicker = mobiscroll.datepicker("#end-date", {
  controls: ["datetime"],
  display: "bubble",
  dateFormat: "YYYY-MM-DD",
  timeFormat: "HH:mm",
  stepMinute: 5,
  returnFormat: "iso8601",
  onChange: function (event) {
    console.log("종료값을 설정하였습니다");
    if (event.value) {
      validateDates();
    }
  },
});

function validateDates() {
  const startDateInput = document.getElementById("start-date");
  const endDateInput = document.getElementById("end-date");

  const startDate = new Date(startDateInput.value);
  const endDate = new Date(endDateInput.value);

  if (endDate < startDate) {
    endDateInput.value = ""; // 끝 날짜 초기화
    mobiscroll.getInst(endDateInput).setVal(null); // Mobiscroll에서 끝 날짜 필드 초기화
    endDatePicker.close();

    Swal.fire({
      text: "끝 날짜는 시작 날짜보다 커야 합니다.",
    });
  }
}

var quill = new Quill("#schedule-contents", {
  theme: "snow", // 또는 'bubble'
  modules: {
    toolbar: [
      [{ header: [1, 2, false] }],
      ["bold", "italic", "underline"],
      ["link", "image"],
      ["clean"], // remove formatting button
    ],
  },
  // 에디터의 크기 설정
  style: {
    width: "100%", // 원하는 너비
  },
});
