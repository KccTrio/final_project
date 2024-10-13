// var sendFileModalVisible = false
// var tagify2;

document.addEventListener('DOMContentLoaded', function() {
    var modal = document.getElementById("send-file-modal");
    var fileIcon = document.querySelector(".fa-file");

    fileIcon.addEventListener('click', function() {
        var rect = fileIcon.getBoundingClientRect();
        var modalWidth = modal.offsetWidth;
        var modalHeight = modal.offsetHeight;

        var leftPosition = window.scrollX + rect.left - modalWidth - 400;
        var topPosition = window.scrollY + rect.top - modalHeight - 360; // 모달 높이와 추가적인 간격을 빼서 위로 이동

        modal.style.top = topPosition + "px";
        modal.style.left = leftPosition + "px";
        modal.style.display = "block";
    });

    // let inputElm = document.querySelector('input[name=tag]');
    //
    // // 화이트 리스트 : 해당 문자만 태그로 추가 가능
    // let whitelist = ["서류","계획서","제안서","발표자료","ppt"];
    //
    // // initialize Tagify
    // tagify2 = new Tagify(inputElm, {
    //     enforceWhitelist: false, // 화이트리스트에서 허용된 태그만 사용
    //     whitelist: whitelist // 화이트 리스트 배열. 화이트 리스트를 등록하면 자동으로 드롭다운 메뉴가 생긴다
    // })
    //
    // // tagify 전용 이벤트 리스터. 참조 : https://github.com/yairEO/tagify#events
    // tagify2.on('add', onAddTag) // 태그가 추가되면
    //     .on('remove', onRemoveTag) // 태그가 제거되면
    //     .on('input', onInput) // 태그가 입력되고 있을 경우
    //     .on('invalid', onInvalidTag) // 허용되지 않는 태그일 경우
    //     .on('click', onTagClick) // 해시 태그 블럭을 클릭할 경우
    //     .on('focus', onTagifyFocusBlur) // 포커스 될 경우
    //     .on('blur', onTagifyFocusBlur) // 반대로 포커스를 잃을 경우
    //
    //     .on('edit:start', onTagEdit) // 입력된 태그 수정을 할 경우
    //
    //     .on('dropdown:hide dropdown:show', e => console.log(e.type)) // 드롭다운 메뉴가 사라질경우
    //     .on('dropdown:select', onDropdownSelect) // 드롭다운 메뉴에서 아이템을 선택할 경우
    //
    //
    // // tagify 전용 이벤트 리스너 제거 할떄
    // tagify2.off('add', onAddTag);
    //
    //
    // // 이벤트 리스너 콜백 메소드
    // function onAddTag(e){
    //     console.log("onAddTag: ", e.detail);
    //     console.log("original input value: ", inputElm.value)
    // }
    //
    // // tag remvoed callback
    // function onRemoveTag(e){
    //     console.log("onRemoveTag:", e.detail, "tagify instance value:", tagify.value)
    // }
    //
    // function onTagEdit(e){
    //     console.log("onTagEdit: ", e.detail);
    // }
    //
    // // invalid tag added callback
    // function onInvalidTag(e){
    //     console.log("onInvalidTag: ", e.detail);
    // }
    //
    // // invalid tag added callback
    // function onTagClick(e){
    //     console.log(e.detail);
    //     console.log("onTagClick: ", e.detail);
    // }
    //
    // function onTagifyFocusBlur(e){
    //     console.log(e.type, "event fired")
    // }
    //
    // function onDropdownSelect(e){
    //     console.log("onDropdownSelect: ", e.detail)
    // }
    //
    // function onInput(e){
    //     console.log("onInput: ", e.detail);
    //
    //     tagify2.loading(true) // 태그 입력하는데 우측에 loader 애니메이션 추가
    //     tagify2.loading(false) // loader 애니메이션 제거
    //
    //     tagify2.dropdown.show(e.detail.value); // 드롭다운 메뉴 보여주기
    //     tagify2.dropdown.hide(); // // 드롭다운 제거
    // }

});