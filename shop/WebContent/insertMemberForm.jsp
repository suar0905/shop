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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h1 class="alert alert-info">회원가입 페이지</h1>
		
		<%
			// memberIdCheck : 아이디 확인 값
			String memberIdCheck = "";
			if(request.getParameter("memberIdCheck") != null) {
				memberIdCheck = request.getParameter("memberIdCheck");
			}
		
		%>
		
		<!-- selectMemberIdCheckAction에서 idCheckResult값 가져옴 -->
		<div><input type="hidden" value="<%=request.getParameter("idCheckResult")%>"></div>
		
		<!-- 아이디(memberId)를 사용가능한지 확인하는 폼 -->
		<form class="talbe table-info table-striped" action="<%=request.getContextPath()%>/selectMemberIdCheckAction.jsp" method="post">
			<div>
				중복아이디 검사 :
				<input type="text" name="memberIdCheck">
				<input class="btn btn-dark" type="submit" value="중복아이디 검사">
			</div>
		</form>
		
		<!-- 회원가입을 할 때 사용하는 폼 -->
		<form id="joinForm" class="talbe table-info table-striped" action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
			<table border="">
				<!-- memberId -->
				<tr>
					<th>아이디 : </th>
					<td><input type="text" id="memberId" name="memberId" readonly="readonly" value=<%=memberIdCheck%>></td>
				</tr>
				<!-- memberPw -->
				<tr>
					<th>비밀번호 : </th>
					<td><input type="password" id="memberPw" name="memberPw" value=""></td>
				</tr>
				<!-- memberLevel -->
				<tr>
					<th>회원등급 : </th>
					<td><input type="text" id="memberLevel" name="memberLevel" value="0" readonly="readonly"></td>
				</tr>
				<!-- memberName -->
				<tr>
					<th>이름 : </th>
					<td><input type="text" id="memberName" name="memberName" value=""></td>
				</tr>
				<!-- memberAge -->
				<tr>
					<th>나이 : </th>
					<td><input type="text" id="memberAge" name="memberAge" value=""></td>
				</tr>
				<!-- memberGender -->
				<tr>
					<th>성별 : </th>
					<td>
						<input type="radio" class="memberGender" name="memberGender" value="남">남 
						<input type="radio" class="memberGender" name="memberGender" value="여">여
					</td>
				</tr>			
			</table>		
			<br>
			<div>
				<input class="btn btn-dark" id="btn" type="button" value="회원가입하기">
				<input class="btn btn-dark" type="reset" value="초기화">
				<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
			</div>
		</form>
	</div>
	
	<script>
		// 회원가입 폼 유효성 검사
		$('#btn').click(function() {
			if($('#memberId').val() == '') {
				alert('memberId를 입력하세요');
				return;
			}
			if($('#memberPw').val() == '') {
				alert('memberPw를 입력하세요');
				return;
			}
			if($('#memberName').val() == '') {
				alert('memberName를 입력하세요');
				return;
			}
			if($('#memberAge').val() == '') {
				alert('memberAge를 입력하세요');
				return;
			}
			
			let memberGender = $('.memberGender:checked'); // :뒤에는 옵션이다. 클래스(.) 속성으로 가져오면 무조건 배열이여서 변수로 지정해준다.
			if(memberGender.length == 0) {
				alert('memberGender를 선택하세요');
				return;
			}
			
			$('#joinForm').submit();
		});
	</script>
</body>
</html>