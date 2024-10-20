$(document).ready(function() {
    // body 태그에 이벤트를 위임하여 동적으로 생성된 이미지에도 이벤트가 적용되도록 함
    $('body').on('click', '.image-box img, .chat-area .chat-content img, .chat-area .my-chat-content img', function() {
        var src = $(this).attr('src'); // 클릭된 이미지의 src 속성을 가져옴
        let chatId = $(this).data('chat-id');
        $('#modalImage').attr('src', src); // 모달의 img 태그에 src를 설정
        $('#downloadImage').attr('data-chat-id', chatId);

        $('#imageModal').modal('show'); // 모달을 보여줌
    });

    $('#downloadImage').on('click', function() {
        let chatId = $(this).attr('data-chat-id');

        $.ajax({
            url: `/api/chatrooms/chats/${chatId}/attached-file/download`,
            method: 'GET',
            xhrFields: {
                responseType: 'blob' // Important
            },
            success: function(response, textStatus, xhr) {
                // 파일명 추출 (Content-Disposition 헤더에서 추출)
                var filename = "";
                var disposition = xhr.getResponseHeader('Content-Disposition');
                if (disposition && disposition.indexOf('attachment') !== -1) {
                    var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                    var matches = filenameRegex.exec(disposition);
                    if (matches != null && matches[1]) {
                        filename = matches[1].replace(/['"]/g, '');
                    }
                }

                // Blob 객체 생성 후 다운로드
                var blob = new Blob([response], { type: 'application/octet-stream' });
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = filename;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            },
            error: function(xhr, status, error) {
                console.error('파일 다운로드에 실패했습니다:', error);
            }
        });

    });


});