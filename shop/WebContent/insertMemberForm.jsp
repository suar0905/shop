<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	// 인증 방어코드(로그인 전에만 열람 가능할 수 있도록)
	if(session.getAttribute("loginMember") != null) {
		System.out.println("[debug] 이미 로그인 되어있습니다.");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// memberIdCheck : memberId 중복 여부 확인 변수
	String memberIdCheck = "";
	if(request.getParameter("memberIdCheck") != null) {
		memberIdCheck = request.getParameter("memberIdCheck");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> <!-- jQuery 사용 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- 페이지 상단부분에 patial 폴더안의 mainMenu 내용 포함시키기 -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	
	<div class="jumbotron">
		<h2>* 회원가입 페이지 *</h2>
		
		<!-- 아이디(memberId) 중복 여부 확인하는 폼 -->
		<form action="<%=request.getContextPath()%>/selectMemberIdCheckAction.jsp" method="post">
			<div>
				중복아이디 검사 :
				<input type="text" name="memberIdCheck" placeholder="Enter Id">
				<input type="submit" value="중복아이디 검사">
				<input type="hidden" value="<%=request.getParameter("existId")%>">
			</div>
		</form>
		
		<!-- 회원 가입 폼 -->
		<form id="joinForm" action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
			<table class="table table-secondary table-bordered">
				<tr>
					<th>회원 아이디</th>
					<td><input class="btn btn-outline-secondary" type="text" id="memberId" name="memberId" value="<%=memberIdCheck%>" readonly="readonly" placeholder="Enter CheckId"></td>
				</tr>
				<tr>
					<th>회원 비밀번호</th>
					<td><input class="btn btn-outline-secondary" type="password" id="memberPw" name="memberPw" placeholder="Enter Pw"></td>
				</tr>
				<tr>
					<th>회원등급</th>
					<td><input type="text" id="memberLevel" name="memberLevel" value="0" readonly="readonly"></td>
				</tr>
				<tr>
					<th>회원 이름</th>
					<td><input class="btn btn-outline-secondary" type="text" id="memberName" name="memberName" placeholder="Enter Name"></td>
				</tr>
				<tr>
					<th>회원 나이</th>
					<td><input class="btn btn-outline-secondary" type="text" id="memberAge" name="memberAge" placeholder="Enter Age"></td>
				</tr>
				<tr>
					<th>회원 성별</th> 
					<td>	
						<input type="radio" class="memberGender" name="memberGender" value="남">남
						<input type="radio" class="memberGender" name="memberGender" value="여">여
					</td>	
				</tr>
			</table>	
			<br>
				<div>
					<input class="btn btn-dark" type="button" id="insertBtn" value="회원가입">
					<input class="btn btn-dark" type="reset" value="초기화">
					<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
				</div>
		</form>
	</div>
	
	<script>
		// 회원가입 폼 유효성 검사
		$('#insertBtn').click(function() {
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