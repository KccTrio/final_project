$(document).ready(function() {
    // 채팅방 아이템 클릭 이벤트 등록
    $('.chat-room-item').on('click', function() {
        var chatRoomId = $(this).data('chat-room-id');

        // 모든 아이템에서 'active' 클래스 제거
        $('.chat-room-item').removeClass('active');

        // 클릭된 아이템에 'active' 클래스 추가
        $(this).addClass('active');
        // AJAX 요청 보내기
        loadChatRoom(chatRoomId);
    });

    function loadChatRoom(chatRoomId) {
        $.ajax({
            url: '/chatrooms/' + chatRoomId + '/messages', // 서버의 API 엔드포인트
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                // 응답으로 받은 데이터를 사용하여 채팅 내용을 업데이트합니다.
                updateChatContents(data);
            },
            error: function(xhr, status, error) {
                console.error('채팅방 데이터를 가져오는 데 실패했습니다:', error);
            }
        });
    }

    function updateChatContents(messages) {
        // 채팅 내용을 표시할 영역을 선택합니다.
        var chatContainer = $('.chat');
        chatContainer.empty(); // 기존 내용을 지웁니다.

        // 메시지 데이터를 순회하며 채팅 내용을 생성합니다.
        messages.forEach(function(message) {
            var chatRow;

            if (message.senderId === currentUserId) {
                // 내 메시지일 경우
                chatRow = `
                    <div class="row d-flex justify-content-end">
                        <div class="col-10">
                            <div class="row d-flex justify-content-end">
                                <div class="col-9">
                                    <div class="chat-bubble-container d-flex align-items-end d-flex justify-content-end">
                                        <div class="my-chat-time">
                                            ${message.sentTime}
                                        </div>
                                        <div class="my-chat-content d-flex align-items-center justify-content-center">
                                            <p>${message.content}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>`;
            } else {
                // 다른 사람의 메시지일 경우
                chatRow = `
                    <div class="row">
                        <div class="col-10">
                            <div class="row d-flex justify-content-end">
                                <div class="col-11 emp-name d-flex justify-content-start">
                                    <span>${message.senderName}</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-1">
                                    <div class="chat-profile">
                                        <img src="${message.senderProfileUrl}" />
                                        <div class="status d-flex justify-content-center align-items-center">
                                            <i class="fa-solid fa-check check-icon"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-9">
                                    <div class="chat-bubble-container d-flex align-items-end">
                                        <div class="chat-content d-flex align-items-center justify-content-center">
                                            <p>${message.content}</p>
                                        </div>
                                        <div class="chat-time">
                                            ${message.sentTime}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>`;
            }

            // 채팅 내용을 추가합니다.
            chatContainer.append(chatRow);
        });

        // 스크롤을 맨 아래로 내립니다.
        chatContainer.scrollTop(chatContainer[0].scrollHeight);
    }

    // 현재 사용자 ID (서버에서 제공하거나 페이지에 포함시켜야 합니다)
    var currentUserId = 1// 서버에서 currentUserId 값을 제공해야 합니다.
});

document.addEventListener("DOMContentLoaded", function() {
    const chatDates = document.querySelectorAll(".last-message-at p");
    const today = new Date().toISOString().slice(0, 10); // YYYY-MM-DD 형식

    chatDates.forEach(function(dateElement) {
        const fullDate = new Date(dateElement.textContent.trim());
        if (fullDate.toISOString().slice(0, 10) === today) {
            // 시간 형식을 24시간제로 변경하고 '오전/오후' 제거
            dateElement.textContent = fullDate.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit', hour12: false });
        } else {
            dateElement.textContent = fullDate.toLocaleDateString('ko-KR', { month: '2-digit', day: '2-digit' });
        }
    });
});