const colseButton = document.getElementById("find-password-close");

function colsePage() {
  window.location.href = "/login";
}

colseButton.addEventListener("click", (event) => {
  console.log("close find-password page");
  event.preventDefault();
  colsePage();
});
