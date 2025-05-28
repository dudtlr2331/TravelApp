<%@ page import="org.example.travelapp.model.TravelTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상세정보</title>
    <link rel="stylesheet" href="../../css/detail.css">
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5fd93ba636a2eea37ba2fc966106d44f&libraries=services"></script>
    <script type="text/javascript">
        window.onload = function() {
            const nearAdd = [];
            const nearbyInfo = []; // 주변 관광지 이름과 주소 저장 배열
            <%
                List<TravelTO> nearbyList = (List<TravelTO>) request.getAttribute("nearbyList");
                for(TravelTO nearTo : nearbyList){
                String nearAdd = nearTo.getAddress();
                String nearTitle = nearTo.getTitle();
            %>
            nearAdd.push("<%=nearAdd%>");
            nearbyInfo.push({ title: "<%=nearTitle%>", address: "<%=nearAdd%>" });
            <%
                }
            %>

            var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표 (초기값)
                    level: 4 // 지도의 확대 레벨
                };
            var map = new kakao.maps.Map(mapContainer, mapOption);

            var geocoder = new kakao.maps.services.Geocoder();

            var infoWindow = new kakao.maps.InfoWindow({ // 정보창 생성 (하나의 객체만 생성하여 재사용)
                removable: false // 닫기 버튼 활성화
            });

            // 주소로 좌표를 검색합니다
            geocoder.addressSearch( '${place.address}' , function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    map.setCenter(coords);
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    // 마커에 mouseover 이벤트 리스너 추가
                    kakao.maps.event.addListener(marker, 'mouseover', function() {
                        infoWindow.setContent('<div style="padding:5px; width: 250px;"><b>' + '${place.title}' + '</b><br>${place.address}</div>');
                        infoWindow.open(map, this);
                    });

                    // 마커에 mouseout 이벤트 리스너 추가 (선택 사항)
                    kakao.maps.event.addListener(marker, 'mouseout', function() {
                        infoWindow.close();
                    });

                    clusterer.addMarker(marker);
                } else {
                    console.log("주소 검색 오류:", status);
                }
            });

            console.log("length : " + nearAdd.length);
            for(let i = 0; i < nearAdd.length; i++){
                geocoder.addressSearch(nearAdd[i], function(result, status) {
                    if(status === kakao.maps.services.Status.OK){
                        var nearCoords = new kakao.maps.LatLng(result[0].y, result[0].x);
                        var nearMarker = new kakao.maps.Marker({
                            map: map,
                            position: nearCoords
                        });
                        console.log("nearAdd : " +(i+1)+ " 번째 : " + nearAdd[i]);
                        // 마커에 mouseover 이벤트 리스너 추가
                        kakao.maps.event.addListener(nearMarker, 'mouseover', function() {
                            infoWindow.setContent('<div style="padding:5px; width: 250px;"><b>' + nearbyInfo[i].title + '<b><br>' + nearbyInfo[i].address + '</div>');
                            infoWindow.open(map, this);
                        });

                        // 마커에 mouseout 이벤트 리스너 추가 (선택 사항)
                        kakao.maps.event.addListener(nearMarker, 'mouseout', function() {
                            infoWindow.close();
                        });
                        clusterer.addMarker(nearMarker);
                    } else {
                        console.log("주변 주소 검색 오류 : ", status, nearAdd[i]);
                    }
                });
            }

            var clusterer = new kakao.maps.MarkerClusterer({
                map: map,
                markers: [], // 초기에는 빈 배열
                gridSize: 35,
                averageCenter: true,
                minLevel: 6,
                disableClickZoom: true,
                hoverable: true,
                styles: [{
                    width : '53px', height : '52px',
                    background: 'url(cluster.png) no-repeat',
                    color: '#fff',
                    textAlign: 'center',
                    lineHeight: '54px'
                }]
            });
        }

        function scrollNearby(direction) {
            const container = document.getElementById("nearbySlider");
            const cardWidth = container.querySelector(".nearby-card").offsetWidth + 16; // 카드 너비 + gap
            container.scrollLeft += direction * cardWidth * 2; // 2칸씩 이동
        }
    </script>
</head>
<body>

<jsp:include page="header.jsp" />

<main class="detail-main">
    <div class="detail-header">
        <img src="/images/travel_${place.no}.jpg"
             class="left-image"
             alt="${place.title} 이미지"
             onerror="this.onerror=null; this.src='/images/default.jpg';" />

        <div class="text-info">
            <h1>${place.title}</h1>
            <p>${place.address}</p>
            <h3>전화번호</h3>
            <p>${place.phone}</p>
        </div>
    </div>

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
        <div class="nearby-slider-wrapper">
            <button class="arrow left" onclick="scrollNearby(-1)">&#10094;</button>

            <div class="nearby-slider" id="nearbySlider">
                <%
                    List<TravelTO> nearbyLists = (List<TravelTO>) request.getAttribute("nearbyList");
                    if (nearbyLists != null && !nearbyLists.isEmpty()) {
                        for (TravelTO spot : nearbyLists) {
                            int no = spot.getNo();
                            String title = spot.getTitle();
                            String imageUrl = "/images/travel_" + no + ".jpg";
                %>
                <div class="nearby-card">
                    <a href="/detail/<%= no %>">
                        <img src="<%= imageUrl %>" class="nearby-image" onerror="this.onerror=null; this.src='/images/default.jpg';" alt="">

                        <div class="nearby-text">
                            <div class="nearby-title-wrapper">
                                <span class="nearby-title"><%= title %></span>
                            </div>
                            <p class="nearby-address"><%= spot.getAddress() %></p>
                            <p class="nearby-distance"><%= spot.getDescription().split("\\|")[1].trim() %></p>
                        </div>
                    </a>
                </div>
                <%
                    }
                } else {
                %>
                <p>주변 관광지가 없습니다.</p>
                <% } %>
            </div>

            <button class="arrow right" onclick="scrollNearby(1)">&#10095;</button>
        </div>
    </section>
</main>

<jsp:include page="footer.jsp" />

</body>
</html>