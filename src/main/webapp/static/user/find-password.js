// var csrfHeaderName = "${_csrf.headerName}";
// var csrfTokenValue = "${_csrf.token}";

// $(document).ajaxSend(function (e, xhr) {
//   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
// });

const closeButton = document.getElementById("find-password-close");
const returnInsertIdPageButton = document.getElementById(
  "find-password-email-backpage"
);
const doneFindPassword = document.getElementById("close-password-page");

function closePage() {
  window.location.href = "/login";
}

function donePage() {
  window.location.href = "/find-password";
}

if (closeButton) {
  closeButton.addEventListener("click", (event) => {
    console.log("close find-password page");
    event.preventDefault();
    closePage();
  });
}

if (returnInsertIdPageButton) {
  returnInsertIdPageButton.addEventListener("click", function (event) {
    console.log("return page");
    event.preventDefault();
    donePage();
  });
}

if (doneFindPassword) {
  doneFindPassword.addEventListener("click", function (event) {
    event.preventDefault();
    closePage();
  });
}

$("#find-password-button").click(function (event) {
  event.preventDefault();
  var employeeId = $("#employeeId").val();

  // 이메일 값 확인을 위해 콘솔 출력
  console.log("이메일 값: " + employeeId);

  if (employeeId) {
    $.ajax({
      url: "/api/find-password/id",
      type: "GET",
      data: { email: employeeId },
      success: function () {
        window.location.href = "/find-password/email";
      },
      error: function () {
        $("#checkedId").html(
          '<p class="text-danger">일치하는 회원정보가 없습니다.</p>'
        );
      },
    });
  }
});
