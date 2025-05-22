<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상세정보</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
<header>
    <h1>로고</h1>
</header>

<main>
    <h2>${place.title}</h2>  <!-- 관광지명 -->
    <p>${place.address}</p>  <!-- 주소 -->

    <section>
        <h3>상세정보</h3>
        <p>${place.description}</p>  <!-- 설명 -->
    </section>

    <section>
        <h3>맵</h3>
        <div>지도 위치</div>
    </section>

    <section>
        <h3>주변 관광지</h3>
        <div class="nearby">
            <div>관광지1</div>
            <div>관광지2</div>
            <div>관광지3</div>
        </div>
    </section>
</main>

<footer>
    <p>* info</p>
    <img src="footer-img.png" alt="푸터 이미지">
</footer>
</body>
</html>