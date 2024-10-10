<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib
        prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/component/lib.jsp" %>
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
    <%--    js 추가--%>
    <script src="/static/chat_room/chat-room.js" charset="utf-8"></script>
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
                    <a href="http://localhost:8081/chatrooms/save">
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
<div class="contents">
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
                    <a href="#">채팅</a>
                </div>
                <div>
                    <a href="#">파일</a>
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


        </div>
        <div class="chat-send-box">
            <div class="container-fluid">
                <div class="chat-send-input d-flex justify-content-center">
                    <input type="text" class="chat-input" placeholder="메시지를 입력하세요."/>
                    <i class="fa-regular fa-file"></i>
                    <i id="send" class="fa-regular fa-paper-plane"></i>
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

</body>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</html>
