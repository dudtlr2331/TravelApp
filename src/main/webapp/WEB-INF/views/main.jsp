<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="org.example.travelapp.model.TravelTO" %>
<%@ page import="java.util.List" %>

<%--<%--%>
<%--  List<TravelTO> lists = (List<TravelTO>) request.getAttribute("lists");--%>
<%--  StringBuilder sbHtml = new StringBuilder();--%>

<%--  if (lists != null && !lists.isEmpty()) {--%>
<%--    for (TravelTO to : lists) {--%>
<%--      sbHtml.append("<div class='result-list'>");--%>
<%--      sbHtml.append("<div class='result-item'>" + to.getTitle() + "</div>");--%>
<%--      sbHtml.append("<div class='result-item'>" + to.getDescription() + "</div>");--%>
<%--      sbHtml.append("<div class='result-item'>" + to.getAddress() + "</div>");--%>
<%--      sbHtml.append("</div>");--%>
<%--    }--%>
<%--  } else {--%>
<%--    sbHtml.append("<p>검색 결과가 없습니다.</p>");--%>
<%--  }--%>
<%--%>--%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메인</title>
  <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
  <header>
    <h1>로고</h1>
    <p>조회수 높은 상태 예능 10개</p>
  </header>

  <form id="searchForm">
    <select id="searchType" name="type">
      <option value="title">제목</option>
      <option value="district">지역</option>
    </select>

    <input type="text" id="searchKeyword" name="keyword" placeholder="검색어를 입력하세요">
    <button type="submit">검색</button>
  </form>

  <section id="슬라이드">
    <!-- 썸네일 이미지 자리 -->
    <div class="slider">
      <div class="slide">[슬라이드1]</div>
      <div class="slide">[슬라이드2]</div>
      <div class="slide">[슬라이드3]</div>
    </div>
  </section>

  <section class="카테고리">
    <h2>카테고리: 제목순</h2>
    <div class="items">
      <%
        List<TravelTO> titleList = (List<TravelTO>) request.getAttribute("titleList");
        if (titleList != null) {
          for (TravelTO to : titleList) {
            String imageUrl = "/images/travel_" + to.getNo() + ".jpg"; // 예: travel_1.jpg
      %>
      <div class="item">
        <a href="/detail/<%= to.getNo() %>">
          <img src="<%= imageUrl %>" style="width:150px; height:100px;">
          <p><%= to.getTitle() %></p>
        </a>
      </div>
      <%
          }
        }
      %>
    </div>
  </section>

  <section class="카테고리">
    <h2>카테고리: 지역순</h2>
    <div class="items">
      <%
        List<TravelTO> districtList = (List<TravelTO>) request.getAttribute("districtList");
        if (districtList != null) {
          for (TravelTO to : districtList) {
            String imageUrl = "/images/travel_" + to.getNo() + ".jpg";
      %>
      <div class="item">
        <a href="/detail?no=<%= to.getNo() %>">
          <img src="<%= imageUrl %>" style="width:150px; height:100px;">
          <p><%= to.getDistrict() %> - <%= to.getTitle() %></p>
        </a>
      </div>
      <%
          }
        }
      %>
    </div>
  </section>

  <footer>
    <p>* info</p>
    <img src="footer-img.png" alt="푸터 이미지">
  </footer>

  <%--<script>
    document.getElementById("searchForm").addEventListener("submit", function (e) {
      e.preventDefault(); // 폼 기본 동작(서버로 전송)을 막음

      const type = document.getElementById("searchType").value;
      const keyword = document.getElementById("searchKeyword").value.trim();

      if (keyword.length === 0) {
        alert("검색어를 입력해주세요.");
        return;
      }

      window.location.href = "/search/" + type + "/" + encodeURIComponent(keyword); // RESTful 형식으로 이동
    });
  </script>--%>
  <%-- 위 코드 대신 js파일로 분리 --%>
  <script src="/js/search.js"></script>
</body>
</html>