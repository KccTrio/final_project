<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/static/chat_room/chat_room.css"
    />
    <link
      href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css"
      rel="stylesheet"
    />
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
            <div class="col-3"><i class="fa-regular fa-pen-to-square"></i></div>
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
          </div>
        </div>
      </div>
    </div>
    <div class="contents">
      <div class="container-fluid">
        <div class="row">
          <div class="col-6">gg</div>
        </div>
      </div>
    </div>
  </body>
</html>
