document.addEventListener("DOMContentLoaded", function () {
    loadSlidesFromServer();
});

// 슬라이드 영역 ─────────────────────────────────────────
const slots = [
    document.getElementById("slot0"),
    document.getElementById("slot1"),
    document.getElementById("slot2"),
    document.getElementById("slot3"),
    document.getElementById("slot4"),
];

let contentList = [];
let startIndex = 0;
let autoSlide;
let resumeTimeout;

function loadSlidesFromServer() {
    fetch("/api/slider")
        .then(res => res.json())
        .then(data => {
            contentList = data;
            updateSlots();
            startAutoSlide();
        })
        .catch(err => {
            console.error("슬라이드 데이터를 불러오는 중 오류:", err);
        });
}

function updateSlots() {
    for (let i = 0; i < 5; i++) {
        const contentIndex = (startIndex + i) % contentList.length;
        slots[i].innerHTML = `
            <div class="slide-wrapper">
                <a href="/detail/${contentList[contentIndex].no}" class="slide-link">                
                    <div class="slide-image-wrapper">
                        <img src="${contentList[contentIndex].img}" alt="이미지" />
                        <div class="image-label">
                            <div class="label-title">${contentList[contentIndex].title}</div>
                        </div>
                    </div>
                </a>
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
    }, 4000); // 4초 뒤 재시작
}

// 수동 조작 버튼 이벤트
document.getElementById("slideNext").addEventListener("click", () => {
    if (contentList.length === 0) return;
    startIndex = (startIndex + 1) % contentList.length;
    updateSlots();
    stopAutoSlideTemporarily();
});

document.getElementById("slidePrev").addEventListener("click", () => {
    if (contentList.length === 0) return;
    startIndex = (startIndex - 1 + contentList.length) % contentList.length;
    updateSlots();
    stopAutoSlideTemporarily();
});