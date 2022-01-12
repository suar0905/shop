<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8"); 

	// * 인증 방어 코드 * 
	// 로그인 하지 못한 사람은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 유효성 검사(null 방지)
	if(request.getParameter("qnaNo") == null) {
		System.out.println("[debug] qnaNo값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return; 
	}
	
	// 공백 방지
	if(request.getParameter("qnaNo").equals("")) {
		System.out.println("[debug] qnaNo값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
		
	// selectQnaOne에서 qnaNo값 가져옴
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("[debug] qnaNo 확인 -> " + qnaNo);	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 삭제 페이지</title>
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
		<div class="container"> 
			<div class="jumbotron">
				<h4>정말로 <%=qnaNo%>번 QnA 게시글을 삭제하시겠습니까?</h4><br>
				
				<form id="deleteForm" action="<%=request.getContextPath()%>/deleteQnaAction.jsp?qnaNo=<%=qnaNo%>" method="post">
					<input class="btn btn-dark" type="button" id="deleteBtn" value="삭제하기">
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectQnaOne.jsp">뒤로가기</a>
				</form>	
			</div>
		</div>
		
		<script>
			$('#deleteBtn').click(function(){
				$('#deleteForm').submit();
			});
		</script>
</body>
</html>	