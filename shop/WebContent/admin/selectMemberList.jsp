<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// (1) Member클래스 객체 생성, (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("[debug] 로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 검색어
	String searchMemberId=""; // 공백값을 항상 지니고 있음
	if(request.getParameter("searchMemberId") != null) {
		searchMemberId = request.getParameter("searchMemberId");
	}
	System.out.println("[debug] searchMemberId 확인 -> " + searchMemberId);
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[debug] currentPage 확인 -> " + currentPage);
	
	// 회원목록 데이터 표시되는 행의 수
	// final -> 절때 변하지 않다. 상수 변수는 대문자, 일반 변수는 소문자
	final int ROW_PER_PAGE = 10;
	
	// 회원목록 데이터 시작 행
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
	// (2) MemberDao 클래스 객체 생성
	MemberDao memberDao = new MemberDao();
	
	// (3) Member 클래스 배열 객체 생성
	ArrayList<Member> memberList = new ArrayList<Member>();
	
	// searchMemberId 검색어에 따른 데이터 표시
	int selectCountNum = 0; // 검색어 유, 무를 구분하기 위한 변수
	if(searchMemberId.equals("") == true) { // 검색어가 공백일 때(selectMemberListAllByPage 메소드 이용)
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
		System.out.println("[debug] memberList 확인 -> " + memberList); // 디버깅 코드
		selectCountNum = memberDao.totalMemberCount();
		System.out.println("[debug] selectCountNum 확인 -> " + selectCountNum); // 디버깅 코드
	} else { // 검색어가 있을 때(selectMemberListAllBySearchMemberId 메소드 이용)
		memberList = memberDao.selectMemberListAllBySearchMemberId(beginRow, ROW_PER_PAGE, searchMemberId);
		System.out.println("[debug] memberList 확인 -> " + memberList); // 디버깅 코드
		selectCountNum = memberDao.selectTotalMemberCount(searchMemberId);
		System.out.println("[debug] selectCountNum 확인 -> " + selectCountNum); // 디버깅 코드
	}
	
	// 데이터의 총 개수()
	int totalCount = memberDao.totalMemberCount();
	
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
<title>회원목록 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- 페이지 상단부분에 patial 폴더안의 adminMenu 내용 포함시키기 -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	
	<div class="jumbotron">
		<h1>* 회원목록 페이지 *</h1>
		<table class="table table-secondary table-bordered" border="1">
			<thead>
				<tr>
					<th>memberNo</th>
					<th>memberId</th>
					<th>memberLevel</th>
					<th>memberName</th>
					<th>회원상세보기</th>
					<th>회원등급 수정</th>
					<th>회원비밀번호 수정</th>
					<th>회원탈퇴</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Member m : memberList) {
				%>
						<tr>
							<td><%=m.getMemberNo()%></td>
							<td><%=m.getMemberId()%></td>
							<td>
								<%=m.getMemberLevel()%>
								<%
									if(m.getMemberLevel() == 0) {
								%>
										<span>[일반회원]</span>
								<% 		
									} else if(m.getMemberLevel() == 1) {
								%>
										<span>[관리자]</span>
								<% 		
									}
								%>
							</td>
							<td><%=m.getMemberName()%></td>
							<td><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/admin/selectMemberOne.jsp?memberNo=<%=m.getMemberNo()%>">회원상세보기</a></td>
							<td>
								<!-- 특정 회원등급을 수정한다. -->
								<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>&memberId=<%=m.getMemberId()%>&memberLevel=<%=m.getMemberLevel()%>&memberName=<%=m.getMemberName()%>&memberAge=<%=m.getMemberAge()%>&memberGender=<%=m.getMemberGender()%>">회원등급 수정</a>
							</td>
							<td>
								<!-- 특정 회원비밀번호를 수정한다. -->
								<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/admin/updateMemberPwForm.jsp?memberNo=<%=m.getMemberNo()%>&memberId=<%=m.getMemberId()%>&memberLevel=<%=m.getMemberLevel()%>&memberName=<%=m.getMemberName()%>&memberAge=<%=m.getMemberAge()%>&memberGender=<%=m.getMemberGender()%>">회원비밀번호 수정</a>
							</td>
							<td>
								<!-- 특정 회원정보를 삭제한다. -->
								<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/admin/deleteMemberForm.jsp?memberNo=<%=m.getMemberNo()%>&memberId=<%=m.getMemberId()%>&memberLevel=<%=m.getMemberLevel()%>&memberName=<%=m.getMemberName()%>&memberAge=<%=m.getMemberAge()%>&memberGender=<%=m.getMemberGender()%>">회원정보 삭제</a>
							</td>
						</tr>	
				<% 		
					}
				%>
			</tbody>
		</table>
		<br>
		<div class="text-center">
		<!-- memberId를 통해 검색하기 -->	
		<div>
			<form action="<%=request.getContextPath()%>/admin/selectMemberList.jsp" method="post">
				<div>
					회원아이디 검색 :
					<input class="btn btn-outline-secondary" type="text" name="searchMemberId">
					<input class="btn btn-outline-dark" type="submit" value="검색하기">
				</div>
			</form>
		</div>	
		
		<%
			// (1)에서 생성한 loginMember변수 사용
			// [처음으로(<<)] 버튼
		%>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=1&searchMemberId=<%=searchMemberId%>">[처음으로]</a>
		<%
			// [이전(<)] 버튼
			// 화면에 보여질 시작 페이지 번호가 화면에 보여질 페이지 번호의 개수보다 크다면 이전 버튼을 생성
			if(startPage > displayPage) {
		%>
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=startPage-displayPage%>&searchMemberId=<%=searchMemberId%>">[이전]</a>
		<% 		
			}
		
			// 페이지 번호[1,2,3..9] 버튼
			for(int i=startPage; i<=endPage; i++) {
				System.out.println("[debug] 만들어지는 페이지 수 -> " + i);
		%>
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=i%>&searchMemberId=<%=searchMemberId%>">[<%=i%>]</a>
		<% 		
			}
			
			// [다음(>)] 버튼
			// 화면에 보여질 마지막 페이지 번호가 마지막 페이지 보다 작아지면 다음 버튼을 생성
			if(endPage < lastPage) {
		%>
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage+1%>&searchMemberId=<%=searchMemberId%>">[다음]</a>
		<% 		
			}
			
			// [끝으로(>>)] 버튼
		%>	
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=lastPage%>&searchMemberId=<%=searchMemberId%>">[끝으로]</a>
		</div>
	</div>		
</body>
</html>