$(document).ready(function() {
    var timeoutId = null; // 타이머 ID 저장 변수

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

    $('.my-chat-content').hover(
        showEmoticonBoxByMyChatContent,
        hideEmoticonBox
    );


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