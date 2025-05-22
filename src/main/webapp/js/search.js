document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("searchForm");

    form.addEventListener("submit", function (e) {
        e.preventDefault();

        const type = document.getElementById("searchType").value;
        const keyword = document.getElementById("searchKeyword").value.trim();

        if (keyword === "") {
            alert("검색어를 입력해주세요.");
            return;
        }

        window.location.href = "/search/" + type + "/" + encodeURIComponent(keyword);
    });
});

// 슬라이드 영역 ─────────────────────────────────────────
const slots = [
    document.getElementById("slot0"),
    document.getElementById("slot1"),
    document.getElementById("slot2"),
    document.getElementById("slot3"),
    document.getElementById("slot4"),
];

const contentList = [
    { img: "images/travel_88.jpg", title: "불국사", desc: "경주의 대표 사찰" },
    { img: "images/travel_89.jpg", title: "해운대", desc: "부산의 유명 해변" },
    { img: "images/travel_90.jpg", title: "남산타워", desc: "서울 전망 명소" },
    { img: "images/travel_95.jpg", title: "경복궁", desc: "조선 왕궁" },
    { img: "images/travel_96.jpg", title: "정동진", desc: "바다 옆 기차역" },
    { img: "images/travel_97.jpg", title: "고양 꽃박람회", desc: "봄꽃 전시" }
];

let startIndex = 0;
let autoSlide;
let resumeTimeout;

function updateSlots() {
    for (let i = 0; i < 5; i++) {
        const contentIndex = (startIndex + i) % contentList.length;
        slots[i].innerHTML = `
            <div class="slide-image-wrapper">
                <img src="${contentList[contentIndex].img}" alt="이미지" />
                <div class="image-label">
                    <div class="label-title">${contentList[contentIndex].title}</div>
                    <div class="label-desc">${contentList[contentIndex].desc}</div>
                </div>
            </div>
        `;
    }
}

function startAutoSlide() {
    autoSlide = setInterval(() => {
        startIndex = (startIndex + 1) % contentList.length;
        updateSlots();
    }, 4000);
}

function stopAutoSlideTemporarily() {
    clearInterval(autoSlide);
    clearTimeout(resumeTimeout);
    resumeTimeout = setTimeout(() => {
        startAutoSlide();
    }, 4000); // 5초 뒤 재시작
}

// 초기 실행
updateSlots();
startAutoSlide();

// 수동 조작
document.getElementById("slideNext").addEventListener("click", () => {
    startIndex = (startIndex + 1) % contentList.length;
    updateSlots();
    stopAutoSlideTemporarily();
});

document.getElementById("slidePrev").addEventListener("click", () => {
    startIndex = (startIndex - 1 + contentList.length) % contentList.length;
    updateSlots();
    stopAutoSlideTemporarily();
});