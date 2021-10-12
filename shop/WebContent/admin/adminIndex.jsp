<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
	<!-- 관리자 메뉴 include -->
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<div class="jumbotron">
	<h1>관리자 페이지</h1>
	</div>
	<br>
	<!-- QnA 목록 -->
	<h2>최신 QnA 목록</h2>
	<table border="1">
		<%
			for(Qna q : newQnaList) {
		%>
				<td>
					<div><a href="<%=request.getContextPath()%>/selectQnaList.jsp">● <%=q.getQnaNo()%>번 게시물</a></div>
					<div><%=q.getMemberNo()%>번 회원</div>
					<div>제목 : <%=q.getQnaTitle()%></div>
				</td>
		<%		
			}
		%>
	</table>
	<br>
	<!-- 공지사항 목록 -->
	<h2>최신 공지사항 목록</h2>
	<table border="1">
		<%
			for(Notice n : newNoticeList) {
		%>
				<td>
					<div><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp">● <%=n.getNoticeNo()%>번 공지</a></div>
					<div><%=n.getMemberNo()%>번 회원의</div>
					<div>제목 : <%=n.getNoticeTitle()%></div>
				</td>
		<%		
			}
		%>
	</table>
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
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
						<img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a></div>
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
					<div>₩ <%=e.getEbookPrice()%></div>
				</td>
		<% 		
			}
		%>
	</table>
	<br>
	<!-- 전체 상품 목록 -->
	<div>
		<h2>전체 상품 목록</h2>
		<table border="1">
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
		<div>
			<%
				// 이전 버튼
				if(startPage > displayPage) {
			%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<% 		
				}
				
				// 페이지 번호[1,2,3..9] 버튼
				for(int j=startPage; j<=endPage; j++) {
					System.out.println("[debug] 만들어지는 페이지 수 -> " + j);
			%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=j%>">[<%=j%>]</a>
			<% 		
				}	
		
				// 다음 버튼
				if(endPage < lastPage) {
			%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%  		
				}
			%>
		</div>
	</div>	
</body>
</html>