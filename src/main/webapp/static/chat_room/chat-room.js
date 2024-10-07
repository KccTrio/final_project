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
                console.log(data)
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

        console.log(message);

        if (message.chatType === "ENTER") {
            chatRow = createEnterMessage(message);
        } else if (message.chatType === "CHAT") {
            if (message.senderId === currentEmployeeId) {
                chatRow = createMyMessageHtml(message);
            } else {
                chatRow = createOtherMessageHtml(message, isSameSender);
            }
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

    function createEnterMessage(message) {
        return `
        <div class="row chat-one">
                <div class="col-10">
                    <div class="row">
                        <div class="col-1 d-flex justify-content-end">
                            <div class="add-chat-profile">
                                <i class="fa-solid fa-user-plus"></i>
                            </div>
                        </div>
                        <div class="col-9">
                            <div class="chat-bubble-container d-flex align-items-end">
                                <div
                                        class="d-flex align-items-center justify-content-center"
                                >
                                    <p>${message.chatContents}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>`;
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
            if (receivedMessage.chatType === "CHAT") {
                // 채팅 메시지 처리
                addMessage(receivedMessage);
            } else if (receivedMessage.chatType === 'EMOTICON') {
                // 이모티콘 반응 처리
                updateEmoticon(receivedMessage);
            } else if (receivedMessage.chatType === "ENTER") {
                // 채팅방 참여자 처리
                addEnterMessage(receivedMessage);
            }
        });
    }

    function addEnterMessage(enterMessage) {
        var chatRow = `
        <div class="row chat-one">
                <div class="col-10">
                    <div class="row">
                        <div class="col-1 d-flex justify-content-end">
                            <div class="add-chat-profile">
                                <i class="fa-solid fa-user-plus"></i>
                            </div>
                        </div>
                        <div class="col-9">
                            <div class="chat-bubble-container d-flex align-items-end">
                                <div
                                        class="d-flex align-items-center justify-content-center"
                                >
                                    <p>${enterMessage.chatContents}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>`;

        $('.chat').prepend(chatRow);
    }

    function updateEmoticon(emoticonMessage) {

        $.ajax({
            url: '/api/chatrooms/' + currentChatRoomId +'/chats/' + currentMessageId + '/emoticon',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                var messageRow = $('.chat .row[data-message-id="' + emoticonMessage.chatId + '"]');

                if (messageRow.length === 0) {
                    return;
                }

                // 기존 이모티콘 박스 제거
                messageRow.find('.emoticon-boxes').remove();

                console.log(emoticonMessage.chatterId);
                console.log(currentEmployeeId);

                // 새로운 이모티콘 박스 생성
                let emoticonHtml;
                if (emoticonMessage.chatterId === currentEmployeeId) {
                    emoticonHtml = createMyEmoticonBoxHtml(response);
                } else {
                    emoticonHtml = createEmoticonBoxHtml(response);
                }

                // 새로운 이모티콘 박스 DOM에 추가
                messageRow.find('.col-10').append(emoticonHtml);
            },
            error: function(xhr, status, error) {
                console.error('이모티콘 추가에 실패했습니다:', error);
            }
        });

    }

    function addMessage(chatMessage) {
        console.log(chatMessage);
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

    //emp-count-box 클릭 시 ajax로 직원 목록 가져오기
    var empModal = $('#emp-modal');
    var addEmpModal = $('#add-emp-modal');
    var empModalVisible = false;
    var addEmpModalVisible = false;

    // 모달 이벤트 핸들러 중복 방지
    $('.emp-count-box').off('click').on('click', function() {
        if (empModalVisible) {
            // 모달이 보이면 숨기기
            empModal.hide();
            addEmpModal.hide();
            addEmpModalVisible = false;  // 모달 상태 업데이트
            empModalVisible = false;  // 모달 상태 업데이트
            return;
        }
        empModalVisible = true;

        // AJAX 요청 전에 기존 데이터 비우기
        $('.emp-list').empty();
        $('.count').text('사람 (0)');

        // 모달 보이기
        empModal.show();

        // 데이터 불러오기
        $.ajax({
            url: '/api/chatrooms/' + currentChatRoomId + '/employees',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                updateEmployeeList(data);
            },
            error: function(xhr, status, error) {
                console.error("데이터를 불러오는 데 실패했습니다:", error);
            }
        });
    });

    // 모달 외부 클릭 시 닫기
    $(window).on('click', function(event) {
        if (!$(event.target).closest('#emp-modal, .emp-count-box, #add-emp-modal').length && empModalVisible) {
            empModal.hide();
            empModalVisible = false;
            addEmpModal.hide();
            addEmpModalVisible = false;
        }
    });



    function updateEmployeeList(data) {
        var listElement = $('.emp-list');
        $.each(data, function(index, employee) {
            listElement.append(
                `<div class="row emp-one d-flex align-items-center">
                <div class="col-5">
                    <div class="profile">
                        <img src="${employee.profileUrl}" />
                        <div class="status d-flex justify-content-center align-items-center">
                            <i class="fa-solid fa-check check-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="col-7 pl-0">
                    <p class="emp-name">${employee.name}</p>
                </div>
            </div>`
            );
        });
        $('.count').text(`사람 (${data.length})`);
    }

    $('.add-emp-box').off('click').on('click', function() {

        if (addEmpModalVisible) {
            // 모달이 보이면 숨기기
            console.log('모달이 이미 보이고 있습니다.');
            addEmpModal.hide();
            addEmpModalVisible = false;  // 모달 상태 업데이트
            return;
        }

        let whitelist = [];

        // AJAX를 통해 직원 목록 가져오기
        $.ajax({
            url: 'http://localhost:8081/api/chatrooms/' + currentChatRoomId + '/except-participants',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                addEmpModal.show();
                addEmpModalVisible = true;
                whitelist = data.map(function(employee) {
                    return {
                        name: employee.name + '/' + employee.position + '/' + employee.deptName, // 태그에 표시될 내용
                        value: employee.id.toString(), // 직원 ID를 문자열로 변환하여 저장
                    };
                });

                console.log('직원 데이터를 성공적으로 가져왔습니다:', whitelist);

                // Tagify 초기화
                let inputElm = document.querySelector("input[name='employees[]']");

                // initialize Tagify
                var tagify = new Tagify(inputElm, {
                    enforceWhitelist: true, // 화이트리스트에서 허용된 태그만 사용
                    whitelist: whitelist, // 화이트 리스트 배열. 화이트 리스트를 등록하면 자동으로 드롭다운 메뉴가 생긴다
                    autogrow: true, // 태그 입력창이 자동으로 늘어난다
                    originalInputValueFormat: function(valuesArr) {
                        return valuesArr.map(function(item) {
                            return item.value;
                        });
                    },
                    templates: {
                        tag: function(tagData) {
                            return `
                            <tag title="${tagData.name}"
                                contenteditable='false'
                                spellcheck='false'
                                class='tagify__tag ${tagData.class ? tagData.class : ''}'
                                ${this.getAttributes(tagData)}>
                                <x title='remove tag' class='tagify__tag__removeBtn'></x>
                                <div>
                                    <span class='tagify__tag-text'>${tagData.name}</span>
                                </div>
                            </tag>`;
                        },
                        dropdownItem: function(tagData) {
                            return `
                            <div ${this.getAttributes(tagData)}
                                class='tagify__dropdown__item ${tagData.class ? tagData.class : ''}'>
                                <span>${tagData.name}</span>
                            </div>`;
                        }
                    },
                    dropdown: {
                        // 검색에 사용할 속성 지정
                        searchKeys: ['name'],
                        maxItems: 5, // 최대 표시 아이템 수 (필요에 따라 조정)
                        enabled: 0    // 0으로 설정하면 입력한 글자 수와 상관없이 항상 드롭다운을 표시
                    }
                });

                // tagify 전용 이벤트 리스터
                tagify
                    .on("add", onAddTag) // 태그가 추가되면
                    .on("remove", onRemoveTag) // 태그가 제거되면
                    .on("input", onInput) // 태그가 입력되고 있을 경우
                    .on("invalid", onInvalidTag) // 허용되지 않는 태그일 경우
                    .on("click", onTagClick) // 해시 태그 블럭을 클릭할 경우
                    .on("focus", onTagifyFocusBlur) // 포커스 될 경우
                    .on("blur", onTagifyFocusBlur) // 반대로 포커스를 잃을 경우
                    .on("edit:start", onTagEdit) // 입력된 태그 수정을 할 경우
                    .on("dropdown:hide dropdown:show", (e) => console.log(e.type)) // 드롭다운 메뉴가 사라질경우
                    .on("dropdown:select", onDropdownSelect); // 드롭다운 메뉴에서 아이템을 선택할 경우

                // 이벤트 리스너 콜백 메소드 정의
                function onAddTag(e) {
                    console.log("onAddTag: ", e.detail);
                    console.log("original input value: ", inputElm.value);
                }

                function onRemoveTag(e) {
                    console.log(
                        "onRemoveTag:",
                        e.detail,
                        "tagify instance value:",
                        tagify.value
                    );
                }

                function onTagEdit(e) {
                    console.log("onTagEdit: ", e.detail);
                }

                function onInvalidTag(e) {
                    console.log("onInvalidTag: ", e.detail);
                }

                function onTagClick(e) {
                    console.log(e.detail);
                    console.log("onTagClick: ", e.detail);
                }

                function onTagifyFocusBlur(e) {
                    console.log(e.type, "event fired");
                }

                function onDropdownSelect(e) {
                    console.log("onDropdownSelect: ", e.detail);
                }

                function onInput(e) {
                    console.log("onInput: ", e.detail);

                    tagify.loading(true); // 태그 입력하는데 우측에 loader 애니메이션 추가
                    tagify.loading(false); // loader 애니메이션 제거

                    tagify.dropdown.show(e.detail.value); // 드롭다운 메뉴 보여주기
                    tagify.dropdown.hide(); // 드롭다운 제거
                }
            },
            error: function(xhr, status, error) {
                console.error('직원 데이터를 가져오는 데 실패했습니다:', error);
            }
        });
    });

    $('.create-button').on('click', function() {
        // input에서 값 가져오기
        var employees = $('input[name="employees[]"]').val();
        // 쉼표로 분리하고 숫자로 변환
        var employeeIds = employees.split(',').map(Number);
        var dataToSend = {
            employees: employeeIds // 서버가 기대하는 객체 형식
        };
        // Ajax 요청 보내기
        $.ajax({
            url: '/api/chatrooms/' + currentChatRoomId + '/participants',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(dataToSend), // JSON 형태로 변환
            success: function(data) {
                console.log('채팅방 참여자 추가에 성공했습니다:', data);
                empModal.hide();
                empModalVisible = false;
                addEmpModal.hide();
                addEmpModalVisible = false;
            },
            error: function(xhr, status, error) {
                console.error('채팅방 참여자 추가에 실패했습니다:', error);
            }
        });
    });

    $('.cancel-button').on('click', function() {
        addEmpModal.hide();
        addEmpModalVisible = false
    });



    // 채팅방 목록에서 첫 번째 채팅방 선택
    // var firstChatRoom = $('.chat-room-item').first();
    // firstChatRoom.trigger('click');

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