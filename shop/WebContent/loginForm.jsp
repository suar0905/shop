<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// * 인증 방어 코드 * 
	// 로그인 전(session.getAttribute("loginMember") -> null)에만 페이지 열람 가능하다.
	if(session.getAttribute("loginMember") != null){
		System.out.println("[debug] 이미 로그인 되어 있습니다.");
		// 상대주소 표기
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return; // 메소드를 종료시켜라.
	}	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> <!-- jQuery 사용 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- bootstrap 사용 -->
</head>
<body class="container">
	<!-- start : submenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<div>
	<h1 class="alert alert-info">로그인 페이지</h1>
	<form id="loginForm" class="talbe table-info table-striped" action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<table>
			<tr>
				<th>아이디 : </th>
				<td><input type="text" id="memberId" name="memberId" placeholder="Enter Id" value=""></td>
			</tr>
			<tr>
				<th>비밀번호 : </th>
				<td><input type="password" id="memberPw" name="memberPw" placeholder="Enter Pw" value=""></td>
			</tr>
		</table>
		<br>
		<input class="btn btn-dark" id="loginBtn" type="button" value="로그인" >
		<input class="btn btn-dark" type="reset" value="초기화">
		<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
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