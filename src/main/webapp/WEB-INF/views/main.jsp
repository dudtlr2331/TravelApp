<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="org.example.travelapp.model.TravelTO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메인</title>
  <link rel="stylesheet" href="../../css/style.css">

  <script type="text/javascript">

  </script>

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


<!-- -->
<section class="카테고리">
  <h2>
    지역 :
    <select id="district">
      <option selected value="강원권">강원권</option>
      <option value="경상권">경상권</option>
      <option value="수도권">수도권</option>
      <option value="전라권">전라권</option>
      <option value="제주권">제주권</option>
      <option value="충청권">충청권</option>
    </select>

  </h2>

  <div class="items" id="result">
    <%
      List<TravelTO> districtList = (List<TravelTO>) request.getAttribute("districtList");
      if (districtList != null) {
        for (TravelTO to : districtList) {
          String imageUrl = "/images/travel_" + to.getNo() + ".jpg";
          String fullTitle = to.getTitle();
          String[] splitTitle = fullTitle.split( " ", 2 );
          String region = splitTitle[0];
          String title = splitTitle[1];
    %>
    <div class="item">
      <a href="/detail/<%= to.getNo() %>">
        <img src="<%= imageUrl %>" onerror="this.src='/images/default.jpg'">
        <p class="region"><%= region %></p>
        <p class="title"><%= title %></p>
      </a>
    </div>
    <%
        }
      }
    %>
  </div>

  <div class="카테고리-btn">
    <a id="moreLink" href="#">더보기</a>
  </div>

</section>

<jsp:include page="footer.jsp" />

<script src="/js/search.js"></script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script>
  document.addEventListener( "DOMContentLoaded", function () {
    const select = document.getElementById("district");
    const link = document.getElementById("moreLink");

    link.href = "/search/district/" + encodeURIComponent(select.value);

    select.addEventListener("change", function () {
      const selected = this.value;

      link.href = "/search/district/" + encodeURIComponent(selected);

      $.ajax({
        url: "api/district/" + encodeURIComponent(selected),
        method: "GET",
        dataType: "json",
        success: function (data) {
          const $list = $("#result");
          $list.empty();

          if (data.length == 0) {
            $list.append("<p>해당 지역에 관광지가 없습니다.</p>");
          } else {
            data.forEach(function (item) {
              const split = item.title.split(" ", 2);
              const region = split.length > 1 ? split[0] : "";
              const title = split.length > 1 ? split[1] : item.title;
              const imageUrl = "/images/travel_" + item.no + ".jpg";

              $("#result").append(
                      "<div class='item'>" +
                      "<a href='/detail/" + item.no + "'>" +
                      "<img src='" + imageUrl + "' onerror=\"this.src='/images/default.jpg'\">" +
                      "<p class='region'>" + region + "</p>" +
                      "<p class='title'>" + title + "</p>" +
                      "</a>" +
                      "</div>"
              );

            });
          }

        },
        error: function () {
          alert("[에러]");
        }
      });
    });

  });
</script>
</body>
</html>