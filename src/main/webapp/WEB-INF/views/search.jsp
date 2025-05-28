<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="org.example.travelapp.model.TravelTO" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.travelapp.model.TravelListTO" %>

<%
    TravelListTO listTO = (TravelListTO) request.getAttribute("lists");
    List<TravelTO> lists = (List<TravelTO>) listTO.getBoardLists();

    String keyword = (String) request.getAttribute("keyword");

    StringBuilder sbHtml = new StringBuilder();

    if (lists != null && !lists.isEmpty()) {
        int count = 0;
        for (TravelTO to : lists) {
            if (count >= 5) break;  // 5개 초과 시 중단

            // 검색 키워드에 알맞는 이미지를 가져오기 위한 url 설정
            String imageUrl = "/images/travel_" + to.getNo() + ".jpg"; // 예: travel_1.jpg

            // 전체를 감싸는 wrapper div
            sbHtml.append("<div class='items'>");

            // 이미지를 출력할 div
            sbHtml.append("<div class='item'>");
            sbHtml.append("<a href='/detail/" + to.getNo() +"'>");
            sbHtml.append("<img src='"+ imageUrl + "'>");
            sbHtml.append("</a>");
            sbHtml.append("</div>");

            // 제목, 내용, 주소 출력 div
            sbHtml.append("<div class='result-list'>");
            sbHtml.append("<div class='result-title'><h3>" + to.getTitle() + "</h3><br/><hr/><br/></div>");
            sbHtml.append("<div class='result-description'>" + to.getDescription() + "<br/><br/></div>");
            sbHtml.append("<div class='result-address'>" + to.getAddress() + "</div>");
            sbHtml.append("</div>");

            sbHtml.append("</div>");

            count++;  // 개수 증가
        }
    } else {
        sbHtml.append("<p>검색 결과가 없습니다.</p>");
    }

    StringBuilder listSbHtml = new StringBuilder();

    if(listTO != null && listTO.getTotalRecord() > 0){
        int totalPage = listTO.getTotalPage();
        int startBlock = listTO.getStartBlock();
        int endBlock = listTO.getEndBlock();
        int cpage = listTO.getCpage();
        int pagePerBlock = listTO.getPagePerBlock();

        listSbHtml.append("<div class='pagination'>");
        if( cpage == 1 ) {
            listSbHtml.append( "<span><a>&lt;</a></span>" );
        } else {
            listSbHtml.append( "<span><a href='/search/all/" + keyword + "?cpage=" + ( cpage - 1 )+ "'>&lt;</a></span>" );
        }

        listSbHtml.append( "&nbsp;&nbsp;" );

        for ( int i=startBlock ; i<=endBlock ; i++ ) {
            if ( i == cpage ) {
                listSbHtml.append( "<span><a>[ " + i + " ]</a></span>" );
            } else {
                listSbHtml.append( "<span><a href='/search/all/" + keyword + "?cpage=" + i + "'> &nbsp;" + i + " &nbsp;</a></span>" );
            }
        }

        listSbHtml.append( "&nbsp;&nbsp;" );

        if( cpage == totalPage ) {
            listSbHtml.append( "<span><a>&gt;</a></span>" );
        } else {
            listSbHtml.append( "<span><a href='/search/all/" + keyword + "?cpage=" + ( cpage + 1 )+ "'>&gt;</a></span>" );
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검색</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body style="padding: 0;">

<jsp:include page="header.jsp" />

<main class="result-main">
    <h2 class="searchResult"><%= request.getAttribute("keyword") %> 검색 결과</h2>
    <%= sbHtml %>
    <%= listSbHtml %>
</main>

<jsp:include page="footer.jsp" />
<script src="/js/search.js"></script>
</body>
</html>