// 현재 URL 경로를 가져옴
const currentPath = window.location.pathname;
console.log("Current Path:", currentPath);

// 모든 사이드바의 링크 요소를 선택
const links = document.querySelectorAll(".side-bar-menu-icon-with-name a");

links.forEach((link) => {
  console.log(links.getAttribute("href"));

  // 링크의 href 값이 현재 경로로 시작하면
  if (currentPath.startsWith(link.getAttribute("href"))) {
    // 링크의 부모 div에 'active' 클래스를 추가
    link.parentElement.classList.add("active");
  }
});
