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
closeButton.onclick = function (event) {
  event.preventDefault(); // 기본 동작 방지
  event.stopPropagation(); // 이벤트 전파 방지
  modalContainer.classList.add("hidden");

  // Quill 에디터 내용 비우기
  quill.setContents([]);
};

window.addEventListener("click", function (event) {
  if (event.target === modalContainer) {
    modalContainer.classList.add("hidden");
  }
});

// Mobiscroll에 한국어 로케일 설정
mobiscroll.setOptions({
  locale: mobiscroll.localeKo,
});

// Mobiscroll 시작 날짜와 시간 선택기
var startDatePicker = mobiscroll.datepicker("#start-date", {
  controls: ["datetime"], // 날짜와 시간 또는 날짜만 선택
  display: "bubble", // 팝업 형식
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

// Mobiscroll 끝 날짜와 시간 선택기
var endDatePicker = mobiscroll.datepicker("#end-date", {
  controls: ["datetime"], // 날짜와 시간 또는 날짜만 선택
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

// "하루 종일" 체크박스 이벤트
document.getElementById("allDayCheck").addEventListener("change", function (e) {
  const isChecked = e.target.checked;

  if (isChecked) {
    startDatePicker.setOptions({ controls: ["date"] });
    endDatePicker.setOptions({ controls: ["date"] });
    console.log("하루 종일 선택됨");
  } else {
    startDatePicker.setOptions({ controls: ["datetime"] });
    endDatePicker.setOptions({ controls: ["datetime"] });
    console.log("하루 종일 해제됨");
  }
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
var inviteEmployee = 0;
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

/* 인원초대를 위한 code   태기파이 */
var tagify;

$(document).ready(function () {
  // 화이트리스트 초기화
  let whitelist = [];

  // AJAX를 통해 직원 목록 가져오기
  $.ajax({
    url: "http://localhost:8081/api/employees/all/include",
    method: "GET",
    dataType: "json",
    success: function (allEmployeeData) {
      whitelist = allEmployeeData.map(function (employee) {
        return {
          name:
            employee.name + "/" + employee.position + "/" + employee.deptName, // 태그에 표시될 내용
          value: employee.id.toString(), // 직원 ID를 문자열로 변환하여 저장
        };
      });

      console.log("직원 데이터를 성공적으로 가져왔습니다:", whitelist);

      // Tagify 초기화
      let inputElm = document.querySelector("input[name='employees[]']");

      // initialize Tagify
      tagify = new Tagify(inputElm, {
        enforceWhitelist: true, // 화이트리스트에서 허용된 태그만 사용
        whitelist: whitelist, // 화이트 리스트 배열. 화이트 리스트를 등록하면 자동으로 드롭다운 메뉴가 생긴다
        autogrow: false, // 태그 입력창이 자동으로 늘어난다
        originalInputValueFormat: function (valuesArr) {
          return valuesArr.map(function (item) {
            return item.value;
          });
        },
        templates: {
          tag: function (tagData) {
            return `
                          <tag title="${tagData.name}"
                              contenteditable='false'
                              spellcheck='false'
                              class='tagify__tag ${
                                tagData.class ? tagData.class : ""
                              }'
                              ${this.getAttributes(tagData)}>
                              <x title='remove tag' class='tagify__tag__removeBtn'></x>
                              <div>
                                  <span class='tagify__tag-text'>${
                                    tagData.name
                                  }</span>
                              </div>
                          </tag>`;
          },
          dropdownItem: function (tagData) {
            return `
                          <div ${this.getAttributes(tagData)}
                              class='tagify__dropdown__item ${
                                tagData.class ? tagData.class : ""
                              }'>
                              <span>${tagData.name}</span>
                          </div>`;
          },
        },
        dropdown: {
          // 검색에 사용할 속성 지정
          searchKeys: ["name"],
          maxItems: 10, // 최대 표시 아이템 수 (필요에 따라 조정)
          enabled: 0, // 0으로 설정하면 입력한 글자 수와 상관없이 항상 드롭다운을 표시
        },
      });

      // 이벤트 리스너 등록 및 기타 Tagify 관련 설정
      // 만일 모든 태그 지우기 기능 버튼을 구현한다면
      // document
      //   .querySelector("#clearTagsButton") // ID로 선택
      //   .addEventListener("click", tagify.removeAllTags.bind(tagify));

      // tagify 전용 이벤트 리스터
      tagify
        .on("add", onAddTag) // 태그가 추가되면
        .on("remove", onRemoveTag) // 태그가 제거되면
        .on("input", onInput) // 태그가 입력되고 있을 경우
        .on("invalid", onInvalidTag) // 허용되지 않는 태그일 경우
        .on("click", onTagClick) // 해시 태그 블럭을 클릭할 경우
        .on("focus", onTagifyFocusBlur) // 포커스 될 경우
        .on("blur", onTagifyFocusBlur) // 반대로 포커스를 잃을 경우
        .on("edit:start", onTagEdit) // 입력된 태그 수정을 할 경우
        .on("dropdown:hide dropdown:show", (e) => console.log(e.type)) // 드롭다운 메뉴가 사라질경우
        .on("dropdown:select", function (e) {
          console.log("Selected employee ID:", e.detail.data.value);
        });

      // 이벤트 리스너 콜백 메소드 정의
      function onAddTag(e) {
        console.log("onAddTag: ", e.detail);
        console.log("original input value: ", inputElm.value);
        inviteEmployee++;
        const inviteCount = document.getElementById("count");
        inviteCount.innerText = inviteEmployee; // innerText로 값 설정
      }

      function onRemoveTag(e) {
        console.log(
          "onRemoveTag:",
          e.detail,
          "tagify instance value:",
          tagify.value
        );
        inviteEmployee--;
        const inviteCount = document.getElementById("count");
        inviteCount.innerText = inviteEmployee; // innerText로 값 설정
      }

      function onTagEdit(e) {
        console.log("onTagEdit: ", e.detail);
      }

      function onInvalidTag(e) {
        console.log("onInvalidTag: ", e.detail);
      }

      function onTagClick(e) {
        console.log(e.detail);
        console.log("onTagClick: ", e.detail);
      }

      function onTagifyFocusBlur(e) {
        console.log(e.type, "event fired");
      }

      function onDropdownSelect(e) {
        console.log("onDropdownSelect: ", e.detail);
      }

      function onInput(e) {
        console.log("onInput: ", e.detail);

        tagify.loading(true); // 태그 입력하는데 우측에 loader 애니메이션 추가
        tagify.loading(false); // loader 애니메이션 제거

        tagify.dropdown.show(e.detail.value); // 드롭다운 메뉴 보여주기
        tagify.dropdown.hide(); // 드롭다운 제거
      }
    },
    error: function (xhr, status, error) {
      console.error("직원 데이터를 가져오는 데 실패했습니다:", error);
    },
  });

  // AJAX 호출과 무관한 다른 코드가 있다면 여기에 추가
});
// 일정 추가 양식 제출 시 이벤트 처리
document.getElementById("schedule-form").onsubmit = function (event) {
  event.preventDefault(); // 기본 제출 동작 방지

  // 확인 버튼이 눌렸을 때만 실행
  Swal.fire({
    title: "일정을 등록하시겠습니까?",
    showCancelButton: true,
    confirmButtonText: "저장",
  }).then((result) => {
    if (result.isConfirmed) {
      // 사용자가 확인 버튼을 클릭한 경우
      // 입력 값 가져오기
      var scheduleName = document.getElementById("schedule-name").value;
      var startDate = document.getElementById("start-date").value;
      var endDate = document.getElementById("end-date").value;

      // 에디터 내용 가져오기
      var deltaContent = quill.getContents();
      var deltaContentJson = JSON.stringify(deltaContent); // JSON 문자열로 변환

      // 선택한 직원 ID 가져오기
      var selectedEmployeeIds = tagify.value.map(function (tag) {
        return tag.value;
      });

      // 값들 확인
      console.log(
        "일정 추가:",
        scheduleName,
        startDate,
        endDate,
        selectedEmployeeIds,
        deltaContentJson
      );
      var emailCheck;
      const checkedEmailSend = document.getElementById("email-alram");
      if (checkedEmailSend.checked) {
        emailCheck = 1;
      } else {
        emailCheck = 0;
      }

      // 서버로 전송할 데이터 설정
      var formData = {
        name: scheduleName,
        startedDt: startDate,
        endedDt: endDate,
        employeeIds: selectedEmployeeIds,
        contents: deltaContentJson, // 에디터 내용 추가
        emailCheck: emailCheck,
      };
      // AJAX 호출
      $.ajax({
        url: "/schedules/save",
        method: "POST",
        contentType: "application/json",

        data: JSON.stringify(formData),
        success: function (response) {
          Swal.fire({
            title: "일정 등록을 성공했습니다.",
            icon: "success",
            confirmButtonText: "확인",
          }).then((result) => {
            if (result.isConfirmed) {
              window.location.href = "/schedules";
            }
          }); // 입력 필드 초기화
          document.getElementById("schedule-form").reset();
          quill.setContents([]); // 에디터 내용 초기화
        },
        error: function (xhr, status, error) {
          Swal.fire({
            icon: "error",
            title: "일정 등록을 실패했습니다.",
          });
          console.error("Error:", xhr.responseText); // 오류 응답 내용을 콘솔에 출력
        },
      });
    }
  });
};
