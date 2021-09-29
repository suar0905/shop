<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[debug] currentPage 확인 -> " + currentPage);
	
	// 목록 데이터 보여질 행의 수(final -> 바뀔 수 없음)
	final int ROW_PER_PAGE = 10;
	
	// 목록 데이터 시작 행
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
	// NoticeDao 클래스 객체 생성
	NoticeDao noticeDao = new NoticeDao();
	
	// Notice 클래스 배열 변수 생성(selectNoticeListByAllPage 메소드 이용)
	ArrayList<Notice> list = noticeDao.selectNoticeListByAllPage(beginRow, ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- bootstrap 사용 -->
</head>
<body>
<%
	// Member 클래스 변수 생성(로그인 기록정보 저장)
	Member loginMember = (Member)session.getAttribute("loginMember");
	// 로그인 하지 못했거나(비회원), 회원등급이 1미만일 때(회원) 
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
%>
		<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
		<div>
			<!-- 절대주소(기준점이 같음) -->
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : mainMenu include -->
<% 		
	// 로그인 하였고, 회원등급이 0초과일 때(관리자)
	} else if(loginMember != null && loginMember.getMemberLevel() > 0) {
%>
		<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
		<div>
		<!-- 절대주소(기준점이 같음) -->
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!-- end : mainMenu include -->
<% 		
	}
%>
	<div class="jumbotron">
	<h1>* 공지사항 *</h1>
		<table class="table table-secondary table-bordered" border="1">
			<thead>
				<tr>
					<th>noticeNo</th>
					<th>noticeTitle</th>
					<th>noticeContent</th>
					<th>memberNo</th>
					<th>createDate</th>
					<th>updateDate</th>
					<%
						// 로그인 하였고, 회원등급이 0초과일 때(관리자)
						if(loginMember != null && loginMember.getMemberLevel() > 0) {
					%>
							<th>수정</th>
							<th>삭제</th>
					<% 		
						}
					%>
				</tr>
			</thead>
			<tbody>
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td><%=n.getNoticeNo()%></td>
							<td><%=n.getNoticeTitle()%></td>
							<td><%=n.getNoticeContent()%></td>
							<td><%=n.getMemberNo()%></td>
							<td><%=n.getCreateDate()%></td>
							<td><%=n.getUpdateDate()%></td>
							<%
								// 로그인 하였고, 회원등급이 0초과일 때(관리자)
								if(loginMember != null && loginMember.getMemberLevel() > 0) {
							%>
									<td><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/updateNoticeForm.jsp">수정하기</a></td>
									<td><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/deleteNoticeForm.jsp">삭제하기</a></td>
							<% 		
								}
							%>
						</tr>
				<% 		
					}
				%>
			</tbody>			
		</table>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectNoticeOne.jsp?currentPage=<%=currentPage-1%>">[이전]</a>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectNoticeOne.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
	</div>
	
</body>
</html>