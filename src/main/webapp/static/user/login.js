const findId = document.getElementById("find-id").querySelector("a");
const modelFindId = document.getElementById("find-id-container");
const closeFindId = document.getElementById("find-id-close");
var adminId = "";
var adminPhoneNum = "";
findId.addEventListener("click", function (event) {
  event.preventDefault(); // 기본 링크 동작 방지
  console.log("open find"); // 클릭 시 콘솔에 출력
  modelFindId.classList.remove("hidden"); // 모달 표시
  $.ajax({
    url: "api/find-admin",
    type: "GET",
    success: function () {
      console.log("admin의 정보를 가져왔습니다.");
    },
    error: function () {},
  });
});

closeFindId.addEventListener("click", () => {
  modelFindId.classList.add("hidden"); // 모달 숨기기
});

window.addEventListener("click", (event) => {
  // 모달 배경 클릭 시 닫기
  if (event.target === modelFindId) {
    modelFindId.classList.add("hidden");
  }
});

const loginForm = document.getElementById("login-form");
const rememberCheck = document.getElementById("remember-check");
const userIdField = loginForm.querySelector('input[name="id"]');

// 페이지 로드 시 저장된 아이디가 있으면 입력 필드에 채우기
const savedUserId = localStorage.getItem("savedUserId");
if (savedUserId) {
  userIdField.value = savedUserId;
  rememberCheck.checked = true; // 저장된 아이디가 있다면 체크박스도 체크 상태로 설정
}

loginForm.addEventListener("submit", function (event) {
  // 기본이벤트를 막으므로 사용하면 안된다.
  // event.preventDefault();

  const formData = new FormData(loginForm);

  // remember-me 체크박스가 체크되어 있으면 아이디를 저장
  if (rememberCheck.checked) {
    localStorage.setItem("savedUserId", formData.get("id"));
  } else {
    localStorage.removeItem("savedUserId");
  }
});
