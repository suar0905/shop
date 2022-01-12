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
	<div class="container">
	<%
		// 페이징
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		// 디버깅 코드
		System.out.println("[debug] currentPage 확인 -> " + currentPage);
		
		// 목록 데이터 보여질 행의 수(final -> 바뀔 수 없음)
		final int ROW_PER_PAGE = 10;
		
		// 목록 데이터 시작 행
		int beginRow = (currentPage - 1) * ROW_PER_PAGE;
		
		// (1) EbookDao 클래스 객체 생성
		EbookDao ebookDao = new EbookDao();
	
		// (2) Ebook 클래스 배열 객체 생성(전체 상품 목록 출력)
		ArrayList<Ebook> ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
		
		// (3) Ebook 클래스 배열 객체 생성(인기 상품 목록 5개 출력)
		ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
		
		// (4) Ebook 클래스 배열 객체 생성(신상품 목록 5개 출력)
		ArrayList<Ebook> newEbookList = ebookDao.selectNewEbookList();
		
		// (5) NoticeDao 클래스 객체 생성
		NoticeDao noticeDao = new NoticeDao();
		
		// (6) Notice 클래스 배열 객체 생성(최신 공지사항 5개 출력)
		ArrayList<Notice> newNoticeList = noticeDao.selectNoticeListRecentDatePage();
		
		// (7) QnaDao 클래스 객체 생성
		QnaDao qnaDao = new QnaDao();
		
		// (8) Qna 클래스 배열 객체 생성(최신 Qna 개방글 게시물 5개 출력)
		ArrayList<Qna> newQnaList = qnaDao.selectQnaListRecentDatePage();
		
		// 전자책 상품 총 개수
		int totalCount = ebookDao.totalEbookCount();
		
		// 마지막 페이지
		int lastPage = totalCount / ROW_PER_PAGE;
		if(totalCount % ROW_PER_PAGE != 0) {
			lastPage = lastPage + 1;
		}
		System.out.println("[debug] lastPage 확인 -> " + lastPage);
		
		// 화면에 보여질 페이지 번호의 개수([1], [2], [3] ... [10])
		int displayPage = 10;
		
		// 화면에 보여질 시작 페이지 번호
		// ((현재페이지번호 - 1) / 화면에 보여질 페이지 번호) * 화면에 보여질 페이지번호 + 1;
		// (currentPage - 1)을 하는 이유는 현재페이지가 10일시에도 startPage가 1이기 위해
		int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
		System.out.println("[debug] startPage 확인 -> " + startPage);
		
		// 화면에 보여질 끝 페이지 번호
		// 화면에 보여질 시작 페이지 번호 + 화면에 보여질 페이지 번호 - 1
		// -1을 하는 이유: 페이지 번호의 개수가 10개이기 때문에 startPage에서 더한 1을 빼준다.
		int endPage = startPage + displayPage - 1;
		System.out.println("[debug] endPage 확인 -> " + endPage); 
	%>
	<br>

	<div class="row">
		<!-- QnA 목록 -->
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-header" style="text-align: center;">신규 QnA 목록</div>
				<div class="table-responsive table-hover">
					<table class="card-table table" style="text-align: center;">
						<thead>					
							<tr>
								<th>QnA 번호</th>
								<th>QnA 제목</th>
								<th>QnA 작성일</th>
							</tr>
						</thead>
						<tbody>
							<%
								for(Qna q : newQnaList) {
							%>
									<tr>
										<td><%=q.getQnaNo()%></td>
										<td><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>"><%=q.getQnaTitle()%></a></td>
										<td><%=q.getCreateDate()%></td>
									</tr>
							<%
								}
							%>		
						</tbody>	
					</table>
				</div>
			</div>
		</div>
	
		<!-- 공지사항 목록 -->
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-header" style="text-align: center;">신규 공지사항 목록</div>
				<div class="table-responsive table-hover">
					<table class="card-table table" style="text-align: center;">
						<thead>					
							<tr>
								<th>공지사항 번호</th>
								<th>공지사항 제목</th>
								<th>공지사항 작성일</th>
							</tr>
						</thead>
						<tbody>
							<%
								for(Notice n : newNoticeList) {
							%>
									<tr>
										<td><%=n.getNoticeNo()%></td>
										<td><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp"><%=n.getNoticeTitle()%></a></td>
										<td><%=n.getCreateDate()%></td>
									</tr>
							<%
								}
							%>		
						</tbody>	
					</table>
				</div>
			</div>
		</div>
	</div>					
	
	<br>
	
	<div class="row">
		<!-- 신상품 목록 -->
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-header" style="text-align: center;">신규 상품 목록</div>
				<div class="table-responsive">
					<table class="card-table table" style="text-align: center;">
						<%
							for(Ebook e : newEbookList) {
						%>
								<td>
									<div>
										<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
									</div>
									<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
									<div>₩ <%=e.getEbookPrice()%></div>
								</td>
						<% 		
							}
						%>
					</table>
				</div>
			</div>
		</div>
		
		<!-- 인기상품 목록 -->
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-header" style="text-align: center;">인기 상품 목록</div>
				<div class="table-responsive">
					<table class="card-table table" style="text-align: center;">
						<%
							for(Ebook e : popularEbookList) {
						%>
								<td>
									<div>
										<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
									</div>
									<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
									<div>₩ <%=e.getEbookPrice()%></div>
								</td>
						<% 		
							}
						%>
					</table>
				</div>
			</div>
		</div>
		
	</div>	
	
	<br>
	
	<!-- 전체 상품 목록 -->
	<div class="row">
		<!-- 신상품 목록 -->
		<div class="col-lg-12">
			<div class="card mb-4">
				<div class="card-header" style="text-align: center;">전체 상품 목록</div>
				<div class="table-responsive">
					<table class="card-table table" style="text-align: center;">
					<%
						int i = 0; // 줄바꿈하기 위한 변수
						for(Ebook e : ebookList) {
					%>
							<td>
								<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a></div>
								<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
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
					
					<!-- 페이징 -->
					<div style="text-align: center;">
					<%
						// 이전 버튼
						if(startPage > displayPage) {
					%>
							<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage-1%>">이전</a>
					<% 		
						}
						
						// 페이지 번호[1,2,3..9] 버튼
						for(int j=startPage; j<=endPage; j++) {
							System.out.println("[debug] 만들어지는 페이지 수 -> " + j);
					%>
							<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=j%>">[<%=j%>]</a>
					<% 		
						}	
				
						// 다음 버튼
						if(endPage < lastPage) {
					%>
							<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage+1%>">다음</a>
					<%  		
						}
					%>
					</div>
				</div>
			</div>
		</div>
	</div>				
</body>
</html>