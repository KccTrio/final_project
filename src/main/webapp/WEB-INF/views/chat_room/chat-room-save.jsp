<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/static/chat_room/chat-room-save.css"
    />
    <link
      href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css"
      rel="stylesheet"
    />
    <!-- 소스 다운 -->
    <script src="https://unpkg.com/@yaireo/tagify"></script>
    <!-- 폴리필 (구버젼 브라우저 지원) -->
    <script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
    <link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />

    <title>Insert title here</title>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/component/top-bar.jsp" />
    <jsp:include page="/WEB-INF/views/component/first-side-bar.jsp" />

    <div class="second-side-bar">
      <div>
        <div class="container-fluid">
          <div
            class="row category d-flex justify-content-between d-flex align-items-center"
          >
            <div class="col-4">
              <p class="category-name">채팅</p>
            </div>
            <div class="col-3">
              <button>
                <i class="fa-regular fa-pen-to-square"></i>
              </button>
            </div>
          </div>
          <div class="row chat-room-type">
            <div class="col-6 selection-box">
              <div class="d-flex justify-content-center chat-room-selection">
                <p>목록</p>
              </div>
            </div>
            <div class="col-6 favor-box inactive-box">
              <div class="d-flex justify-content-center chat-room-favor">
                <p>즐겨찾기</p>
              </div>
            </div>
          </div>
          <div class="chat-rooms-list">
            <div class="row chat-room mt-3">
              <div class="col-3">
                <div class="profile">
                  <img
                    src="https://e7.pngegg.com/pngimages/1/723/png-clipart-graphy-business-portrait-business-people-public-relations.png"
                  />
                  <div
                    class="status d-flex justify-content-center align-items-center"
                  >
                    <i class="fa-solid fa-check check-icon"></i>
                  </div>
                </div>
              </div>
              <div class="col-8 d-flex align-content-between flex-wrap">
                <div class="row d-flex justify-content-between">
                  <div class="col-8">
                    <div class="chat-room-name">
                      <p>채팅방 이름</p>
                    </div>
                  </div>
                  <div class="col-2">
                    <div class="last-message-at sub-text">
                      <p>14:30</p>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="chat-room-last-message sub-text mb-3">
                      <p>마지막 메시지</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="row chat-room mt-3">
              <div class="col-3">
                <div class="profile">
                  <img
                          src="https://e7.pngegg.com/pngimages/1/723/png-clipart-graphy-business-portrait-business-people-public-relations.png"
                  />
                  <div
                          class="status d-flex justify-content-center align-items-center"
                  >
                    <i class="fa-solid fa-check check-icon"></i>
                  </div>
                </div>
              </div>
              <div class="col-8 d-flex align-content-between flex-wrap">
                <div class="row d-flex justify-content-between">
                  <div class="col-8">
                    <div class="chat-room-name">
                      <p>채팅방 이름</p>
                    </div>
                  </div>
                  <div class="col-2">
                    <div class="last-message-at sub-text">
                      <p>14:30</p>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="chat-room-last-message sub-text mb-3">
                      <p>마지막 메시지</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="row chat-room mt-3">
              <div class="col-3">
                <div class="profile">
                  <img
                          src="https://e7.pngegg.com/pngimages/1/723/png-clipart-graphy-business-portrait-business-people-public-relations.png"
                  />
                  <div
                          class="status d-flex justify-content-center align-items-center"
                  >
                    <i class="fa-solid fa-check check-icon"></i>
                  </div>
                </div>
              </div>
              <div class="col-8 d-flex align-content-between flex-wrap">
                <div class="row d-flex justify-content-between">
                  <div class="col-8">
                    <div class="chat-room-name">
                      <p>채팅방 이름</p>
                    </div>
                  </div>
                  <div class="col-2">
                    <div class="last-message-at sub-text">
                      <p>14:30</p>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="chat-room-last-message sub-text mb-3">
                      <p>마지막 메시지</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="row chat-room mt-3">
              <div class="col-3">
                <div class="profile">
                  <img
                          src="https://e7.pngegg.com/pngimages/1/723/png-clipart-graphy-business-portrait-business-people-public-relations.png"
                  />
                  <div
                          class="status d-flex justify-content-center align-items-center"
                  >
                    <i class="fa-solid fa-check check-icon"></i>
                  </div>
                </div>
              </div>
              <div class="col-8 d-flex align-content-between flex-wrap">
                <div class="row d-flex justify-content-between">
                  <div class="col-8">
                    <div class="chat-room-name">
                      <p>채팅방 이름</p>
                    </div>
                  </div>
                  <div class="col-2">
                    <div class="last-message-at sub-text">
                      <p>14:30</p>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="chat-room-last-message sub-text mb-3">
                      <p>마지막 메시지</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="row chat-room mt-3">
              <div class="col-3">
                <div class="profile">
                  <img
                          src="https://e7.pngegg.com/pngimages/1/723/png-clipart-graphy-business-portrait-business-people-public-relations.png"
                  />
                  <div
                          class="status d-flex justify-content-center align-items-center"
                  >
                    <i class="fa-solid fa-check check-icon"></i>
                  </div>
                </div>
              </div>
              <div class="col-8 d-flex align-content-between flex-wrap">
                <div class="row d-flex justify-content-between">
                  <div class="col-8">
                    <div class="chat-room-name">
                      <p>채팅방 이름</p>
                    </div>
                  </div>
                  <div class="col-2">
                    <div class="last-message-at sub-text">
                      <p>14:30</p>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="chat-room-last-message sub-text mb-3">
                      <p>마지막 메시지</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="row chat-room mt-3">
              <div class="col-3">
                <div class="profile">
                  <img
                          src="https://e7.pngegg.com/pngimages/1/723/png-clipart-graphy-business-portrait-business-people-public-relations.png"
                  />
                  <div
                          class="status d-flex justify-content-center align-items-center"
                  >
                    <i class="fa-solid fa-check check-icon"></i>
                  </div>
                </div>
              </div>
              <div class="col-8 d-flex align-content-between flex-wrap">
                <div class="row d-flex justify-content-between">
                  <div class="col-8">
                    <div class="chat-room-name">
                      <p>채팅방 이름</p>
                    </div>
                  </div>
                  <div class="col-2">
                    <div class="last-message-at sub-text">
                      <p>14:30</p>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="chat-room-last-message sub-text mb-3">
                      <p>마지막 메시지</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="contents">
      <div class="container-fluid">
        <div class="row category d-flex align-items-center">
          <div class="col-4"><p class="category-name">채팅 생성</p></div>
        </div>
        <form name="create-chatroom-form" action="http://localhost:8081/" method="post">
          <div class="input-box">
            <div class="add-emp-box">
              <div class="row add-dept-box">
                <i class="fa-solid fa-plus plus-icon"></i>
                <span>조직도로 추가하기</span>
              </div>
              <div class="row input-add-emp-box">
                <div class="col-1">
                  <i class="fa-solid fa-user-plus user-plus-icon"></i>
                </div>
                <div class="col-11">
                  <input
                          name='employees'
                          placeholder='사용자를 추가해주세요.'
                          value=''
                          data-blacklist='.NET,PHP'
                          autofocus
                  >
                </div>
              </div>
            </div>
            <div class="input-add-group-name">
              <div class="row">
                <div class="col-1">
                  <i class="fa-solid fa-pen-to-square"></i>
                </div>
                <div class="col-11">
                  <input type="text" placeholder="채팅방 명을 입력해주세요."/>
                </div>
              </div>
            </div>
            <div class="button-area">
              <div class="row d-flex justify-content-end">
                <div class="col-4">
                  <div class="row d-flex justify-content-between">
                    <div class="col-6">
                        <button type="submit" class="create-button">생성</button>
                    </div>
                    <div class="col-6">
                        <button class="cancel-button">취소</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </body>

  <script>
    let inputElm = document.querySelector('input[name=employees]');

    // 화이트 리스트 : 해당 문자만 태그로 추가 가능
    let whitelist = ["우영두","도성구","이예림","이수호","지승용","유은서"];

    // initialize Tagify
    var tagify = new Tagify(inputElm, {
      enforceWhitelist: true, // 화이트리스트에서 허용된 태그만 사용
      whitelist: whitelist // 화이트 리스트 배열. 화이트 리스트를 등록하면 자동으로 드롭다운 메뉴가 생긴다
    })


    // 만일 모든 태그 지우기 기능 버튼을 구현한다면
    document.querySelector('버튼').addEventListener('click', tagify.removeAllTags.bind(tagify));


    // tagify 전용 이벤트 리스터. 참조 : https://github.com/yairEO/tagify#events
    tagify.on('add', onAddTag) // 태그가 추가되면
            .on('remove', onRemoveTag) // 태그가 제거되면
            .on('input', onInput) // 태그가 입력되고 있을 경우
            .on('invalid', onInvalidTag) // 허용되지 않는 태그일 경우
            .on('click', onTagClick) // 해시 태그 블럭을 클릭할 경우
            .on('focus', onTagifyFocusBlur) // 포커스 될 경우
            .on('blur', onTagifyFocusBlur) // 반대로 포커스를 잃을 경우

            .on('edit:start', onTagEdit) // 입력된 태그 수정을 할 경우

            .on('dropdown:hide dropdown:show', e => console.log(e.type)) // 드롭다운 메뉴가 사라질경우
            .on('dropdown:select', onDropdownSelect) // 드롭다운 메뉴에서 아이템을 선택할 경우


    // tagify 전용 이벤트 리스너 제거 할떄
    tagify.off('add', onAddTag);


    // 이벤트 리스너 콜백 메소드
    function onAddTag(e){
      console.log("onAddTag: ", e.detail);
      console.log("original input value: ", inputElm.value)
    }

    // tag remvoed callback
    function onRemoveTag(e){
      console.log("onRemoveTag:", e.detail, "tagify instance value:", tagify.value)
    }

    function onTagEdit(e){
      console.log("onTagEdit: ", e.detail);
    }

    // invalid tag added callback
    function onInvalidTag(e){
      console.log("onInvalidTag: ", e.detail);
    }

    // invalid tag added callback
    function onTagClick(e){
      console.log(e.detail);
      console.log("onTagClick: ", e.detail);
    }

    function onTagifyFocusBlur(e){
      console.log(e.type, "event fired")
    }

    function onDropdownSelect(e){
      console.log("onDropdownSelect: ", e.detail)
    }

    function onInput(e){
      console.log("onInput: ", e.detail);

      tagify.loading(true) // 태그 입력하는데 우측에 loader 애니메이션 추가
      tagify.loading(false) // loader 애니메이션 제거

      tagify.dropdown.show(e.detail.value); // 드롭다운 메뉴 보여주기
      tagify.dropdown.hide(); // // 드롭다운 제거
    }

  </script>
</html>
