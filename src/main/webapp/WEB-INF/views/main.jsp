<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="org.example.travelapp.model.TravelTO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메인</title>
  <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
  <jsp:include page="header.jsp" />

  <section id="슬라이드">
    <!-- 썸네일 이미지 자리 -->
    <div class="slider">
      <div class="slider-text">
        트립핑~고? 그냥 떠나는 게 아니야,</br>
        <strong>Tripingo에서 먼저 찾고 가는 거지!</strong>
      </div>
      <button id="slidePrev" class="slide-btn">←</button>
      <div class="slide-slot" id="slot0"></div>
      <div class="slide-slot" id="slot1"></div>
      <div class="slide-slot" id="slot2"></div>
      <div class="slide-slot" id="slot3"></div>
      <div class="slide-slot" id="slot4"></div>
      <button id="slideNext" class="slide-btn">→</button>
    </div>
  </section>

  <section class="카테고리">
    <h2>제목순</h2>
    <div class="items">
      <%
        List<TravelTO> titleList = (List<TravelTO>) request.getAttribute("titleList");
        if (titleList != null) {
          for (TravelTO to : titleList) {
            String imageUrl = "/images/travel_" + to.getNo() + ".jpg"; // 예: travel_1.jpg
      %>
      <div class="item">
        <a href="/detail/<%= to.getNo() %>">

          <img src="<%= imageUrl %>" onerror="this.src='/images/default.jpg'">
          <%
            String fullTitle = to.getTitle();
            String[] splitTitle = fullTitle.split( " ", 2 );
            String region = splitTitle[0];
            String title = splitTitle[1];
          %>
          <p class="region"><%= region %></p>
          <p class="title"><%= title %></p>
        </a>
      </div>
      <%
          }
        }
      %>
    </div>
  </section>

  <section class="카테고리">
    <%
      List<TravelTO> districtList = (List<TravelTO>) request.getAttribute("districtList");
      String district = "";
      if (districtList != null) {
        district = districtList.get(0).getDistrict();
      }
    %>
    <h2>지역순 : <%= district %></h2>
    <div class="items">
      <%
        districtList = (List<TravelTO>) request.getAttribute("districtList");
        if (districtList != null) {
          for (TravelTO to : districtList) {
            String imageUrl = "/images/travel_" + to.getNo() + ".jpg";
      %>
      <div class="item">
        <a href="/detail/<%= to.getNo() %>">
          <img src="<%= imageUrl %>" onerror="this.src='/images/default.jpg'">
          <%
            String fullTitle = to.getTitle();
            String[] splitTitle = fullTitle.split( " ", 2 );
            String region = splitTitle[0];
            String title = splitTitle[1];
          %>
          <p class="region"><%= region %></p>
          <p class="title"><%= title %></p>
        </a>
      </div>
      <%
          }
        }
      %>
    </div>
  </section>

  <jsp:include page="footer.jsp" />

  <script src="/js/search.js"></script>
</body>
</html>