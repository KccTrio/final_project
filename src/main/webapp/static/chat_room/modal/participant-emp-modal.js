document.addEventListener('DOMContentLoaded', function() {
    var modal = document.getElementById("emp-modal");
    var empCountBox = document.querySelector(".emp-count-box");
    var span = document.getElementsByClassName("close")[0];

    // emp-count-box 클릭 시 모달 열기
    empCountBox.addEventListener('click', function() {
        console.log("emp-count-box 클릭");
        // emp-count-box의 위치 가져오기
        var rect = empCountBox.getBoundingClientRect();
        var modalWidth = modal.offsetWidth;

        // 모달 위치 설정 (empCountBox의 아래 왼쪽 끝에 모달의 오른쪽 끝을 맞춤)
        var leftPosition = window.scrollX + rect.left - modalWidth - 200;
        var topPosition = window.scrollY + rect.bottom + 30;

        // 모달의 오른쪽 끝이 empCountBox의 아래 왼쪽 끝에 맞추기
        modal.style.top = topPosition+ "px";
        modal.style.left = leftPosition + "px"; // 오른쪽 끝을 맞추기 위해 수정
        modal.style.display = "block";
    });

    // 모달 외부 클릭 시 모달 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };
});
