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
	
	// (1) QnaDao 클래스 객체 생성
	QnaDao qnaDao = new QnaDao();
	
	// (2) Qna 클래스 배열 객체 생성(selectQnaListByAllPage 메소드 이용)
	ArrayList<Qna> qnaList = qnaDao.selectQnaListPage(beginRow, ROW_PER_PAGE);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 게시판 관리 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- bootstrap 사용 -->
</head>
<body>
<%
	// (3) Member 클래스 변수 생성(로그인 기록정보 저장)
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
		<h1>* QnA 게시판 *</h1>
			<%
				// 로그인 한사람만 가능하도록(회원 및 관리자)
				if(loginMember != null) {
			%> 
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/insertQnaForm.jsp?memberNo=<%=loginMember.getMemberNo()%>">QnA 추가하기</a>
			<% 		
				}
			%>
			<table class="table table-secondary table-bordered" border="1">
				<thead>
					<tr>
						<th>qnaNo</th>
						<th>qnaCategory</th>
						<th>qnaTitle</th>
						<th>qnaSecret</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Qna q : qnaList) {
					%>	
							<tr>
								<td><%=q.getQnaNo()%></td>
								<td><%=q.getQnaCategory()%></td>
								<td><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>"><%=q.getQnaTitle()%></a></td>
								<%
									// q.getQnaSecret()값이 Y이면
									if(q.getQnaSecret().equals("Y")) {
								%>
										<td><%=q.getQnaSecret()%> (개방글)</td>
								<% 		
									// q.getQnaSecret()값이 X이면
									} else if(q.getQnaSecret().equals("N")){
								%>
										<td><%=q.getQnaSecret()%> (비밀글)</td>
								<% 		
									}
								%>
							</tr>
					<% 		
						}
					%>
				</tbody>
			</table>
			<div>
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectQnaList.jsp?currentPage=<%=currentPage-1%>">[이전]</a>
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectQnaList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
			</div>
	</div>
</body>
</html>