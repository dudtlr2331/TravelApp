<%@ page import="org.example.travelapp.model.TravelTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상세정보</title>
    <link rel="stylesheet" href="../../css/search.css">
    <style type="text/css">
        .map_wrap, .map_wrap * {
            margin:0;
            padding:0;
            font-family:'Malgun Gothic',dotum,sans-serif;
            font-size:12px;
        }
        .map_wrap a, .map_wrap a:hover, .map_wrap a:active{
            color:#000;
            text-decoration: none;
        }
        .map_wrap {
            position:relative;
            width:100%;
            height:350px; /* 지도의 높이 설정 */
        }
    </style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5fd93ba636a2eea37ba2fc966106d44f&libraries=services"></script>
    <script type="text/javascript">
        window.onload = function() {
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표 (초기값)
                    level: 3 // 지도의 확대 레벨
                };

            // 지도를 생성합니다
            var map = new kakao.maps.Map(mapContainer, mapOption);

            // 주소-좌표 변환 객체를 생성합니다
            var geocoder = new kakao.maps.services.Geocoder();

            // 주소로 좌표를 검색합니다
            geocoder.addressSearch( '${place.address}' , function(result, status) {

                // 정상적으로 검색이 완료됐으면
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                    map.setCenter(coords);

                    // 마커를 생성합니다
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    // 클러스터러에 마커를 추가합니다.
                    clusterer.addMarker(marker);

                } else {
                    console.log("주소 검색 오류:", status);
                }
            });

            var clusterer = new kakao.maps.MarkerClusterer({
                map: map,
                markers: [], // 초기에는 빈 배열
                gridSize: 35,
                averageCenter: true,
                minLevel: 6,
                disableClickZoom: true,
                styles: [{
                    width : '53px', height : '52px',
                    background: 'url(cluster.png) no-repeat',
                    color: '#fff',
                    textAlign: 'center',
                    lineHeight: '54px'
                }]
            });
        }
    </script>
</head>
<body>

<header class="site-header">
    <a href="/main" class="logo-link">
        <img src="../../images/logo.png" alt="Tripingo 로고" class="logo-img">
    </a>
</header>

<section class="search-section">
    <h3>관광지 검색</h3>
    <form id="searchForm">
        <input type="text" name="keyword" value="${keyword}" placeholder="검색어 입력">
        <select name="type" id="searchType">
            <option value="title" ${type == 'title' ? 'selected' : ''}>제목</option>
            <option value="district" ${type == 'district' ? 'selected' : ''}>지역</option>
        </select>
        <button type="submit">검색</button>
    </form>
</section>

<section class="detail-image">
    <img src="/images/travel_${place.no}.jpg"
         onerror="this.onerror=null;this.src='/images/thumbnail.jpg';"
         alt="${place.title} 이미지"
         class="left-image">
</section>

<main class="detail-main">
    <h2>${place.title}</h2>
    <p>${place.address}</p>

    <section>
        <h3>전화번호</h3>
        <p>${place.phone}</p>
    </section>

    <section>
        <h3>상세정보</h3>
        <p>${place.description}</p>
    </section>

    <section>
        <h3>맵</h3>
        <div id="map" style="width:100%;height:350px;"class="map_wrap"  style="align-items: center; justify-content: center; display: flex;"></div>
    </section>

    <section class="nearby-section">
        <h3>주변 관광지</h3>
        <div class="nearby-grid">
            <%
                List<TravelTO> nearbyList = (List<TravelTO>) request.getAttribute("nearbyList");
                if (nearbyList != null && !nearbyList.isEmpty()) {
                    for (TravelTO spot : nearbyList) {
                        int no = spot.getNo();
                        String title = spot.getTitle();
                        String imageUrl = "/images/travel_" + no + ".jpg";
            %>
            <div class="nearby-card">
                <a href="/detail/<%= no %>">
                    <img src="<%= imageUrl %>"
                         onerror="this.onerror=null; this.src='/images/thumbnail.png';"
                         alt="">
                    <p><%= title %></p>
                </a>
            </div>
            <%
                }
            } else {
            %>
            <p>주변 관광지가 없습니다.</p>
            <%
                }
            %>
        </div>
    </section>
</main>

<footer class="site-footer">
    <p>* info</p>
    <img src="/images/footer-img.png" alt="푸터 이미지">
</footer>

<script>
    document.getElementById('searchForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const keyword = this.keyword.value.trim();
        const type = this.type.value;

        if (!keyword) {
            alert("검색어를 입력하세요.");
            return;
        }

        window.location.href = "/search/" + type + "/" + encodeURIComponent(keyword);
    });
</script>

</body>
</html>