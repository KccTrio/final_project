const currentPath = window.location.pathname;
console.log("Current Path:", currentPath);

// 모든 사이드바의 링크 요소를 선택
const links = document.querySelectorAll(".side-bar-menu-icon-with-name a");
if (links.length > 0) {
  console.log(`선택된 링크의 수: ${links.length}`);
} else {
  console.log("선택된 링크가 없습니다.");
}
links.forEach((link) => {
  // 각 링크의 href 값을 가져와서 출력
  const hrefValue = link.getAttribute("href");
  console.log(hrefValue); // 각 링크의 href 값이 출력됨

  // 링크의 href 값이 현재 경로로 시작하면
  if (currentPath.startsWith(hrefValue)) {
    // 링크의 부모 div에 'active' 클래스를 추가
    link.parentElement.classList.add("active");
  }
});
