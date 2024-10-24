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
const chatBotCloseButton = document.getElementById("chat-bot-close");
const chatBotListRemoveButton = document.getElementById("chat-bot-return");
let chatBotList = document.getElementById("chat-bot-messages");
const chatBotSubmitButton =
  document.getElementsByClassName("fa-location-arrow")[0];

chatBotButton.addEventListener("click", function () {
  chatBotContainer.classList.remove("hidden");
});

window.addEventListener("click", function (event) {
  if (event.target === chatBotContainer) {
    chatBotContainer.classList.add("hidden");
  }
});

chatBotCloseButton.addEventListener("click", function () {
  chatBotContainer.classList.add("hidden");
});

chatBotListRemoveButton.addEventListener("click", function () {
  chatBotList.innerHTML = ""; // 내용 지우기
});

//client 채팅 submit 3개 하기
const chatBotInput = document.getElementById("chat-bot-input");
chatBotSubmitButton.addEventListener("click", function () {
  submitChatBot();
});

chatBotInput.addEventListener("keydown", function (event) {
  if (event.key === "Enter") {
    event.preventDefault(); // 기본 동작 방지 (폼 제출 방지)
    submitChatBot();
  }
});

function submitChatBot() {
  //입력값 가져오고 있으면 채팅방으로 value비우기
  const chatBotUserMessage = chatBotInput.value;
  const sendClientMessage = chatBotUserMessage;
  if (chatBotUserMessage) {
    displayClientChatBotMessage(chatBotUserMessage);
    chatBotInput.value = "";
  }
  console.log("클라이언트에서 보내는 메세지 : " + sendClientMessage);
  $.ajax({
    url: "/api/chat-bot",
    type: "POST",
    dataType: "json",
    data: {
      clientMessage: sendClientMessage,
    },
    success: function (serverMessage) {
      displaysServerChatBotMessage(serverMessage.response);
    },
    error: function (error) {
      console.log("서버로부터 답변을 받지 못했습니다. " + error);
    },
  });
}

function displayClientChatBotMessage(message) {
  const chatMessageElement = document.createElement("div");
  chatMessageElement.className = "chat-bot-client";
  chatMessageElement.innerHTML = `<p class="chat-bot-client-messages">${message}</p>`;
  chatBotList.appendChild(chatMessageElement); // 메시지를 채팅방에 추가

  chatBotList.scrollTop = chatBotList.scrollHeight;
}

function displaysServerChatBotMessage(message) {
  const chatMessageElement = document.createElement("div");
  chatMessageElement.className = "chat-bot-server";
  chatMessageElement.innerHTML = `<p class="chat-bot-server-messages">${message}</p>`;
  chatBotList.appendChild(chatMessageElement); // 메시지를 채팅방에 추가

  chatBotList.scrollTop = chatBotList.scrollHeight;
}
