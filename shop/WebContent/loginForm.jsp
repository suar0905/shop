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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
	<h1 class="alert alert-info">로그인 페이지</h1>
	<form class="talbe table-info table-striped" action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<table>
			<tr>
				<th>아이디 : </th>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<th>비밀번호 : </th>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<br>
		<input class="btn btn-dark" type="submit" value="로그인">
		<input class="btn btn-dark" type="reset" value="초기화">
		<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
	</form>
	</div>
</body>
</html>