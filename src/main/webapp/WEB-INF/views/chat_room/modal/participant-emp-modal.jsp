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
            href="<%= request.getContextPath() %>/static/chat_room/modal/participant-emp-modal.css"
    />
    <%--    js 추가--%>
    <script src="/static/chat_room/modal/participant-emp-modal.js" charset="utf-8"></script>
</head>
<body>
<div id="emp-modal" class="modal container-fluid">
    <div class="modal-content">
        <div class="row count-box">
            <div class="col-12">
                <p class="count">사람 (5)</p>
            </div>
        </div>
        <div class="emp-list">
            <div class="row emp-one d-flex align-items-center">
                <div class="col-5">
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
                <div class="col-7 pl-0">
                    <p class="emp-name">우 영두</p>
                </div>
            </div>
            <div class="row emp-one d-flex align-items-center">
                <div class="col-5">
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
                <div class="col-7 pl-0">
                    <p class="emp-name">우 영두</p>
                </div>
            </div>
            <div class="row emp-one d-flex align-items-center">
                <div class="col-5">
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
                <div class="col-7 pl-0">
                    <p class="emp-name">우 영두</p>
                </div>
            </div>
            <div class="row emp-one d-flex align-items-center">
                <div class="col-5">
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
                <div class="col-7 pl-0">
                    <p class="emp-name">우 영두</p>
                </div>
            </div>
            <div class="row emp-one d-flex align-items-center">
                <div class="col-5">
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
                <div class="col-7 pl-0">
                    <p class="emp-name">우 영두</p>
                </div>
            </div>

        </div>

        <div class="add-emp-box">
            <i class="fa-solid fa-user-plus"></i>
            <p>사람 추가</p>
        </div>
    </div>
</div>
</body>
</html>