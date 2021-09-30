<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

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
	
	// 유효성 검사(null 방지) 및 공백 방지 코드
	if(request.getParameter("memberNo") == null || request.getParameter("memberNo").equals("")) {
		System.out.println("[debug] memberNo값이 null이거나 공백값 입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
		return;
	}
	
	// selectMemberList에서 memberNo 값을 가져옴
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 디버깅 코드
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	
	// (2) MemberDao 클래스 객체 생성
	MemberDao memberDao = new MemberDao();
	
	// (3) Member 클래스 배열 객체 생성
	ArrayList<Member> memberList = memberDao.selectMemberOne(memberNo);
	System.out.println("[debug] memberList 확인 -> " + memberList);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세보기 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<div class="jumbotron">
		<h1><%=memberNo%>번 회원 상세보기</h1>
		<table class="table table-secondary table-bordered" border="1">
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
				</tr>
			</thead>
			<tbody>
				<%
					for(Member m : memberList) {
				%>
						<tr>
							<td><%=m.getMemberNo()%></td>
							<td><%=m.getMemberId()%></td>
							<td><%=m.getMemberLevel()%></td>
							<td><%=m.getMemberName()%></td>
							<td><%=m.getMemberAge()%></td>
							<td><%=m.getMemberGender()%></td>
							<td><%=m.getUpdateDate()%></td>
							<td><%=m.getCreateDate()%></td>
						</tr>
				<% 		
					}
				%>
			</tbody>
		</table>
		<div><input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();"></div>
	</div>	
</body>
</html>