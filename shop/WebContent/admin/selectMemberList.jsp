<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*" %>
<%
	// 한글 깨짐 방지(request값을 받을 때는 무조건 쓰기)
	request.setCharacterEncoding("utf-8");

	// (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 검색어
	String searchMemberId = ""; // 공백으로 항상 있음.
	if(request.getParameter("searchMemberId") != null){
		searchMemberId = request.getParameter("searchMemberId");
	}
	System.out.println("[debug] searchMemberId 확인 -> " + searchMemberId);
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[debug] currentPage 확인 -> " + currentPage);
	
	final int ROW_PER_PAGE = 10; // 보여지는 데이터의 행 10개, final = 고치지 말아라. 일반적인 변수 = 소문자, 상수 변수 = 대문자
	
	int beginRow = (currentPage -1) * ROW_PER_PAGE;
	
	// (1) MemberDao 클래스 객체 생성
	MemberDao memberDao = new MemberDao();
	
	ArrayList<Member> memberList = null;
	
	// 검색어 ISSUE 해결 -> 검색어 있을 때, 없을 때 구분
	int selectCountNum = 0; // 검색어 유, 무 구분하기 위한 변수
	if(searchMemberId.equals("") == true) { // 검색어가 없을 때
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
		selectCountNum = memberDao.totalMemberCount(ROW_PER_PAGE);
	} else { // 검색어가 있을 때
		memberList = memberDao.selectMemberListAllBySearchMemberId(beginRow, ROW_PER_PAGE, searchMemberId);
		selectCountNum = memberDao.selectTotalMemberCount(searchMemberId, ROW_PER_PAGE);
	}
	
	// (2) 페이징 처리
	int totalCount = memberDao.totalMemberCount(ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container-fluid">

	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<h1>회원 목록</h1>
	<table class="talbe table-info table-striped" border="1">
		<thead>
			<tr>
				<th>memberNo</th>
				<th>memberId</th>
				<th>memberLevel</th>
				<th>memberName</th>
				<th>memberAge</th>
				<th>memberGender</th>
				<th>updateDate</th>
				<th>createDate</th>
				<th>등급수정</th>
				<th>비밀번호수정</th>
				<th>회원탈퇴</th>
				<th></th>
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
							if(m.getMemberLevel() == 0){
						%>
								<span>일반회원</span>
						<%
							} else if(m.getMemberLevel() == 1){
						%>
								<span>관리자</span>
						<% 		
							}			
						%>	
						(<%=request.getContextPath()%>)
					</td>
					<td><%=m.getMemberName()%></td>
					<td><%=m.getMemberAge()%></td>
					<td><%=m.getMemberGender()%></td>
					<td><%=m.getUpdateDate()%></td>
					<td><%=m.getCreateDate()%></td>
					<td>
						<!-- 특정회원의 등급을 수정한다. -->
						<a href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>&memberLevel=<%=m.getMemberLevel()%>">등급수정</a>
					</td>
					<td>
						<!-- 특정 회원의 비밀번호를 수정한다. -->
						<a href="<%=request.getContextPath()%>/admin/updateMemberPwForm.jsp?memberNo=<%=m.getMemberNo()%>&memberName=<%=m.getMemberName()%>">비밀번호수정</a>
					</td>
					<td>
						<!-- 특정 회원 정보를 강제 탈퇴시킨다. -->
						<a href="<%=request.getContextPath()%>/admin/deleteMemberForm.jsp?memberNo=<%=m.getMemberNo()%>">회원탈퇴</a>
					</td>
				</tr>
			<%      
            	}
         	%>
         </tbody>
	</table>
   	<div>
		<%
			if (currentPage > 1) {
		%>
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage-1%>&searchMemberId=<%=searchMemberId%>">이전</a>
		<%
			}
		%>
		<%		
			int lastPage = totalCount / ROW_PER_PAGE;
			
			if (totalCount % ROW_PER_PAGE != 0) {
				lastPage += 1;
			}
		
			if (currentPage < lastPage) {
		%>
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage+1%>&searchMemberId=<%=searchMemberId%>">다음</a>
		<%
			}
		%>
	</div>
	<div>
	<!-- memberId로 검색 -->
		<form action="<%=request.getContextPath()%>/admin/selectMemberList.jsp" method="get"> 
			아이디 검색 : 
			<input type="text" name="searchMemberId">
			<input class="btn btn-dark" type="submit" value="검색">
		</form>
	</div>
</div>	
</body>
</html>