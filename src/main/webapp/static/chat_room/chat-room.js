$(document).ready(function() {
    var stompClient = null;
    var currentSubscription = null;
    var currentChatRoomId = null;
    var currentEmployeeId = null;
    var previousSenderId = null;
    var timeoutId = null;
    var currentMessageId = null;

    // 유저 정보 로드
    $.ajax({
        url: '/api/current-employee',
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            currentEmployeeId = data.employeeId;
        },
        error: function(xhr, status, error) {
            console.error('유저 정보를 가져오는 데 실패했습니다:', error);
        }
    });

    // 채팅방 아이템 클릭 이벤트 등록
    $('.chat-room-item').on('click', function() {
        var chatRoomId = $(this).data('chat-room-id');

        $('.chat-room-item').removeClass('active');
        $(this).addClass('active');

        connectWebSocket(chatRoomId);
        loadChatRoom(chatRoomId);
    });

    // 메시지 전송 이벤트
    $('#send').on('click', sendMessage);
    $('.chat-input').keypress(function(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            sendMessage();
        }
    });

    function sendMessage() {
        var chatContents = $('.chat-input').val().trim();
        if (chatContents === '') return;

        var chatMessage = {
            roomId: currentChatRoomId,
            senderId: currentEmployeeId,
            chatType: 2,
            message: chatContents
        };

        if (stompClient && stompClient.connected) {
            stompClient.send("/pub/chat/send", {}, JSON.stringify(chatMessage));
            $('.chat-input').val('');
        } else {
            console.error('WebSocket이 연결되어 있지 않습니다.');
        }
    }

    function loadChatRoom(chatRoomId) {
        var offset = 0;
        var limit = 50;

        $.ajax({
            url: '/api/chatrooms/' + chatRoomId,
            method: 'GET',
            dataType: 'json',
            data: { offset: offset, limit: limit },
            success: function(data) {
                updateChatRoomInfo(data);
                updateChatContents(data.chatInfoList);
            },
            error: function(xhr, status, error) {
                console.error('채팅방 데이터를 가져오는 데 실패했습니다:', error);
            }
        });
    }

    function updateChatRoomInfo(data) {
        $('.contents .chat-room-name').text(data.chatRoomName);
        $('.chat-room-profile-image').attr('src', data.chatRoomProfileImageUrl);
        $('.emp-count').text(data.participantCount);
    }

    function updateChatContents(messages) {
        var chatContainer = $('.chat');
        chatContainer.empty();
        previousSenderId = null;

        messages.reverse().forEach(function(message) {
            var chatRow = generateMessageHtml(message);
            chatContainer.prepend(chatRow);
        });

        chatContainer.scrollTop(chatContainer[0].scrollHeight);
    }

    function generateMessageHtml(message) {
        var isSameSender = (message.senderId === previousSenderId);
        previousSenderId = message.senderId;
        var chatRow;

        if (message.senderId === currentEmployeeId) {
            chatRow = createMyMessageHtml(message);
        } else {
            chatRow = createOtherMessageHtml(message, isSameSender);
        }

        return chatRow;
    }

    function createMyMessageHtml(message) {
        return `
        <div class="row d-flex justify-content-end" data-message-id="${message.chatId}">
            <div class="col-10">
                <div class="row d-flex justify-content-end">
                    <div class="col-9">
                        <div class="chat-bubble-container d-flex align-items-end justify-content-end">
                            <div class="unread-count-box">
                                    <span class="unread-count">${createUnreadCountHtml(message.unreadMessageCount)}</span>
                            </div>
                            <div class="my-chat-time">
                                ${formatDate(message.chatTime)}
                            </div>
                            <div class="my-chat-content d-flex align-items-center justify-content-center">
                                <p>${message.chatContents}</p>
                            </div>
                        </div>
                    </div>
                </div>
                ${createMyEmoticonBoxHtml(message)}
            </div>
        </div>`;
    }

    function createOtherMessageHtml(message, isSameSender) {
        var profileHtml = isSameSender ? `
            <div class="col-1"></div>` : `
            <div class="col-1">
                <div class="chat-profile">
                    <img src="${message.senderProfileUrl}" />
                    <div class="status d-flex justify-content-center align-items-center">
                        <i class="fa-solid fa-check check-icon"></i>
                    </div>
                </div>
            </div>`;

        var nameHtml = isSameSender ? '' : `
            <div class="row d-flex justify-content-end">
                <div class="col-11 emp-name d-flex justify-content-start">
                    <span>${message.senderName}</span>
                </div>
            </div>`;

        var emoticonHtml = createEmoticonBoxHtml(message);

        return `
        <div class="row" data-message-id="${message.chatId}">
            <div class="col-10">
                ${nameHtml}
                <div class="row">
                    ${profileHtml}
                    <div class="col-9">
                        <div class="chat-bubble-container d-flex align-items-end">
                            <div class="chat-content d-flex align-items-center justify-content-center">
                                <p>${message.chatContents}</p>
                            </div>
                            <div class="chat-time">
                                ${formatDate(message.chatTime)}
                            </div>
                            <div class="unread-count-box">
                                    <span class="unread-count">${createUnreadCountHtml(message.unreadMessageCount)}</span>
                            </div>
                        </div>
                    </div>
                </div>
                ${emoticonHtml}
            </div>
        </div>`;
    }

    function createEmoticonBoxHtml(message) {
        var emoticons = createEmoticonButton(message);
        if (emoticons) {
            return `
            <div class="row d-flex align-items-start emoticon-boxes">
                <div class="blank"></div>
                <div class="emoticon-box">
                    ${emoticons}
                </div>
            </div>`;
        }
        return '';
    }


    function createMyEmoticonBoxHtml(message) {
        var emoticons = createEmoticonButton(message);
        if (emoticons) {
            return `
            <div class="row d-flex align-items-start justify-content-end emoticon-boxes">
                <div class="blank"></div>
                <div class="emoticon-box justify-content-end">
                    ${emoticons}
                </div>
            </div>`;
        }
        return '';

    }

    function createUnreadCountHtml(count) {
        return count > 0 ? `<span class="unread-count">${count}</span>` : '';
    }

    function connectWebSocket(chatRoomId) {
        if (currentSubscription) {
            currentSubscription.unsubscribe();
        }

        if (stompClient == null || !stompClient.connected) {
            var sockJs = new SockJS("/stomp/connection");
            stompClient = Stomp.over(sockJs);

            stompClient.connect({}, function() {
                console.log("WebSocket 연결 성공");
                subscribeToChatRoom(chatRoomId);
            });
        } else {
            subscribeToChatRoom(chatRoomId);
        }

        currentChatRoomId = chatRoomId;
    }

    function subscribeToChatRoom(chatRoomId) {
        currentSubscription = stompClient.subscribe("/sub/chat/room/" + chatRoomId, function(message) {
            var receivedMessage = JSON.parse(message.body);
            if (receivedMessage.type === 'CHAT') {
                // 채팅 메시지 처리
                addMessage(receivedMessage);
            } else if (receivedMessage.type === 'EMOTICON') {
                // 이모티콘 반응 처리
                updateEmoticon(receivedMessage);
            }
        });
    }

    function updateEmoticon(emoticonMessage) {
        var messageRow = $('.chat .row[data-message-id="' + emoticonMessage.chatId + '"]');

        if (messageRow.length === 0) {
            // 해당 메시지를 찾을 수 없는 경우 처리
            return;
        }

        // 이모티콘 박스 요소를 찾아 업데이트 또는 생성
        var emoticonBox = messageRow.find('.emoticon-box');
        if (emoticonBox.length === 0) {
            emoticonBox = $(`
            <div class="row d-flex align-items-start emoticon-boxes">
                <div class="blank"></div>
                <div class="emoticon-box"></div>
            </div>
        `);
            messageRow.append(emoticonBox);
        }

        // 이모티콘 버튼 업데이트 또는 추가
        var emoticonButton = emoticonBox.find('.emoticon-button[data-emoticon-type="' + emoticonMessage.emoticonType + '"]');
        if (emoticonButton.length === 0) {
            // 이모티콘 버튼이 없으면 생성
            emoticonButton = $(`
            <button class="emoticon-button" data-emoticon-type="${emoticonMessage.emoticonType}">
                <i class="${getEmoticonIconClass(emoticonMessage.emoticonType)}"></i>
                <span>5</span>
            </button>
        `);
            emoticonBox.find('.emoticon-box').append(emoticonButton);
        } else {
            // 이미 있으면 카운트 업데이트
            emoticonButton.find('span').text(5);
            // 필요한 경우 active 상태 업데이트
            if (emoticonMessage.senderId === currentEmployeeId) {
                emoticonButton.addClass('active-button');
            } else {
                emoticonButton.removeClass('active-button');
            }
        }
    }

    function addMessage(chatMessage) {
        var chatRow = generateMessageHtml(chatMessage);
        $('.chat').prepend(chatRow);
        $('.chat').scrollTop($('.chat')[0].scrollHeight);
    }

    function showEmoticonBox(event) {
        var emoticonBox = $('#emoticon-box');
        var target = $(event.currentTarget);
        currentMessageId = target.closest('.row[data-message-id]').data('message-id');

        emoticonBox.css('display', 'block');
        var offset = target.offset();
        var boxHeight = emoticonBox.outerHeight();

        if (target.hasClass('my-chat-content')) {
            emoticonBox.css({
                right: '60px',
                left: '',
                top: offset.top - boxHeight + 10 + 'px'
            });
        } else {
            emoticonBox.css({
                left: offset.left + 10 + 'px',
                right: '',
                top: offset.top - boxHeight + 10 + 'px'
            });
        }
    }

    function hideEmoticonBox() {
        timeoutId = setTimeout(function() {
            $('#emoticon-box').hide();
        }, 100);
    }

    // 동적 요소에 대한 이벤트 위임
    $('.chat').on({
        mouseenter: function(event) {
            showEmoticonBox(event);
        },
        mouseleave: function() {
            hideEmoticonBox();
        }
    }, '.chat-content, .my-chat-content');

    $('#emoticon-box').hover(
        function() {
            clearTimeout(timeoutId);
        },
        function() {
            $(this).hide();
        }
    );

    $('#emoticon-box i').on('click', function() {
        var emoticonType = $(this).data('emoticon-type');

        if (currentMessageId) {
            $.ajax({
                url: '/api/chatrooms/' + currentChatRoomId +'/chats/' + currentMessageId + '/emoticon',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ emoticonType: emoticonType }),
                success: function(response) {
                },
                error: function(xhr, status, error) {
                    console.error('이모티콘 추가에 실패했습니다:', error);
                }
            });
        } else {
            console.error('메시지 ID를 알 수 없습니다.');
        }
    });

    function getEmoticonIconClass(emoticonType) {
        var iconClasses = {
            'CHECK': 'fa-solid fa-check',
            'HEART': 'fa-solid fa-heart heart-icon',
            'THUMBS_UP': 'fa-solid fa-thumbs-up',
            'SMILE': 'fa-solid fa-face-smile',
            'SAD': 'fa-solid fa-face-sad-cry'
        };
        return iconClasses[emoticonType] || '';
    }

    function createEmoticonButton(message) {
        var emoticonTypes = ['CHECK', 'HEART', 'THUMBS_UP', 'SMILE', 'SAD'];
        var addContent = '';

        emoticonTypes.forEach(function(type) {

            var countKey = type.toLowerCase() + 'EmoticonCount';

            var clickedKey = 'isClicked' + type.charAt(0) + type.slice(1).toLowerCase() + 'Emoticon';
            if (type === 'THUMBS_UP') {
                countKey = 'thumbsUpEmoticonCount';
                clickedKey = 'isClickedThumbsUpEmoticon';
            }

            if (message[countKey] > 0) {
                var activeClass = message[clickedKey] ? 'active-button' : '';
                addContent += `
                <button class="emoticon-button ${activeClass}" data-emoticon-type="${type}">
                    <i class="${getEmoticonIconClass(type)}"></i>
                    <span>${message[countKey]}</span>
                </button>`;
            }
        });

        return addContent;
    }

    function formatDate(dateString) {
        var date = new Date(dateString);
        return date.toLocaleString('ko-KR', {
            year: '2-digit',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        });
    }
});

document.addEventListener("DOMContentLoaded", function() {
    const chatDates = document.querySelectorAll(".last-message-at p");
    const today = new Date().toISOString().slice(0, 10);

    chatDates.forEach(function(dateElement) {
        const fullDate = new Date(dateElement.textContent.trim());
        if (fullDate.toISOString().slice(0, 10) === today) {
            dateElement.textContent = fullDate.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit', hour12: false });
        } else {
            dateElement.textContent = fullDate.toLocaleDateString('ko-KR', { month: '2-digit', day: '2-digit' });
        }
    });
});