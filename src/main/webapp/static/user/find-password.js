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

  if (employeeId === null || employeeId === "") {
    $("#checkedId").html(
      '<p class="text-danger">아이디(이메일)을 입력해주세요.</p>'
    );
  }
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

$("#find-password-email-button").click(function (event) {
  console.log("임시 비밀번호 발급 버튼 ");
  event.preventDefault();
  var externalEmailVal = $("#externalEmail").val();

  if (externalEmailVal === null || externalEmailVal === "") {
    $("#checkedId").html(
      '<p class="text-danger">아이디(이메일)을 입력해주세요.</p>'
    );
  } else {
    // SweetAlert2 사용
    Swal.fire({
      title: "확인",
      text: "해당 이메일로 임시 비밀번호를 발급 받으시겠습니까?",
      icon: "info",
      showCancelButton: true,
      confirmButtonText: "예",
      cancelButtonText: "아니요",
    }).then((result) => {
      if (result.isConfirmed) {
        // 사용자가 확인 버튼을 눌렀을 때 실행
        $.ajax({
          url: "/find-password/id",
          type: "POST",
          data: { externalEmail: externalEmailVal },
          success: function () {
            window.location.href = "/find-password/done";
          },
          error: function () {
            $("#checkedId").html(
              '<p class="text-danger">일치하는 회원정보가 없습니다.</p>'
            );
          },
        });
      }
    });
  }
});
