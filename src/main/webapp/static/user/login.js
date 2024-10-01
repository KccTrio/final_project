const findId = document.getElementById("find-id").querySelector("a");
const modelFindId = document.getElementById("find-id-container");
const closeFindId = document.getElementById("find-id-close");

findId.addEventListener("click", function (event) {
  event.preventDefault(); // 기본 링크 동작 방지
  console.log("open find"); // 클릭 시 콘솔에 출력
  modelFindId.classList.remove("hidden"); // 모달 표시
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
