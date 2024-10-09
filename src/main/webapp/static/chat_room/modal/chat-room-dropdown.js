
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
    });

    // 삭제 메뉴 아이템 클릭 이벤트 처리
    $(".contextmenu").on("click", "#quitChatRoom", function(){
        var chatRoomId = $("#chatRoomId").val(); // 숨겨진 input에서 채팅방 ID 가져오기

        Swal.fire({
            title: "삭제하시겠습니까?",
            text: "되돌릴 수 없습니다!",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Delete"
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