<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- start : submenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/submenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div class="container p-3 my-3 bg-info text-white">
	<h1>메인페이지</h1>
	<%
		// 로그인 전(session 영역안에 null값이면)
		if(session.getAttribute("loginMember") == null){
	%>
		<!-- request.getContextPath() : 실제로 프로젝트명이 변경되도 변경된 값을 가져온다. -->
		<div><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></div>
		<div><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></div>
	<% 
		// 로그인 후(session 영역안에 값이 있으면)
		} else{
			Member loginMember = (Member)session.getAttribute("loginMember");
	%>
			<div><%=loginMember.getMemberName()%>님 반갑습니다.<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/logOut.jsp"> 로그아웃</a></div>
			<div><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/selectMemberOne.jsp">회원정보</a></div>
	<% 		
		}
	%>
	</div>
</body>
</html>