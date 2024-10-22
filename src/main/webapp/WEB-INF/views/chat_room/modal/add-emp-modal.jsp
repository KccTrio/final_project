<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert title here</title>
    <link
            rel="stylesheet"
            href="<%= request.getContextPath() %>/static/chat_room/modal/add-emp-modal.css"
    />
    <%--    js 추가--%>
    <script src="/static/chat_room/modal/add-emp-modal.js" charset="utf-8"></script>
</head>
<body>
<div id="add-emp-modal" class="modal container-fluid">
    <div class="add-emp-modal-content">
        <div class="row modal-title">
            <div class="col-12">
                <p class="modal-title-word">추가</p>
            </div>
        </div>
        <div class="input-add-emp-box">
            <div class="row add-emp-input-box">
                <div class="col-12">
                    <input name="except-ptpt-employees[]"
                           placeholder="사용자를 추가해주세요."
                           class='tagify--outside' placeholder='write some tags'
                           autofocus
                    >
                </div>
            </div>
            <div class="button-area">
                <div class="row d-flex justify-content-end">
                    <div class="col-6">
                        <div class="row d-flex justify-content-between">
                            <div class="col-6">
                                <button type="submit" class="create-button">추가</button>
                            </div>
                            <div class="col-6">
                                <button class="cancel-button">취소</button>
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