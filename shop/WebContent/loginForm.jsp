<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 인증 방어코드(로그인 전에만 열람 가능할 수 있도록)
	if(session.getAttribute("loginMember") != null) {
		System.out.println("[debug] 이미 로그인 되어있습니다.");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> <!-- jQuery 사용 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- 페이지 상단부분에 patial 폴더안의 mainMenu 내용 포함시키기 -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>

	<div class="jumbotron">
		<h1>* 로그인 페이지 *</h1>
		<form id="loginForm" action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<div>
				회원 아이디 : 
				<input class="btn btn-outline-secondary" type="text" name="memberId" placeholder="memberId 입력">
			</div>
			<div>
				회원 비밀번호 : 
				<input class="btn btn-outline-secondary" type="password" name="memberPw" placeholder="memberPw 입력">
			</div>
			<br>
			<div>
				<input class="btn btn-dark" type="button" id="loginBtn" value="로그인">
				<input class="btn btn-dark" type="reset" value="초기화">
				<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
			</div>
		</form>
	</div>
	
	<script>
		// $ = jquery
		$('#loginBtn').click(function(){ // loginBtn 버튼을 클릭 했을 때 함수를 실행시켜라.
			if($('#memberId').val() == '') { // id가 공백이면
				alert('memberId를 입력하세요');
				return;
			} else if($('#memberPw').val() == '') { // pw가 공백이면
				alert('memberPw를 입력하세요');
			} else {
				$('#loginForm').submit(); // <button type="button"> -> <button type="submit">	
			}
		}); 
	</script>
</body>
</html>