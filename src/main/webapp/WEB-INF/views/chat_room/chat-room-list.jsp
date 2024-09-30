<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ include file="/WEB-INF/views/component/lib.jsp" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/static/chat_room/chat-room.css"
    />
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/static/chat_room/chat-room-list.css"
    />
<%--    js 추가--%>
    <script type="text/javascript"><%@include file="/static/chat_room/chat-room-list.js"%></script>
    <link
      href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css"
      rel="stylesheet"
    />
    <!-- 소스 다운 -->
    <script src="https://unpkg.com/@yaireo/tagify"></script>
    <!-- 폴리필 (구버젼 브라우저 지원) -->
    <script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
    <link
      href="https://unpkg.com/@yaireo/tagify/dist/tagify.css"
      rel="stylesheet"
      type="text/css"
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
            <div class="col-3">
              <a href="http://localhost:8081/chatrooms/save">
                <i class="fa-regular fa-pen-to-square"></i>
              </a>
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
        <div
          class="row category d-flex align-items-center d-flex justify-content-between chat-room-selection"
        >
          <div class="col-1">
            <div class="chat-room-profile">
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
          <div class="col-2">
            <div class="chat-room-name">
              <span>우영두</span>
            </div>
          </div>
          <div
            class="col-2 d-flex justify-content-center d-flex justify-content-between selection"
          >
            <div class="active">
              <a href="#">채팅</a>
            </div>
            <div>
              <a href="#">파일</a>
            </div>
            <div>
              <a href="#">사진</a>
            </div>
          </div>
          <div class="col-5"></div>
          <div
            class="col-2 d-flex justify-content-center d-flex align-items-center"
          >
            <a href="#">
              <i class="fa-solid fa-user-group"></i>
              <span class="emp-count ml-2">3</span>
            </a>
          </div>
        </div>
        <div class="chat">
            <%--전 사람과 같은 채팅일 시--%>
            <div class="row chat-one">
                <div class="col-10">
                    <div class="row">
                        <div class="col-1"></div>
                        <div class="col-9">
                            <div class="chat-bubble-container d-flex align-items-end">
                                <div
                                        class="chat-content d-flex align-items-center justify-content-center"
                                >
                                    <p>안녕하세요. 신입 사원입니다람쥐.</p>
                                </div>
                                <div class="chat-time">
                                    24/09/12 오전 9:30
                                </div>
                              <div class="unread-count-box">
                                <span class="unread-count">1</span>
                              </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-10">
                    <div class="row d-flex justify-content-end">
                        <div class="col-11 emp-name d-flex justify-content-start">
                            <span>우 영두</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-1">
                            <div class="chat-profile">
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
                        <div class="col-9">
                            <div class="emoticon-chat-bubble-container d-flex align-items-end">
                                <div
                                        class="chat-content d-flex align-items-center justify-content-center"
                                >
                                    <p>안녕하세요. 신입 사원입니다.</p>
                                </div>
                                <div class="chat-time">
                                    24/09/12 오전 9:30
                                </div>
                            </div>
                        </div>
                    </div>
                  <div class="row d-flex align-items-start emoticon-boxes">
                    <div class="blank">
                    </div>
                    <div class="emoticon-box">
                      <button class="emoticon-button">
                        <i class="fa-solid fa-check"></i>
                        <span>5</span>
                      </button>
                      <button class="emoticon-button active-button">
                        <i class="fa-solid fa-heart heart-icon"></i>
                        <span>5</span>
                      </button>
                      <button class="emoticon-button">
                        <i class="fa-solid fa-thumbs-up"></i>
                        <span>5</span>
                      </button>
                      <button class="emoticon-button">
                        <i class="fa-solid fa-face-smile"></i>
                        <span>5</span>
                      </button>
                      <button class="emoticon-button">
                        <i class="fa-solid fa-face-sad-cry"></i>
                        <span>5</span>
                      </button>
                    </div>
                  </div>
                </div>
            </div>

            <%--내 채팅일 시--%>
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
                                    <p>안녕하세요. 신입 사원입니다.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                                    <p>안녕하세요. 신입 사원입니다.ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
          <div class="chat-send-box">
              <div class="container-fluid">
                  <div class="chat-send-input d-flex justify-content-center">
                      <form action="">
                          <input type="text" class="chat-input" placeholder="메시지를 입력하세요." />
                      </form>
                      <i class="fa-regular fa-file"></i>
                      <i class="fa-regular fa-paper-plane"></i>
                  </div>
              </div>
          </div>

      </div>
    </div>
    <div id="emoticon-box" style="display: none; position: absolute; padding: 5px; border: 1px solid #ccc; background: white;">
      <!-- Example emoticons, replace these with your actual emoticons -->
      <i class="fa-solid fa-check"></i>
      <i class="fa-solid fa-heart heart-icon"></i>
      <i class="fa-solid fa-thumbs-up"></i>
      <i class="fa-solid fa-face-smile"></i>
      <i class="fa-solid fa-face-sad-cry"></i>
    </div>
  </body>

</html>
