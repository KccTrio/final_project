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
