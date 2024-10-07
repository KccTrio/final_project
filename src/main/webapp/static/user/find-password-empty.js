function getCookie(name) {
  const nameEquals = name + "=";
  const decodedCookie = decodeURIComponent(document.cookie);
  const cookieArray = decodedCookie.split(";");
  for (let i = 0; i < cookieArray.length; i++) {
    const cookie = cookieArray[i];
    while (cookie.charAt(0) === " ") {
      cookie = cookie.substring(1);
    }
    if (cookie.indexOf(nameEquals) === 0) {
      return cookie.substring(nameEquals.length, cookie.length);
    }
  }
  return null;
}

function checkAndRedirect() {
  const email = getCookie("findPasswordEmail");
  console.log("사용자의 사내이메일 by cookie : " + email);
  if (email === "" || email === null) {
    window.location.href = "/find-password";
  }
}

// 페이지 로드 시 checkAndRedirect 함수를 호출
window.onload = checkAndRedirect;
