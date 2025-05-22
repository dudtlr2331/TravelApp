<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="org.example.travelapp.model.TravelTO" %>
<%@ page import="java.util.List" %>

<%
    List<TravelTO> lists = (List<TravelTO>) request.getAttribute("lists");
    StringBuilder sbHtml = new StringBuilder();

    if (lists != null && !lists.isEmpty()) {
        for (TravelTO to : lists) {
            sbHtml.append("<div class='result-list'>");
            sbHtml.append("<div class='result-item'>" + to.getTitle() + "</div>");
            sbHtml.append("<div class='result-item'>" + to.getDescription() + "</div>");
            sbHtml.append("<div class='result-item'>" + to.getAddress() + "</div>");
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
<header>
    <h1>로고</h1>
    <p>* 정렬기 // #추천순 카테고리 시스템</p>
</header>

<main>
    <h2><%= request.getAttribute("keyword") %> 검색 결과</h2>
    <%= sbHtml %>
</main>

<footer>
    <p>* info</p>
    <img src="footer-img.png" alt="푸터 이미지">
</footer>
</body>
</html>