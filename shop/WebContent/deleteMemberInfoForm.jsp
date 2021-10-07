<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 로그인 하지 못한 사람은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	// selectMemberInfo에서 memberNo, memberName을 가져옴
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberName = request.getParameter("memberName");
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	System.out.println("[debug] memberName 확인 -> " + memberName);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> <!-- jQuery 사용 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- bootstrap 사용 -->
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
	
	<div class="jumbotron">
		<h3><%=memberName%>님 정말로 회원탈퇴 하시겠습니까?</h3>
		<form id="deleteForm" action="<%=request.getContextPath()%>/deleteMemberInfoAction.jsp?memberNo=<%=memberNo%>&memberName=<%=memberName%>" method="post">
			<input class="btn btn-dark" id="deleteBtn" type="button" value="회원탈퇴 하기">
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectMemberInfo.jsp">뒤로가기</a>
		</form>
	</div>
	
	<script>
		// $ = jquery, 유효성 검사
		$('#deleteBtn').click(function(){ // deleteBtn 버튼을 클릭 했을 때 함수를 실행시켜라.	
			$('#deleteForm').submit();
		}); 
	</script>
</body>
</html>