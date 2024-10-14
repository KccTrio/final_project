<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
s
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert title here</title>
    <link
            rel="stylesheet"
            href="<%= request.getContextPath() %>/static/chat_room/modal/send-file-modal.css"
    />
    <%--    js 추가--%>
    <script src="/static/chat_room/modal/send-file-modal.js" charset="utf-8"></script>
</head>
<body>
<div id="send-file-modal" class="modal container-fluid">
    <div class="send-file-modal-content">
        <div class="row modal-title">
            <div class="col-12">
                <p class="modal-title-word ml-0">파일 전송</p>
            </div>
        </div>
        <div class="input-add-emp-box">
            <div class="row d-flex justify-content-center align-items-center">
                <div class="col-1 d-flex justify-content-center align-items-center">
                    <i class="fa-solid fa-tag"></i>
                </div>
                <div class="col-11">
                    <input
                            name="tag"
                            placeholder="태그를 추가해주세요."
                            value=""
                            data-blacklist=".NET,PHP"
                            autofocus
                    />
                </div>
            </div>
            <div class="row dropzone-box">
                <div class="col-12">
                    <div
                            class="dropzone"
                            id="my-dropzone">
                    </div>
                </div>
            </div>

            <div class="button-area">
                <div class="row d-flex justify-content-end">
                    <div class="col-6">
                        <div class="row d-flex justify-content-between">
                            <div class="col-6">
                                <button type="submit" class="send-file-create-button">추가</button>
                            </div>
                            <div class="col-6">
                                <button class="send-cancel-button">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>