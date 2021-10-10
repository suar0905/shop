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
	
	// Notice 게시글 총 데이터 개수를 저장하는 변수
	int totalCount = noticeDao.totalNoticeCount();
	
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
		<h1>* 공지사항 게시판 *</h1>
			<%
				// 로그인 하였고, 회원등급이 0초과일 때(관리자)
				if(loginMember != null && loginMember.getMemberLevel() > 0) {
			%>
					<div>
						<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">추가하기</a>
					</div>
			<% 		
				}
			%>
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
										<td><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정하기</a></td>
										<td><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/admin/deleteNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&noticeTitle=<%=n.getNoticeTitle()%>&noticeContent=<%=n.getNoticeContent()%>&memberNo=<%=n.getMemberNo()%>">삭제하기</a></td>
								<% 		
									}
								%>
							</tr>
					<% 		
						}
					%>
				</tbody>			
			</table>
				<div class="text-center">
				<%
					// (1)에서 생성한 loginMember변수 사용
					// [처음으로(<<)] 버튼
				%>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectNoticeOne.jsp?currentPage=1">[처음으로]</a>
				<%
					// [이전(<)] 버튼
					// 화면에 보여질 시작 페이지 번호가 화면에 보여질 페이지 번호의 개수보다 크다면 이전 버튼을 생성
					if(startPage > displayPage) {
				%>
						<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectNoticeOne.jsp?currentPage=<%=startPage-displayPage%>">[이전]</a>
				<% 		
					}
				
					// 페이지 번호[1,2,3..9] 버튼
					for(int i=startPage; i<=endPage; i++) {
						System.out.println("[debug] 만들어지는 페이지 수 -> " + i);
				%>
						<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectNoticeOne.jsp?currentPage=<%=i%>">[<%=i%>]</a>
				<% 		
					}
					
					// [다음(>)] 버튼
					// 화면에 보여질 마지막 페이지 번호가 마지막 페이지 보다 작아지면 이전 버튼을 생성
					if(endPage < lastPage) {
				%>
						<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectNoticeOne.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
				<% 		
					}
					
					// [끝으로(>>)] 버튼
				%>	
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectNoticeOne.jsp?currentPage=<%=lastPage%>">[끝으로]</a>
			</div>
	</div>
	
</body>
</html>