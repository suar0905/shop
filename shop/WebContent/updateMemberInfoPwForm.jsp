<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 로그인 하지 못한 사람은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// selectMemberInfo에서 memberNo를 가져옴
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 비밀번호 수정 페이지</title>
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
			<h4 style="text-align:center;">비밀번호를 변경해주세요</h4>
		</div>
		<form id="updateForm" action="<%=request.getContextPath()%>/updateMemberInfoPwAction.jsp?memberNo=<%=memberNo%>" method="post">
			<div class="form-group">
		      <h4><label class="form-label mt-4">변경할 비밀번호</label></h4>
		      <input class="form-control" style="text-align:left;" type="password" id="memberNewPw" name="memberNewPw" placeholder="새로운 비밀번호 입력">
		    </div>
		    
			<br>
			<input class="btn btn-dark" id="updateBtn" type="button" value="변경하기">
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectMemberInfo.jsp">뒤로가기</a>
		</form>
	</div>
	
	<script>
	// $ = jquery, 유효성 검사
		$('#updateBtn').click(function(){ // updateBtn 버튼을 클릭 했을 때 함수를 실행시켜라.	
		if($('#memberNewPw').val() == '') {
			alert('변경할 비밀번호를 입력하세요');
			return;
		}
		
		$('#updateForm').submit();
	}); 
	</script>
</body>
</html>