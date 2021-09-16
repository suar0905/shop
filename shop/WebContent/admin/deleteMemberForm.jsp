<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// * 인증 방어 코드 * 
	// (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	// selectMemberList에서 memberNo를 받아옴
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	// 디버깅 코드
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 삭제 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
 	<div class="container">
 	
 	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
	<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<h1 class="alert alert-info">회원정보 삭제 페이지</h1>
	<form class="talbe table-info table-striped" action="deleteMemberAction.jsp" method="post">
		<div>
			삭제할 번호 :
			<input type="text" name="memberNo" value="<%=memberNo%>" readonly="readonly"><p> 
			정말로 삭제하시겠습니까?
			<input class="btn btn-dark" type="submit" value="삭제하기">
			<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
		</div>
	</form>
	</div>
</body>
</html>