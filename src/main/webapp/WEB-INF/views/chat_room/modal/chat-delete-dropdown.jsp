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
<ul class="deleteChatContextmenu">
    <li id="deleteChat">
        <a href="#">
            <i class="fa-regular fa-square-minus"></i>
            채팅 삭제
        </a>
    </li>
    <input type="hidden" id="chatId" value="">
</ul>
</body>
</html>