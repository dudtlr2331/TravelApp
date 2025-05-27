<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="org.example.travelapp.model.TravelTO" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.travelapp.model.TravelListTO" %>

<%
    TravelListTO listTO = (TravelListTO) request.getAttribute("lists");
    List<TravelTO> lists = (List<TravelTO>) listTO.getBoardLists();


    StringBuilder sbHtml = new StringBuilder();

    if (lists != null && !lists.isEmpty()) {
        for (TravelTO to : lists) {
            // 검색 키워드에 알맞는 이미지를 가져오기 위한 url 설정
            String imageUrl = "/images/travel_" + to.getNo() + ".jpg"; // 예: travel_1.jpg

            // 전체를 감싸는 wrapper div
            sbHtml.append("<div class='items'>");

            // 이미지를 출력할 div - 정렬을 용이하게 하기 위해서 내용부분과 분리
            sbHtml.append("<div class='item'>");
            sbHtml.append("<a href='/detail/" + to.getNo() + "'>");
            sbHtml.append("<img src='" + imageUrl + "'>");
            sbHtml.append("</a>");
            sbHtml.append("</div>");

            // 제목, 내용, 주소가 들어갈 div - 내용 출력량을 제한하기 위해 각 종류별로 div 를 분리
            sbHtml.append("<div class='result-list'>");
            sbHtml.append("<div class='result-title'><h3>" + to.getTitle() + "</h3><br/><hr/><br/></div>");
            sbHtml.append("<div class='result-description'>" + to.getDescription() + "<br/><br/></div>");
            sbHtml.append("<div class='result-address'>" + to.getAddress() + "</div>");
            sbHtml.append("</div>");
            sbHtml.append("</div>");
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

        System.out.println("cpage : " + cpage);
        System.out.println("totalPage : " + totalPage);
        System.out.println("startBlock : " + startBlock);
        System.out.println("endBlock : " + endBlock);
        System.out.println("pageperblock : " + pagePerBlock);

        listSbHtml.append("<div class='pagination'>");

        if ( startBlock == 1 ) {
            listSbHtml.append( "<span><a>&lt;&lt;</a></span>" );
        } else {
            listSbHtml.append( "<span><a href='/all?cpage=" + ( startBlock - pagePerBlock ) + "'>&lt;&lt;</a></span>" );
        }

        listSbHtml.append( "&nbsp;" );

        if( cpage == 1 ) {
            listSbHtml.append( "<span><a>&lt;</a></span>" );
        } else {
            listSbHtml.append( "<span><a href='/all?cpage=" + ( cpage - 1 )+ "'>&lt;</a></span>" );
        }

        listSbHtml.append( "&nbsp;&nbsp;" );

        for ( int i=startBlock ; i<=endBlock ; i++ ) {
            if ( i == cpage ) {
                listSbHtml.append( "<span><a>[ " + i + " ]</a></span>" );
            } else {
                listSbHtml.append( "<span><a href='/all?cpage=" + i + "'> " + i + " </a></span>" );
            }
        }

        listSbHtml.append( "&nbsp;&nbsp;" );

        if( cpage == totalPage ) {
            listSbHtml.append( "<span><a>&gt;</a></span>" );
        } else {
            listSbHtml.append( "<span><a href='/all?cpage=" + ( cpage + 1 )+ "'>&gt;</a></span>" );
        }

        listSbHtml.append( "&nbsp;" );

        if( endBlock == totalPage ) {
            listSbHtml.append( "<span><a>&gt;&gt;</a></span>" );
        } else {
            listSbHtml.append( "<span><a href='/all?cpage=" + ( startBlock + pagePerBlock ) + "'>&gt;&gt;</a></span>" );
        }
        listSbHtml.append("</div>");
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

<main class="result-main">
    <%=sbHtml %>
    <%=listSbHtml %>
</main>

<jsp:include page="footer.jsp" />

<%-- 검색 결과를 전송하기 위한 js 사용--%>
<script src="/js/search.js"></script>
</body>
</html>