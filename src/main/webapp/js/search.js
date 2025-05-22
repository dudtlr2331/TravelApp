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