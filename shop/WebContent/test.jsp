<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- start : submenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/submenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<h1>test page</h1>
</body>
</html>