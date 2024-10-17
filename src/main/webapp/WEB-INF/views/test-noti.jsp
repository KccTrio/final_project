<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/component/lib.jsp" %>
<%@ include file="/WEB-INF/views/component/firebase-config.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>kcc정보통신 | Notification Test</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.0.0/firebase-messaging.js"></script>
    <script>
        $(document).ready(function() {
            $("#sendNotification").click(function() {
                var data = {
                    title: "우영두",
                    content: "우영두: 내일 회의는 11시로 정해졌습니다.",
                    image: "https://jmagazine.joins.com/_data2/photo/2021/04/838745483_FJchmDQj_7.jpg"
                    // 기타 SendPushDto 필드에 맞추어 추가
                };

                $.ajax({
                    url: '/notifications',  // Controller의 @PostMapping 주소
                    type: 'POST',
                    contentType: 'application/json',  // 서버에 JSON 형식으로 데이터 전송
                    data: JSON.stringify(data),  // JavaScript 객체를 JSON 문자열로 변환
                    success: function(response) {
                        console.log('Notification sent successfully!');
                    },
                    error: function(xhr, status, error) {
                        console.error('Failed to send notification:', xhr.responseText);
                    }
                });
            });
        });

    </script>
</head>
<body>
<button id="sendNotification">Send Notification</button>
</body>
</html>