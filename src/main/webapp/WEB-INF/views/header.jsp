<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="../../css/header.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<header class="main-header">
    <div class="nav-inner">
        <div class="logo">
            <a href="/main">
                <img src="/images/logo.png" alt="Tripingo 로고">
            </a>
        </div>

        <nav class="nav-menu">
            <a href="/main">홈</a>
            <a href="#">전체보기</a>
        </nav>

        <form class="nav-search" id="navSearchForm" onsubmit="return navSearch()">
            <input type="text" id="navSearchKeyword" placeholder="어디로, 어떤 여행을 떠날 예정인가요?" />
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>
    </div>
</header>

<script>
    function navSearch() {
        const keyword = document.getElementById('navSearchKeyword').value.trim();
        if (!keyword) {
            alert("검색어를 입력하세요.");
            return false;
        }
        window.location.href = "/search/all/" + encodeURIComponent(keyword);
        return false;
    }
</script>