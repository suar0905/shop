<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 로그인하지 못한 사람은 로그인해야됨
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		System.out.println("로그인하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	// (1) MemberDao 클래스 객체 생성
	MemberDao memberDao = new MemberDao();
	
	// (2) Member 클래스 배열 객체 변수 생성(selectMemberOne 메소드 이용)
	ArrayList<Member> list = memberDao.selectMemberOne(loginMember.getMemberNo());
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<%
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
			<h4 style="text-align:center;">회원정보 페이지</h4>
		</div>
		<div>	
			<table class="table table-secondary table-bordered" style="text-align:center;" border="1">
				<%
					for(Member m : list) {
				%>
						<div>
							<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/updateMemberInfoPwForm.jsp?memberNo=<%=m.getMemberNo()%>">비밀번호 수정</a> 
							<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/deleteMemberInfoForm.jsp?memberNo=<%=m.getMemberNo()%>&memberName=<%=m.getMemberName()%>">회원탈퇴</a>
						</div>
						<tr>
							<th>회원아이디</th>
							<td><%=m.getMemberId()%></td>
						</tr>
						<tr>
							<th>회원등급</th>
							<td><%=m.getMemberLevel()%></td>
						</tr>
						<tr>
							<th>회원이름</th>
							<td><%=m.getMemberName()%></td>
						</tr>
						<tr>
							<th>회원나이</th>
							<td><%=m.getMemberAge()%></td>
						</tr>
						<tr>
							<th>성별</th>
							<td><%=m.getMemberGender()%></td>
						</tr>
						<tr>
							<th>가입날짜</th>
							<td><%=m.getCreateDate()%></td>
						</tr>
						<tr>
							<th>수정날짜</th>
							<td><%=m.getUpdateDate()%></td>
						</tr>
				<% 		
					}
				%>
			</table>
		</div>
	</div>
</body>
</html>