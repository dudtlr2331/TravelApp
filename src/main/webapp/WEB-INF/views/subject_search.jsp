<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head><title>검색 결과</title></head>
<body>
<h2>‘${keyword}’ 검색 결과</h2>
    <div>
        <h3>${s.title}</h3>
        <p>${s.description}</p>
        <p>${s.address}</p>
        <hr/>
    </div>
</body>
</html>