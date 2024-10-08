$(document).ready(function() {
    // 화이트리스트 초기화
    let whitelist = [];

    // AJAX를 통해 직원 목록 가져오기
    $.ajax({
        url: 'http://localhost:8081/api/employees/all',
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            whitelist = data.map(function(employee) {
                return {
                    name: employee.name + '/' + employee.position + '/' + employee.deptName, // 태그에 표시될 내용
                    value: employee.id.toString(), // 직원 ID를 문자열로 변환하여 저장
                };
            });

            console.log('직원 데이터를 성공적으로 가져왔습니다:', whitelist);

            // Tagify 초기화
            let inputElm = document.querySelector("input[name='employees[]']");

            // initialize Tagify
            var tagify = new Tagify(inputElm, {
                enforceWhitelist: true, // 화이트리스트에서 허용된 태그만 사용
                whitelist: whitelist, // 화이트 리스트 배열. 화이트 리스트를 등록하면 자동으로 드롭다운 메뉴가 생긴다
                autogrow: true, // 태그 입력창이 자동으로 늘어난다
                originalInputValueFormat: function(valuesArr) {
                    return valuesArr.map(function(item) {
                        return item.value;
                    });
                },
                templates: {
                    tag: function(tagData) {
                        return `
                            <tag title="${tagData.name}"
                                contenteditable='false'
                                spellcheck='false'
                                class='tagify__tag ${tagData.class ? tagData.class : ''}'
                                ${this.getAttributes(tagData)}>
                                <x title='remove tag' class='tagify__tag__removeBtn'></x>
                                <div>
                                    <span class='tagify__tag-text'>${tagData.name}</span>
                                </div>
                            </tag>`;
                    },
                    dropdownItem: function(tagData) {
                        return `
                            <div ${this.getAttributes(tagData)}
                                class='tagify__dropdown__item ${tagData.class ? tagData.class : ''}'>
                                <span>${tagData.name}</span>
                            </div>`;
                    }
                },
                dropdown: {
                    // 검색에 사용할 속성 지정
                    searchKeys: ['name'],
                    maxItems: 10, // 최대 표시 아이템 수 (필요에 따라 조정)
                    enabled: 0    // 0으로 설정하면 입력한 글자 수와 상관없이 항상 드롭다운을 표시
                }
            });

            // 이벤트 리스너 등록 및 기타 Tagify 관련 설정
            // 만일 모든 태그 지우기 기능 버튼을 구현한다면
            document
                .querySelector("버튼")
                .addEventListener("click", tagify.removeAllTags.bind(tagify));

            // tagify 전용 이벤트 리스터
            tagify
                .on("add", onAddTag) // 태그가 추가되면
                .on("remove", onRemoveTag) // 태그가 제거되면
                .on("input", onInput) // 태그가 입력되고 있을 경우
                .on("invalid", onInvalidTag) // 허용되지 않는 태그일 경우
                .on("click", onTagClick) // 해시 태그 블럭을 클릭할 경우
                .on("focus", onTagifyFocusBlur) // 포커스 될 경우
                .on("blur", onTagifyFocusBlur) // 반대로 포커스를 잃을 경우
                .on("edit:start", onTagEdit) // 입력된 태그 수정을 할 경우
                .on("dropdown:hide dropdown:show", (e) => console.log(e.type)) // 드롭다운 메뉴가 사라질경우
                .on("dropdown:select", onDropdownSelect); // 드롭다운 메뉴에서 아이템을 선택할 경우

            // 이벤트 리스너 콜백 메소드 정의
            function onAddTag(e) {
                console.log("onAddTag: ", e.detail);
                console.log("original input value: ", inputElm.value);
            }

            function onRemoveTag(e) {
                console.log(
                    "onRemoveTag:",
                    e.detail,
                    "tagify instance value:",
                    tagify.value
                );
            }

            function onTagEdit(e) {
                console.log("onTagEdit: ", e.detail);
            }

            function onInvalidTag(e) {
                console.log("onInvalidTag: ", e.detail);
            }

            function onTagClick(e) {
                console.log(e.detail);
                console.log("onTagClick: ", e.detail);
            }

            function onTagifyFocusBlur(e) {
                console.log(e.type, "event fired");
            }

            function onDropdownSelect(e) {
                console.log("onDropdownSelect: ", e.detail);
            }

            function onInput(e) {
                console.log("onInput: ", e.detail);

                tagify.loading(true); // 태그 입력하는데 우측에 loader 애니메이션 추가
                tagify.loading(false); // loader 애니메이션 제거

                tagify.dropdown.show(e.detail.value); // 드롭다운 메뉴 보여주기
                tagify.dropdown.hide(); // 드롭다운 제거
            }
        },
        error: function(xhr, status, error) {
            console.error('직원 데이터를 가져오는 데 실패했습니다:', error);
        }
    });

    // AJAX 호출과 무관한 다른 코드가 있다면 여기에 추가
});