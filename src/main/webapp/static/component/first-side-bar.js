const currentPath = window.location.pathname;
console.log("Current Path:", currentPath);

// 모든 사이드바의 링크 요소를 선택
const links = document.querySelectorAll(".side-bar-menu-icon-with-name a");

links.forEach((link) => {
  // 각 링크의 href 값을 가져와서 출력
  const hrefValue = link.getAttribute("href");

  // 링크의 href 값이 현재 경로로 시작하면
  if (currentPath.startsWith(hrefValue)) {
    // 링크의 부모 div에 'active' 클래스를 추가
    link.parentElement.classList.add("active");
  }
});

const chatBotButton = document.getElementsByClassName("chat-bot")[0];
const chatBotContainer = document.getElementById("chat-bot-container");

chatBotButton.addEventListener("click", function () {
  chatBotContainer.classList.remove("hidden");
});

window.addEventListener("click", function (event) {
  if (event.target === chatBotContainer) {
    chatBotContainer.classList.add("hidden");
  }
});
