<%--
Created by IntelliJ IDEA.
User: User
Date: 2025-05-15
Time: 오후 2:33
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#btn').on('click', function(e) {
                $.ajax({
                    url: '',
                    type: 'GET',
                    dataType: 'text',
                    success: function(csvData){
                        console.log('요청성공 : ' + csvData);
                    },
                    error: function(){
                        console.log('요청 실패 : ' + err.responseText);
                    }
                })

            })


        })
    </script>
</head>
<body>

<button id="btn">동기식 요청하기</button>

</body>
</html>
