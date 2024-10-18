
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

        console.log("is-favorited:", $(this).data("is-favorited"));
        var isFavorited = $(this).data("is-favorited");
        $("#isFavorited").val(isFavorited);

        if(isFavorited == true) {
            // i태그 클래스 변경
            $("#favorButton i").removeClass("fa-regular");
            $("#favorButton i").addClass("fa-solid");
            $("#favorButton span").text("즐겨찾기 해제");
        } else {
            // i태그 클래스 변경
            $("#favorButton i").removeClass("fa-solid");
            $("#favorButton i").addClass("fa-regular");
            $("#favorButton span").text("즐겨찾기");
        }

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

    $(".contextmenu").on("click", "#favorButton", function(){
        var chatRoomId = $("#chatRoomId").val(); // 숨겨진 input에서 채팅방 ID 가져오기

        let text;
        let buttonText;
        // 즐겨찾기가 되어있는 경우
        // chatRoomId를 이용하여 is-favorited를 가져와서 text와 buttonText를 변경

        let isFavorited = $("#isFavorited").val();

        if(isFavorited == "true") {
            text = "즐겨찾기를 해제하시겠습니까?";
            buttonText = "즐겨찾기 해제";
        } else {
            text = "즐겨찾기를 등록하시겠습니까?";
            buttonText = "즐겨찾기 등록";
        }

        Swal.fire({
            title: "즐겨찾기",
            text: text,
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            confirmButtonText: buttonText,
            cancelButtonText: "취소",
            cancelButtonColor: "#d33",
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: "즐겨찾기",
                    text: "완료되었습니다.",
                });
                favorChatRoom(chatRoomId);
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

function favorChatRoom(chatRoomId) {
    // 채팅방 즐겨찾기 로직 구현 필요
    $.ajax({
        type: 'POST',
        url: '/api/chatrooms/' + chatRoomId + '/favorite',
        success: function(response) {
            console.log("Chat favorited successfully:", response);
            // 즐겨찾기 삭제 시 즐겨찾기 탭에 있다면 채팅방 목록 다시 불러오기
            if (!$('.favor-box').hasClass('inactive-box')) {
                //채팅목록에서 chatRoomId를 가진 채팅방을 찾아서 목록창에서 제거
                var chatRoom = $(".chat-room-item[data-chat-room-id=" + chatRoomId + "]");
                chatRoom.remove();
            }
        },
        error: function(error) {
            console.error("Error favoriting chat:", error);
        }
    })
}