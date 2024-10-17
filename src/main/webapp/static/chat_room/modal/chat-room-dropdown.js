
$(document).ready(function(){
    //Show contextmenu:
    $(".chat-rooms-list").on("contextmenu", ".chat-room-item", function(e){
        //Get window size:
        var winWidth = $(document).width();
        var winHeight = $(document).height();
        //Get pointer position:
        var posX = e.pageX;
        var posY = e.pageY;
        //Get contextmenu size:
        var menuWidth = $(".contextmenu").width();
        var menuHeight = $(".contextmenu").height();
        //Security margin:
        var secMargin = 10;
        //Prevent page overflow:
        if(posX + menuWidth + secMargin >= winWidth
            && posY + menuHeight + secMargin >= winHeight){
            //Case 1: right-bottom overflow:
            posLeft = posX - menuWidth - secMargin + "px";
            posTop = posY - menuHeight - secMargin + "px";
        }
        else if(posX + menuWidth + secMargin >= winWidth){
            //Case 2: right overflow:
            posLeft = posX - menuWidth - secMargin + "px";
            posTop = posY + secMargin + "px";
        }
        else if(posY + menuHeight + secMargin >= winHeight){
            //Case 3: bottom overflow:
            posLeft = posX + secMargin + "px";
            posTop = posY - menuHeight - secMargin + "px";
        }
        else {
            //Case 4: default values:
            posLeft = posX + secMargin + "px";
            posTop = posY + secMargin + "px";
        };

        var chatRoomId = $(this).data("chat-room-id");
        $("#chatRoomId").val(chatRoomId);

        //Display contextmenu:
        $(".contextmenu").css({
            "left": posLeft,
            "top": posTop
        }).show();
        //Prevent browser default contextmenu.
        return false;
    });
    //Hide contextmenu:
    $(document).click(function(){
        $(".contextmenu").hide();
        $(".deleteChatContextmenu").hide();
    });

    // 삭제 메뉴 아이템 클릭 이벤트 처리
    $(".contextmenu").on("click", "#quitChatRoom", function(){
        var chatRoomId = $("#chatRoomId").val(); // 숨겨진 input에서 채팅방 ID 가져오기

        Swal.fire({
            title: "삭제하시겠습니까?",
            text: "되돌릴 수 없습니다!",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            confirmButtonText: "삭제",
            cancelButtonText: "취소",
            cancelButtonColor: "#d33",
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: "삭제",
                    text: "삭제 완료 되었습니다.",
                });
                // 2초 후 채팅방 삭제
                setTimeout(function() {
                    deleteChatRoom(chatRoomId);
                }, 2000);
            }
        })
    });

    $(".chat-contents").on("contextmenu", ".my-chat-content", function(e){
        console.log("Chat bubble contextmenu clicked");
        //Get window size:
        var winWidth = $(document).width();
        var winHeight = $(document).height();
        //Get pointer position:
        var posX = e.pageX;
        var posY = e.pageY;
        //Get contextmenu size:
        var menuWidth = $(".deleteChatContextmenu").width();
        var menuHeight = $(".deleteChatContextmenu").height();
        //Security margin:
        var secMargin = 10;
        //Prevent page overflow:
        if(posX + menuWidth + secMargin >= winWidth
            && posY + menuHeight + secMargin >= winHeight){
            //Case 1: right-bottom overflow:
            posLeft = posX - menuWidth - secMargin + "px";
            posTop = posY - menuHeight - secMargin + "px";
        }
        else if(posX + menuWidth + secMargin >= winWidth){
            //Case 2: right overflow:
            posLeft = posX - menuWidth - secMargin + "px";
            posTop = posY + secMargin + "px";
        }
        else if(posY + menuHeight + secMargin >= winHeight){
            //Case 3: bottom overflow:
            posLeft = posX + secMargin + "px";
            posTop = posY - menuHeight - secMargin + "px";
        }
        else {
            //Case 4: default values:
            posLeft = posX + secMargin + "px";
            posTop = posY + secMargin + "px";
        };

        var messageId = $(this).closest("[data-message-id]").data("message-id");
        $("#chatId").val(messageId);

        //Display contextmenu:
        $(".deleteChatContextmenu").css({
            "left": posLeft,
            "top": posTop
        }).show();
        //Prevent browser default contextmenu.
        return false;
    });

    // 삭제 메뉴 아이템 클릭 이벤트 처리
    $(".deleteChatContextmenu").on("click", "#deleteChat", function(){
        var chatId = $("#chatId").val(); // 숨겨진 input에서 채팅방 ID 가져오기

        Swal.fire({
            title: "채팅을 삭제하시겠습니까?",
            text: "되돌릴 수 없습니다.",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            confirmButtonText: "삭제",
            cancelButtonText: "취소",
            cancelButtonColor: "#d33",
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: "삭제",
                    text: "삭제 완료 되었습니다.",
                });
                deleteChat(chatId);
            }
        })
    });
});

function deleteChatRoom(chatRoomId) {
    console.log("Deleting chat room with ID:", chatRoomId);
    // 채팅방 삭제 로직 구현 필요
    $.ajax({
        type: 'DELETE',
        url: '/api/chatrooms/' + chatRoomId,
        success: function(response) {
            console.log("Chat room deleted successfully:", response);
            // 채팅방 삭제 성공 시 채팅방 목록 다시 불러오기
            location.reload();
        },
        error: function(error) {
            console.error("Error deleting chat room:", error);
        }
    })
}

function deleteChat(chatId) {
    console.log("Deleting chat with ID:", chatId);
    // 채팅 삭제 로직 구현 필요
    $.ajax({
        type: 'DELETE',
        url: '/api/chatrooms/chats/' + chatId,
        success: function(response) {
            console.log("Chat deleted successfully:", response);
        },
        error: function(error) {
            console.error("Error deleting chat:", error);
        }
    })
}