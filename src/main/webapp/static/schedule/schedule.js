window.onload = function () {
  var today = new Date();
  var year = today.getFullYear();
  var month = String(today.getMonth() + 1).padStart(2, "0"); // 1을 더해서 0~11 범위를 1~12로 맞춤

  var dateInput = document.getElementById("date-picker");
  dateInput.value = year + "-" + month;
};
document.getElementById("today-button").onclick = function () {
  var dateInput = document.getElementById("date-picker");

  // 현재 시스템 날짜 가져오기
  var today = new Date();

  // yyyy-mm 형식으로 변환
  var year = today.getFullYear();
  var month = (today.getMonth() + 1).toString().padStart(2, "0"); // 월은 0부터 시작하므로 +1 필요

  // date input에 값을 설정
  dateInput.value = year + "-" + month;
};

document.getElementById("left-button").onclick = function () {
  var datePicker = document.getElementById("date-picker");
  var nowMonth = datePicker.value;

  // 현재 값이 없으면 오늘 날짜로 설정
  if (!nowMonth) {
    var today = new Date();
    nowMonth =
      today.getFullYear() + "-" + String(today.getMonth() + 1).padStart(2, "0");
  }

  // 현재 값을 Date 객체로 변환 (yyyy-mm 형식의 문자열을 처리)
  var currentDate = new Date(nowMonth + "-01"); // 첫 번째 날을 고정하여 계산

  // 한 달 빼기
  currentDate.setMonth(currentDate.getMonth() - 1);

  // 새 값 yyyy-mm 형식으로 업데이트
  var newMonth =
    currentDate.getFullYear() +
    "-" +
    String(currentDate.getMonth() + 1).padStart(2, "0");

  // 값 업데이트
  datePicker.value = newMonth;
};

document.getElementById("right-button").onclick = function () {
  var datePicker = document.getElementById("date-picker");
  var nowMonth = datePicker.value;

  // 현재 값이 없으면 오늘 날짜로 설정
  if (!nowMonth) {
    var today = new Date();
    nowMonth =
      today.getFullYear() + "-" + String(today.getMonth() + 1).padStart(2, "0");
  }

  // 현재 값을 Date 객체로 변환 (yyyy-mm 형식의 문자열을 처리)
  var currentDate = new Date(nowMonth + "-01"); // 첫 번째 날을 고정하여 계산

  // 한 달 더하기
  currentDate.setMonth(currentDate.getMonth() + 1);

  // 새 값 yyyy-mm 형식으로 업데이트
  var newMonth =
    currentDate.getFullYear() +
    "-" +
    String(currentDate.getMonth() + 1).padStart(2, "0");

  // 값 업데이트
  datePicker.value = newMonth;
};
