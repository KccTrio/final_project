const modalOpenButton = document.getElementsByClassName("employee-icon");
const modalCloseButton = document.getElementById("modalCloseButton");
const modal = document.getElementById("modalContainer");

modalOpenButton.addEventListener("click", () => {
  modal.classList.remove("hidden");
});

modalCloseButton.addEventListener("click", () => {
  modal.classList.add("hidden");
});

window.addEventListener("click", function (event) {
  if (event.target === modal) {
    modal.classList.add("hidden");
  }
});
