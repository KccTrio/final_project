<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert title here</title>
    <link
            rel="stylesheet"
            href="<%= request.getContextPath() %>/static/chat_room/modal/chat-room-dropdown.css"
    />
    <script src="<%= request.getContextPath() %>/static/chat_room/modal/chat-room-dropdown.js"></script>
</head>
<body>
<ul class="contextmenu">
    <li id="quitChatRoom">
        <a href="#">
        <i class="fa-regular fa-square-minus"></i>
        채팅방 나가기
        </a>
    </li>
    <li id="favorButton">
        <a href="#">
        <i class="fa-regular fa-star"></i>
        즐겨찾기 등록/취소
        </a>
    </li>
    <input type="hidden" id="chatRoomId" value="">
</ul>
</body>
</html>