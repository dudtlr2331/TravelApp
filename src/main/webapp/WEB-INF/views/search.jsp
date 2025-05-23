<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="org.example.travelapp.model.TravelTO" %>
<%@ page import="java.util.List" %>

<%
    List<TravelTO> lists = (List<TravelTO>) request.getAttribute("lists");
    StringBuilder sbHtml = new StringBuilder();

    if (lists != null && !lists.isEmpty()) {
        for (TravelTO to : lists) {
            // 검색 키워드에 알맞는 이미지를 가져오기 위한 url 설정
            String imageUrl = "/images/travel_" + to.getNo() + ".jpg"; // 예: travel_1.jpg

            // 전체를 감싸는 wrapper div
            sbHtml.append("<div class='items'>");

            // 이미지를 출력할 div - 정렬을 용이하게 하기 위해서 내용부분과 분리
            sbHtml.append("<div class='item'>");
            sbHtml.append("<a href='/detail/" + to.getNo() +"'>");
            sbHtml.append("<img src='"+ imageUrl + "'>");
            sbHtml.append("</a>");
            sbHtml.append("</div>");

            // 제목, 내용, 주소가 들어갈 div - 내용 출력량을 제한하기 위해 각 종류별로 div 를 분리
            sbHtml.append("<div class='result-list'>");
            sbHtml.append("<div class='result-title'><h3>" + to.getTitle() + "</h3><br/><hr/><br/></div>");
            sbHtml.append("<div class='result-description'>"+ to.getDescription() + "<br/><br/></div>");
            sbHtml.append("<div class='result-address'>"+ to.getAddress() + "</div>");
            sbHtml.append("</div>");
            sbHtml.append("</div>");
        }
    } else {
        sbHtml.append("<p>검색 결과가 없습니다.</p>");
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검색</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>

<jsp:include page="header.jsp" />

<main>
    <h2><%= request.getAttribute("keyword") %> 검색 결과</h2>

    <%= sbHtml %>
</main>

<jsp:include page="footer.jsp" />

<%-- 검색 결과를 전송하기 위한 js 사용--%>
<script src="/js/search.js"></script>
</body>
</html>