<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib
        prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/component/lib.jsp" %>
<%@ include file="/WEB-INF/views/component/firebase-config.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link
            rel="stylesheet"
            href="<%= request.getContextPath() %>/static/chat_room/chat-room.css"
    />
    <link
            rel="stylesheet"
            href="<%= request.getContextPath() %>/static/chat_room/chat-room-list.css"
    />
    <link
            rel="stylesheet"
            href="<%= request.getContextPath() %>/static/chat_room/chat-room-save.css"
    />
    <%--    js 추가--%>
    <script src="/static/chat_room/chat-room.js" charset="utf-8"></script>
    <script src="/static/chat_room/chat-room-save.js" charset="utf-8"></script>

    <link
            href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css"
            rel="stylesheet"
    />
    <!-- 소스 다운 -->
    <script src="https://unpkg.com/@yaireo/tagify"></script>
    <!-- 폴리필 (구버젼 브라우저 지원) -->
    <script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
    <link
            href="https://unpkg.com/@yaireo/tagify/dist/tagify.css"
            rel="stylesheet"
            type="text/css"
    />

    <script>
        messaging.requestPermission()
            .then(function () {
                return messaging.getToken();
            })
            .then(async function (token) {
                localStorage.setItem('Fcmtoken', token);
            });
        console.log(localStorage.getItem('Fcmtoken'));

        $.ajax({
            url: '/api/employees/fcm-token',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({fcmToken: localStorage.getItem('Fcmtoken')}),
            success: function (data) {
                console.log('FCM을 저장하는데에 성공했습니다.');
            },
            error: function (xhr, status, error) {
                console.error('FCM을 저장하는데에 실패했습니다.:', error);
            }
        });
    </script>

    <title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/component/top-bar.jsp"/>
<jsp:include page="/WEB-INF/views/component/first-side-bar.jsp"/>

<div class="second-side-bar">
    <div>
        <div class="container-fluid">
            <div
                    class="row category d-flex justify-content-between d-flex align-items-center"
            >
                <div class="col-4">
                    <p class="category-name">채팅</p>
                </div>
                <div class="col-3">
                    <a href="#">
                        <i class="fa-regular fa-pen-to-square"></i>
                    </a>
                </div>
            </div>
            <div class="row chat-room-type">
                <div class="col-6 selection-box">
                    <div class="d-flex justify-content-center chat-room-selection">
                        <p>목록</p>
                    </div>
                </div>
                <div class="col-6 favor-box inactive-box">
                    <div class="d-flex justify-content-center chat-room-favor">
                        <p>즐겨찾기</p>
                    </div>
                </div>
            </div>
            <div class="chat-rooms-list">
                <c:forEach items="${chatRoomList}"
                           var="chatRoom">
                    <div class="row chat-room chat-room-item justify-content-between" data-chat-room-id="${chatRoom.chatRoomId}">
                        <div class="col-3">
                            <div class="profile">
                                <img
                                        src="${chatRoom.chatRoomProfileImageUrl}"
                                />
                                <div
                                        class="status d-flex justify-content-center align-items-center"
                                >
                                    <i class="fa-solid fa-check check-icon"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-8 d-flex align-content-between flex-wrap no-padding-left ">
                            <div class="row d-flex justify-content-between name-time-box">
                                <div class="col-8 no-padding-left">
                                    <div class="chat-room-name">
                                        <p>${chatRoom.chatRoomName}</p>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="last-message-at sub-text">
                                        <p>${chatRoom.lastMessageTime}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="row w-100 d-flex justify-content-between align-items-end">
                                <div class="col-9 no-padding-left">
                                    <div class="chat-room-last-message sub-text">
                                        <p>${chatRoom.lastMessage}</p>
                                    </div>
                                </div>

                                <c:if test="${chatRoom.unreadMessageCount > 0}">
                                    <div class="col-3 text-end">
                                        <div class="unread-count-box">
                                            <p class="unread-count">${chatRoom.unreadMessageCount}</p>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <div class="row chat-room chat-room-item justify-content-between">
                    <div class="col-3">
                        <div class="profile">
                            <img
                                    src="https://e7.pngegg.com/pngimages/1/723/png-clipart-graphy-business-portrait-business-people-public-relations.png"
                            />
                            <div
                                    class="status d-flex justify-content-center align-items-center"
                            >
                                <i class="fa-solid fa-check check-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-8 d-flex align-content-between flex-wrap no-padding-left">
                        <div class="row d-flex justify-content-between name-time-box">
                            <div class="col-8 no-padding-left">
                                <div class="chat-room-name">
                                    <p>dd</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="last-message-at sub-text ml-auto">
                                    <p>14:30</p>
                                </div>
                            </div>
                        </div>
                        <div class="row w-100 d-flex justify-content-between align-items-end">
                            <div class="col-9 no-padding-left">
                                <div class="chat-room-last-message sub-text">
                                    <p>dd </p>
                                </div>
                            </div>
                            <div class="col-3 text-end">
                                <div class="unread-count-box">
                                    <p class="unread-count">1</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<div class="contents save-contents" style="display: none">
    <div class="container-fluid">
        <div class="row category d-flex align-items-center">
            <div class="col-4"><p class="category-name">채팅 생성</p></div>
        </div>
        <form
                name="create-chatroom-form"
                action="http://localhost:8081/chatrooms/save"
                method="post"
        >
            <div class="create-input-box">
                <div class="create-add-emp-box">
                    <div class="row add-dept-box">
                        <i class="fa-solid fa-plus plus-icon"></i>
                        <span>조직도로 추가하기</span>
                    </div>
                    <div class="row create-input-add-emp-box">
                        <div class="col-1">
                            <i class="fa-solid fa-user-plus user-plus-icon"></i>
                        </div>
                        <div class="col-11">
                            <input
                                    name="employees[]"
                                    placeholder="사용자를 추가해주세요."
                                    value=""
                                    data-blacklist=".NET,PHP"
                                    autofocus
                            />
                        </div>
                    </div>
                </div>
                <div class="input-add-group-name">
                    <div class="row">
                        <div class="col-1">
                            <i class="fa-solid fa-pen-to-square"></i>
                        </div>
                        <div class="col-11">
                            <input name="chatRoomName" type="text" name="chatRoomName" placeholder="채팅방 명을 입력해주세요." />
                        </div>
                    </div>
                </div>
                <div class="button-area">
                    <div class="row d-flex justify-content-end">
                        <div class="col-4">
                            <div class="row d-flex justify-content-between">
                                <div class="col-6">
                                    <button type="submit" class="create-button">생성</button>
                                </div>
                                <div class="col-6">
                                    <button class="cancel-button" onclick="history.back();">취소</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="contents chat-contents">
    <div class="container-fluid">
        <div
                class="row category d-flex align-items-center d-flex justify-content-between chat-room-selection"
        >
            <div class="col-1">
                <div class="chat-room-profile">
                    <img
                            src="https://e7.pngegg.com/pngimages/1/723/png-clipart-graphy-business-portrait-business-people-public-relations.png"
                            class="chat-room-profile-image"
                    />
                    <div
                            class="status d-flex justify-content-center align-items-center"
                    >
                        <i class="fa-solid fa-check check-icon"></i>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="chat-room-name">
                    <p class="group-name">우영두</p>
                </div>
            </div>
            <div
                    class="col-2 d-flex justify-content-center d-flex justify-content-between selection"
            >
                <div class="active">
                    <a href="#" class="chat-button">채팅</a>
                </div>
                <div>
                    <a href="#" class="file-button">파일</a>
                </div>
                <div>
                    <a href="#">사진</a>
                </div>
            </div>
            <div class="col-3"></div>
            <div
                    class="col-2 d-flex justify-content-center d-flex align-items-center"
            >
                <div class="emp-count-box">
                    <i class="fa-solid fa-user-group"></i>
                    <span class="emp-count ml-2">3</span>
                </div>
            </div>
        </div>
        <div class="chat-area">
            <div class="chat">
                <%-- 채팅 인원 추가 --%>
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
                                        <p>우영두님이 우영두님을 초대하셨습니다.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <%--전 사람과 같은 채팅일 시--%>
                <div class="row chat-one">
                    <div class="col-10">
                        <div class="row">
                            <div class="col-1"></div>
                            <div class="col-9">
                                <div class="chat-bubble-container d-flex align-items-end">
                                    <div
                                            class="chat-content d-flex align-items-center justify-content-center"
                                    >
                                        <div class="file-box">
                                            <div class="row d-flex justify-content-between  align-items-center">
                                                <div class="col-11">
                                                    <p>파일명파이라안ㅁ이ㅏㄴ머아ㅣㄴ머아ㅣㄴ.jpg</p>
                                                    <div class="row">
                                                        <div class="tag-box">
                                                            <span class="tag">태그1태그태그</span>
                                                            <span class="tag">태그2</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-1">
                                                    <i class="fa-solid fa-download"></i>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <div class="chat-time">
                                        24/09/12 오전 9:30
                                    </div>
                                    <div class="unread-count-box">
                                        <span class="unread-count">1</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row d-flex align-items-start emoticon-boxes">
                            <div class="blank">
                            </div>
                            <div class="emoticon-box">
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-check"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button active-button">
                                    <i class="fa-solid fa-heart heart-icon"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-thumbs-up"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-smile"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-sad-cry"></i>
                                    <span>5</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row chat-one">
                    <div class="col-10">
                        <div class="row">
                            <div class="col-1"></div>
                            <div class="col-9">
                                <div class="chat-bubble-container d-flex align-items-end">
                                    <div
                                            class="chat-content d-flex align-items-center justify-content-center"
                                    >
                                        <p>안녕하세요. 신입 사원입니다람쥐.</p>
                                    </div>
                                    <div class="chat-time">
                                        24/09/12 오전 9:30
                                    </div>
                                    <div class="unread-count-box">
                                        <span class="unread-count">1</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row d-flex align-items-start emoticon-boxes">
                            <div class="blank">
                            </div>
                            <div class="emoticon-box">
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-check"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button active-button">
                                    <i class="fa-solid fa-heart heart-icon"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-thumbs-up"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-smile"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-sad-cry"></i>
                                    <span>5</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-10">
                        <div class="row d-flex justify-content-end">
                            <div class="col-11 emp-name d-flex justify-content-start">
                                <span>우 영두</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-1">
                                <div class="chat-profile">
                                    <img
                                            src="https://e7.pngegg.com/pngimages/1/723/png-clipart-graphy-business-portrait-business-people-public-relations.png"
                                    />
                                    <div
                                            class="status d-flex justify-content-center align-items-center"
                                    >
                                        <i class="fa-solid fa-check check-icon"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-9">
                                <div class="emoticon-chat-bubble-container d-flex align-items-end">
                                    <div
                                            class="chat-content d-flex align-items-center justify-content-center"
                                    >
                                        <p>안녕하세요. 신입 사원입니다.</p>
                                    </div>
                                    <div class="chat-time">
                                        24/09/12 오전 9:30
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row d-flex align-items-start emoticon-boxes">
                            <div class="blank">
                            </div>
                            <div class="emoticon-box">
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-check"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button active-button">
                                    <i class="fa-solid fa-heart heart-icon"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-thumbs-up"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-smile"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-sad-cry"></i>
                                    <span>5</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <%--내 채팅일 시--%>
                <div class="row d-flex justify-content-end">
                    <div class="col-10">
                        <div class="row d-flex justify-content-end">
                            <div class="col-9">
                                <div class="chat-bubble-container d-flex align-items-end d-flex justify-content-end">
                                    <div class="my-chat-time">
                                        24/09/12 오전 9:30
                                    </div>
                                    <div
                                            class="my-chat-content d-flex align-items-center justify-content-center"
                                    >
                                        <p>안녕하세요. 신입 사원입니다.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row d-flex align-items-start justify-content-end emoticon-boxes">
                            <div class="blank">
                            </div>
                            <div class="emoticon-box justify-content-end">
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-check"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button active-button">
                                    <i class="fa-solid fa-heart heart-icon"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-thumbs-up"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-smile"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-sad-cry"></i>
                                    <span>5</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row d-flex justify-content-end">
                    <div class="col-10">
                        <div class="row d-flex justify-content-end">
                            <div class="col-9">
                                <div class="chat-bubble-container d-flex align-items-end d-flex justify-content-end">
                                    <div class="my-chat-time">
                                        24/09/12 오전 9:30
                                    </div>
                                    <div
                                            class="my-chat-content d-flex align-items-center justify-content-center"
                                    >
                                        <div class="file-box">
                                            <div class="row d-flex justify-content-between  align-items-center">
                                                <div class="col-11">
                                                    <p>파일명파이라안ㅁ이ㅏㄴ머아ㅣㄴ머아ㅣㄴ.jpg</p>
                                                    <div class="row">
                                                        <div class="tag-box">
                                                            <span class="tag">태그1태그태그</span>
                                                            <span class="tag">태그2</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-1">
                                                    <i class="fa-solid fa-download"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row d-flex align-items-start justify-content-end emoticon-boxes">
                            <div class="blank">
                            </div>
                            <div class="emoticon-box justify-content-end">
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-check"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button active-button">
                                    <i class="fa-solid fa-heart heart-icon"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-thumbs-up"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-smile"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-sad-cry"></i>
                                    <span>5</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <%--            사진 일 때--%>
                <div class="row d-flex justify-content-end">
                    <div class="col-10">
                        <div class="row d-flex justify-content-end">
                            <div class="col-9">
                                <div class="chat-bubble-container d-flex align-items-end d-flex justify-content-end">
                                    <div class="my-chat-time">
                                        24/09/12 오전 9:30
                                    </div>
                                    <div
                                            class="my-chat-content d-flex align-items-center justify-content-center"
                                    >
                                        <div class="file-box">
                                            <div class="row d-flex justify-content-between  align-items-center">
                                                <div class="col-10">
                                                    <img src="https://s3.ap-northeast-2.amazonaws.com/dootrio-bucket/chat/ellipsis-solid_b3ba5156-abee-4334-a2c7-3fc4b8bc972c.svg" alt="사진" class="chat-image"/>
                                                    <div class="row">
                                                        <div class="tag-box">
                                                            <i class="fa-solid fa-tag"></i>
                                                            <span class="tag">태그1태그태그</span>
                                                            <span class="tag">태그2</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row d-flex align-items-start justify-content-end emoticon-boxes">
                            <div class="blank">
                            </div>
                            <div class="emoticon-box justify-content-end">
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-check"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button active-button">
                                    <i class="fa-solid fa-heart heart-icon"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-thumbs-up"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-smile"></i>
                                    <span>5</span>
                                </button>
                                <button class="emoticon-button">
                                    <i class="fa-solid fa-face-sad-cry"></i>
                                    <span>5</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="chat-send-box">
                <div class="container-fluid">
                    <div class="d-flex justify-content-center">
                        <div class="chat-send-input d-flex justify-content-center">
                            <input type="text" class="chat-input" placeholder="메시지를 입력하세요."/>
                            <i class="fa-regular fa-file"></i>
                            <i id="send" class="fa-regular fa-paper-plane"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="file-area" style="display: none;">
            <div class="tag-input-area">
                <div class="row">
                    <div class="col-1 d-flex align-items-center justify-content-end">
                        <i class="fa-solid fa-tag"></i>
                    </div>
                    <div class="col-11">
                        <input
                                name="tags"
                                placeholder="태그로 검색해보세요."
                                value=""
                                data-blacklist=".NET,PHP"
                                autofocus
                        />
                    </div>
                </div>
            </div>
            <div class="file-table">
                <div class="table-container">
                    <table>
                        <thead>
                        <tr>
                            <th>이름</th>
                            <th>공유 날짜</th>
                            <th>보낸 사람</th>
                            <th>태그</th>
                            <th>다운로드</th>
                        </tr>
                        </thead>
                            <tbody>
                            <tr>
                                <td>우영두</td>
                                <td>2024-01-01</td>
                                <td>(713) 123-8965</td>
                                <td><a href="mailto:jmatman@stewart.com">jmatman@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Johnny</td>
                                <td>Smith</td>
                                <td>(713) 584-9614</td>
                                <td><a href="mailto:jsmith@stewart.com">jsmith@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Susan</td>
                                <td>Johnson</td>
                                <td>(713) 847-1124</td>
                                <td><a href="mailto:sjohnson@stewart.com">sjohnson@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                            <tr>
                                <td>Tracy</td>
                                <td>Richardson</td>
                                <td>(713) 245-4821</td>
                                <td><a href="mailto:trichard@stewart.com">trichard@stewart.com</a></td>
                                <td><i class="fa-solid fa-download"></i></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


    </div>
</div>

<div id="emoticon-box"
     style="display: none; position: absolute; padding: 5px; border: 1px solid #ccc; background: white;">
    <!-- Example emoticons, replace these with your actual emoticons -->
    <i class="fa-solid fa-check" data-emoticon-type="CHECK"></i>
    <i class="fa-solid fa-heart heart-icon" data-emoticon-type="HEART"></i>
    <i class="fa-solid fa-thumbs-up" data-emoticon-type="THUMBS_UP"></i>
    <i class="fa-solid fa-face-smile" data-emoticon-type="SMILE"></i>
    <i class="fa-solid fa-face-sad-cry" data-emoticon-type="SAD"></i>
</div>
<%@ include file="/WEB-INF/views/chat_room/modal/participant-emp-modal.jsp" %>
<%@ include file="/WEB-INF/views/chat_room/modal/chat-room-dropdown.jsp" %>
<%@ include file="/WEB-INF/views/chat_room/modal/send-file-modal.jsp" %>

</body>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</html>
