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
<title>회원가입</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h1 class="alert alert-info">회원가입 페이지</h1>
		<form class="talbe table-info table-striped" action="insertMemberAction.jsp" method="post">
			<table border="">
				<!-- memberId -->
				<tr>
					<th>아이디 : </th>
					<td><input type="text" name="memberId"></td>
				</tr>
				<!-- memberPw -->
				<tr>
					<th>비밀번호 : </th>
					<td><input type="password" name="memberPw"></td>
				</tr>
				<!-- memberLevel -->
				<tr>
					<th>레벨 : </th>
					<td>
						<input type="radio" name="memberLevel" value="0">0단계
					</td>
				</tr>
				<!-- memberName -->
				<tr>
					<th>이름 : </th>
					<td><input type="text" name="memberName"></td>
				</tr>
				<!-- memberAge -->
				<tr>
					<th>나이 : </th>
					<td><input type="text" name="memberAge"></td>
				</tr>
				<!-- memberGender -->
				<tr>
					<th>성별 : </th>
					<td>
						<input type="radio" name="memberGender" value="남">남
						<input type="radio" name="memberGender" value="여">여
					</td>
				</tr>			
			</table>
			<br>
			<div>
				<input class="btn btn-dark" type="submit" value="회원가입하기">
				<input class="btn btn-dark" type="reset" value="초기화">
				<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
			</div>
		</form>
	</div>
</body>
</html>