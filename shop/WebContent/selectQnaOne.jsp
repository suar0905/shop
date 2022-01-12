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
	
	// Qna 목록 데이터 보여질 행의 수(final -> 바뀔 수 없음)
	final int ROW_PER_PAGE = 10;
	
	// Qna 목록 데이터 시작 행
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
	// 유효성검사(null 방지)
	if(request.getParameter("qnaNo") == null) {
		System.out.println("[debug] qnaNo 값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	// 공백 방지
	if(request.getParameter("qnaNo").equals("")) {
		System.out.println("[debug] qnaNo 값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	// selectQnaList에서 qnaNo값 가져옴
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("[debug] qnaNo 확인 -> " + qnaNo);
	
	// (1) Qna 클래스 객체 생성 (메소드 저장하기 위해)
	Qna qna = new Qna();
	
	// (2) QnaDao 클래스 객체 생성 (QnaDao 메소드 불러오기 위해)
	QnaDao qnaDao = new QnaDao();
	
	// qna 변수에 selectQnaListByAllPage 메소드 값 저장
	qna = qnaDao.selectQnaListByAllPage(qnaNo);
	
	// Qna 댓글 페이징
	int commentCurrentPage = 1;
	if(request.getParameter("commentCurrentPage") != null) {
		commentCurrentPage = Integer.parseInt(request.getParameter("commentCurrentPage"));
	}
	System.out.println("[debug] commentCurrentPage 확인 -> " + commentCurrentPage);
	
	// Qna 댓글 목록 데이터 보여질 행의 수(final -> 바뀔 수 없음)
	final int comment_ROW_PER_PAGE = 10; 
	
	// (3) QnaCommentDao 클래스 객체 생성 (QnaCommentDao 메소드 불러오기 위해)
	QnaCommentDao qcDao = new QnaCommentDao();
	
	// (4) QnaComment 클래스 변수 생성(selectCommentListByAllPage 메소드 값 저장)
	ArrayList<QnaComment> qcList = qcDao.selectCommentListByAllPage(qnaNo, commentCurrentPage, comment_ROW_PER_PAGE);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 게시판 상세보기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- bootstrap 사용 -->
</head>
<body>
<%
	// (5) Member 클래스 변수 생성(로그인 기록정보 저장)
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
	<div class="container">
		<div class="jumbotron">
		<% 	
			// ((로그인 정보가 있고(회원), 로그인한 회원번호와 qna 게시글의 회원번호가 일치하고, qnaSecret값이 개방글(Y)) 이거나 ((로그인 정보가 있고(회원), 로그인한 회원번호와 qna 게시글의 회원번호가 일치하고, qnaSecret값이 개방글(N)) 이거나 ((로그인 정보가 있고(회원), 회원등급이 0보다 클때) 
			if((loginMember != null && loginMember.getMemberNo() == qna.getMemberNo() && qna.getQnaSecret().equals("Y")) || (loginMember != null && loginMember.getMemberNo() == qna.getMemberNo() && qna.getQnaSecret().equals("N")) || (loginMember != null && loginMember.getMemberLevel() > 0)) {
		%>
				<h1><%=qna.getMemberNo()%>번 회원의 QnA 게시글 상세보기</h1>
				<%
					// 로그인 한사람만 가능하도록(회원 및 관리자)
					if(loginMember != null) {
				%>
						<div>
							<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/updateQnaForm.jsp?qnaNo=<%=qna.getQnaNo()%>&memberNo=<%=qna.getMemberNo()%>">수정하기</a>
							<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/deleteQnaForm.jsp?qnaNo=<%=qna.getQnaNo()%>&memberNo=<%=qna.getMemberNo()%>">삭제하기</a>
							<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/selectQnaList.jsp">뒤로가기</a>
						</div>
				<% 		
					} 
				%>
				<table class="table table-secondary table-bordered" style="text-align:center;" border="1">
					<tr>
						<th>번호</th>
						<td><%=qna.getQnaNo()%></td>
					</tr>
					<tr>	
						<th>카테고리</th>
						<td><%=qna.getQnaCategory()%></td>
					</tr>
					<tr>	
						<th>비밀여부</th>
						<td><%=qna.getQnaSecret()%></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><%=qna.getQnaTitle()%></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><%=qna.getQnaContent()%></td>
					</tr>
					<tr>
						<th>등록일</th>
						<td><%=qna.getCreateDate()%></td>
					</tr>
					<tr>
						<th>수정일</th>
						<td><%=qna.getUpdateDate()%></td>
					</tr>	
				</table>
				
				<p><h1>QnA 댓글 관리</h1>
				<!-- 댓글 입력 부분 -->
				<h2>[댓글 입력]</h2>
				<div>
					<form id="insertComment" action="<%=request.getContextPath()%>/insertCommentAction.jsp" method="post">
						<input type="hidden" name="qnaNo" value="<%=qnaNo%>">
						<input type="hidden" name="memberNo" value=<%=qna.getMemberNo()%>>
						<div class="form-group">
			 	 			<textarea name="qnaCommentContent" class="form-control" rows="5" id="qnaCommentContent"></textarea>
						</div>
						<input class="btn btn-dark" type="submit" value="댓글입력">
					</form>	
				</div>
				<br>
				<!-- 댓글 목록 출력, 10개씩 페이징 -->
				<h2>[댓글 목록]</h2>
					<% 
						for(QnaComment qc : qcList) {
					%>
							<div class="text-dark">
								<%=qc.getQnaCommentContent()%> 
								<a href="<%=request.getContextPath()%>/deleteCommentAction.jsp?qnaCommentNo=<%=qc.getQnaCommentNo()%>&qnaNo=<%=qnaNo%>" class="btn btn-outline-danger">삭제</a>
							</div>
					<%	
						}
					%>
					<div>
						<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=qnaNo%>&commentCurrentPage=<%=commentCurrentPage-1%>">[이전]</a>
						<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=qnaNo%>&commentCurrentPage=<%=commentCurrentPage+1%>">[다음]</a>
					</div>
			<% 
				// (로그인 정보가 없고(비회원), qnaSecret값이 개방글(Y)) 이거나 (로그인 정보가 있고(회원), qnaSecret값이 개방글(Y))일 때
				} else if((loginMember == null && qna.getQnaSecret().equals("Y")) || (loginMember != null && qna.getQnaSecret().equals("Y"))) {
			%>
					<h1><%=qna.getMemberNo()%>번 회원의 QnA 상세보기</h1>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/selectQnaList.jsp">뒤로가기</a>
					<table class="table table-secondary table-bordered" border="1">
						<tr>
							<th>번호</th>
							<td><%=qna.getQnaNo()%></td>
						</tr>
						<tr>	
							<th>카테고리</th>
							<td><%=qna.getQnaCategory()%></td>
						</tr>
						<tr>	
							<th>비밀여부</th>
							<td><%=qna.getQnaSecret()%></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><%=qna.getQnaTitle()%></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><%=qna.getQnaContent()%></td>
						</tr>
						<tr>
							<th>등록일</th>
							<td><%=qna.getCreateDate()%></td>
						</tr>
						<tr>
							<th>수정일</th>
							<td><%=qna.getUpdateDate()%></td>
						</tr>	
					</table>
					
					<p><h1>QnA 댓글 관리</h1>
					<!-- 댓글 목록 출력, 10개씩 페이징 -->
					<h2>[댓글 목록]</h2>
						<% 
							for(QnaComment qc : qcList) {
						%>
								<div class="text-dark">
									<%=qc.getQnaCommentContent()%> 
									<a href="<%=request.getContextPath()%>/deleteCommentAction.jsp?qnaCommentNo=<%=qc.getQnaCommentNo()%>&qnaNo=<%=qnaNo%>" class="btn btn-outline-danger">삭제</a>
								</div><br>
						<%	
							}
						%>
						<div>
							<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=qnaNo%>&commentCurrentPage=<%=commentCurrentPage-1%>">[이전]</a>
							<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=qnaNo%>&commentCurrentPage=<%=commentCurrentPage+1%>">[다음]</a>
						</div>
			<% 	 
				} else {
			%>
					<div>
						비밀글입니다. 뒤로 돌아가주세요
						<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
					</div>
			<% 		
				}
			%>
		</div>
	</div>
</body>
</html>