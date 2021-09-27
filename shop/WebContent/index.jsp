<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<div class="jumbotron">
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
			<div><%=loginMember.getMemberName()%>님 반갑습니다.
			<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/logOut.jsp"> 로그아웃</a>
			<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>">회원정보</a>
			<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp">나의주문관리</a>
			</div>
	<% 
			if(loginMember.getMemberLevel() > 0)	 
	%>
			<!-- 관리자 페이지로 가는 링크 -->
			<div><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a></div>			
	<% 		
		}
	%>
	</div>
	<!-- 상품 목록 출력 -->
	<%
		// 페이징
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		// 디버깅 코드
		System.out.println("[debug] currentPage 확인 -> " + currentPage);
		
		// 목록 데이터 보여질 행의 수(final -> 바뀔 수 없음)
		final int Row_PER_PAGE = 10;
		
		// 목록 데이터 시작 행
		int beginRow = (currentPage - 1) * Row_PER_PAGE;
		
		// (1) EbookDao 클래스 객체 생성
		EbookDao ebookDao = new EbookDao();
	
		// (2) Ebook 클래스 배열 객체 생성(전체 상품 목록 출력)
		ArrayList<Ebook> ebookList = ebookDao.selectEbookList(beginRow, Row_PER_PAGE);
		
		// (3) Ebook 클래스 배열 객체 생성(인기 상품 목록 5개 출력)
		ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
		
		// (4) Ebook 클래스 배열 객체 생성(신상품 목록 5개 출력)
		ArrayList<Ebook> newEbookList = ebookDao.selectNewEbookList();
	%>
	<br>
	<!-- 신상품 목록 -->
	<h2>신상품 목록</h2>
	<table border="1">
		<%
			for(Ebook e : newEbookList) {
		%>
				<td>
					<div><a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a></div>
					<div><a href="#"><%=e.getEbookTitle()%></a></div>
					<div>₩ <%=e.getEbookPrice()%></div>
				</td>
		<% 		
			}
		%>
	</table>
	<br>
	<!-- 인기상품 목록 보여주기-->
	<h2>인기 상품 목록</h2>
	<table border="1">
		<%
			for(Ebook e : popularEbookList) {
		%>
				<td>
					<div><a href="#"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a></div>
					<div><a href="#"><%=e.getEbookTitle()%></a></div>
					<div>₩ <%=e.getEbookPrice()%></div>
				</td>
		<% 		
			}
		%>
	</table>
	<br>
	<!-- 전체 상품 목록 -->
	<h2>전체 상품 목록</h2>
	<table border="1">
		<%
			int i = 0; // 줄바꿈하기 위한 변수
			for(Ebook e : ebookList) {
		%>
				<td>
					<div><a href="#"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a></div>
					<div><a href="#"><%=e.getEbookTitle()%></a></div>
					<div>₩ <%=e.getEbookPrice()%></div>
				</td>	
		<% 		
				i=i+1; // for문이 끝날때마다 i가 1씩 증가한다.
				if(i%5==0) { // i가 5로 나누어 떨어지면
		%>
					<tr></tr> <!-- 줄바꿈 -->
		<% 
				}
			}
		%>
	</table>
</body>
</html>