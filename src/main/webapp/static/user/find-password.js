const closeButton = document.getElementById("find-password-close");
const returnInsertIdPageButton = document.getElementById(
  "find-password-email-backpage"
);

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
