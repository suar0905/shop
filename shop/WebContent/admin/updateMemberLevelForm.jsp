<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member" %>
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
	
	// selectMemberList에서 항목 값들을 가져옴
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberId = request.getParameter("memberId");
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	
	// 디버깅 코드
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	System.out.println("[debug] memberId 확인 -> " + memberId);
	System.out.println("[debug] memberLevel 확인 -> " + memberLevel);
	System.out.println("[debug] memberName 확인 -> " + memberName);
	System.out.println("[debug] memberAge 확인 -> " + memberAge);
	System.out.println("[debug] memberGender 확인 -> " + memberGender);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원등급 수정 페이지</title>
</head>
<body>
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<div class="jumbotron">
		<h1>* 회원등급 수정 페이지 *</h1>
		<form action="<%=request.getContextPath()%>/admin/updateMemberLevelAction.jsp" method="post">
			<table class="table table-secondary table-bordered" border="1">
				<thead>
					<tr>
						<th>memberNo</th>
						<td><input class="btn btn-outline-secondary" type="text" value="<%=memberNo%>" name="memberNo" readonly="readonly"></td>
					</tr>
					<tr>
						<th>memberId</th>
						<td><input class="btn btn-outline-secondary" type="text" value="<%=memberId%>" name="memberId" readonly="readonly"></td>
					</tr>
					<tr>
						<th>memberLevel</th>
						<td>
							<select name="memberNewLevel">
								<option value="0">0</option>
								<option value="1">1</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>memberName</th>
						<td><input class="btn btn-outline-secondary" type="text" value="<%=memberName%>" name="memberName" readonly="readonly"></td>
					</tr>
					<tr>
						<th>memberAge</th>
						<td><input class="btn btn-outline-secondary" type="text" value="<%=memberAge%>" name="memberAge" readonly="readonly"></td>
					</tr>
					<tr>
						<th>memberGender</th>
						<td><input class="btn btn-outline-secondary" type="text" value="<%=memberGender%>" name="memberGender" readonly="readonly"></td>
					</tr>
				</thead>
			</table>
			<br>
			<div>
				<input class="btn btn-dark" type="submit" value="수정하기">
				<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
			</div>
		</form>
	</div>
</body>
</html>