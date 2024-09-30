$(document).ready(function() {
    var timeoutId = null; // 타이머 ID 저장 변수
    var roomId = 1 // $('#roomId').val();
    var sockJs = new SockJS("/stomp/connection");
    //1. SockJS를 내부에 들고있는 stomp를 내어줌
    var stomp = Stomp.over(sockJs);
    //2. SockJS를 통해 연결을 시도한다.
    stomp.connect({}, function() {
        //3. 연결이 성공하면 실행되는 콜백
        console.log("connected");

        //4. 구독하기
        stomp.subscribe("/sub/chat/room/" + roomId, function(data) {
            //5. 메시지가 도착하면 실행되는 콜백
            var chatMessage = JSON.parse(data.body);
            console.log(chatMessage);
            addMessage(chatMessage);
        });

        //6. 메시지 보내기
        $('#send').on('click', function() {
            var chatMessage = {
                roomId: roomId,
                sender: "WooYoungDoo",
                message: $('.chat-input').val()
            };
            stomp.send("/pub/chat/send", {}, JSON.stringify(chatMessage));
            $('.chat-input').val('');
        });

    });

    // chat-input에 엔터키 이벤트 추가
    $('.chat-input').keypress(function(event) {
        if (event.keyCode == 13) {
            $('#send').click();
            $('.chat-input').val('');
        }
    });

    function showEmoticonBoxByChatContent() {
        var emoticonBox = $('#emoticon-box');
        emoticonBox.css('display', 'block');
        emoticonBox.css('left', $(this).offset().left + 10 + 'px'); // 위치 조정
        emoticonBox.css('right', '');
        emoticonBox.css('top', $(this).offset().top - emoticonBox.outerHeight() + 10 + 'px'); // 위치 조정
    }

    function showEmoticonBoxByMyChatContent() {
        var emoticonBox = $('#emoticon-box');
        emoticonBox.css('display', 'block');
        emoticonBox.css('right', 60 + 'px'); // 위치 조정
        emoticonBox.css('left', '');
        emoticonBox.css('top', $(this).offset().top - emoticonBox.outerHeight() + 10 + 'px'); // 위치 조정
    }

    // 동적 요소에 대한 이벤트 위임
    $('.chat').on('mouseenter', '.my-chat-content', function() {
        showEmoticonBoxByMyChatContent.call(this);
    });

    $('.chat').on('mouseleave', '.my-chat-content', function() {
        hideEmoticonBox();
    });


    // 이모티콘 박스 숨김
    function hideEmoticonBox() {
        timeoutId = setTimeout(function() { // 500ms 후에 숨김
            $('#emoticon-box').hide();
        }, 100);
    }

    $('.chat-content').hover(
        showEmoticonBoxByChatContent,
        hideEmoticonBox
    );


    $('#emoticon-box').hover(
        function() {
            clearTimeout(timeoutId); // 이모티콘 박스에 마우스가 있을 때 타이머 취소
        }, // 호버할 때 아무 작업도 수행하지 않음
        function() { // 마우스가 박스에서 벗어났을 때 박스를 숨김
            $(this).hide();
        }
    );

});

function addMessage(chatMessage) {

    var addContent = `
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
                                    <p>${chatMessage.message}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    `;
    // .chat 맨 앞에 addContent 추가
    $('.chat').prepend(addContent);
    //.chat 맨 앞으로 스크롤 이동
    $('.chat').scrollTop(0);

}