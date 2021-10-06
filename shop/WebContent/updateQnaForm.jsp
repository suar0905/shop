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
	if(request.getParameter("qnaNo") == null || request.getParameter("memberNo") == null) {
		System.out.println("[debug] qnaNo, memberNo값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return; 
	}
	
	// 공백 방지
	if(request.getParameter("qnaNo").equals("") || request.getParameter("memberNo").equals("")) {
		System.out.println("[debug] qnaNo, memberNo값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
		
	// selectQnaOne에서 qnaNo값, memberNo값 가져옴
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	System.out.println("[debug] qnaNo 확인 -> " + qnaNo);
	System.out.println("[debug] memberNo 확인 -> " + memberNo);	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 수정 페이지</title>
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
	<h1>* <%=memberNo%>번 회원의 <%=qnaNo%>번 QnA 게시글 수정 *</h1>
	<form id="updateForm" action="<%=request.getContextPath()%>/updateQnaAction.jsp" method="post">
		<input type="hidden" name="qnaNo" value=<%=qnaNo%>>
		<input type="hidden" name="memberNo" value=<%=memberNo%>>
		<table class="table table-secondary table-bordered" border="1">
			<tr>
				<th>qnaCategory</th>
				<td>
					<select class="btn btn-outline-secondary" name="qnaCategory" >
						<option class="qnaCategory" value="개인정보관련">개인정보관련</option>
						<option class="qnaCategory" value="전자책관련">전자책관련</option>
						<option class="qnaCategory" value="주문관련">주문관련</option>
						<option class="qnaCategory" value="공지사항관련">공지사항관련</option>
						<option class="qnaCategory" value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>qnaSecret</th>
				<td>
					<input type="radio" class="qnaSecret" name="qnaSecret" value="Y">Y (개방글)
					<input type="radio" class="qnaSecret" name="qnaSecret" value="N">N (비밀글)
				</td>
			</tr>
			<tr>
				<th>qnaTitle</th>
				<td><input class="btn btn-outline-secondary" type="text" id="qnaTitle" name="qnaTitle" placeholder="qnaTitle 입력"></td>
			</tr>
			<tr>
				<th>qnaContent</th>
				<td><textarea class="btn btn-outline-secondary" id="qnaContent" name="qnaContent" rows="5" cols="100" placeholder="qnaContent 입력"></textarea></td>
			</tr>
		</table>
		<div>
			<input class="btn btn-dark" id="updateBtn" type="button" value="수정하기">
			<input class="btn btn-dark" type="reset" value="초기화">
			<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
		</div>
	</form>
	</div>
	
	<script>
		// $ = jquery, 유효성 검사
		$('#updateBtn').click(function(){ // updateBtn 버튼을 클릭 했을 때 함수를 실행시켜라.	
			let qnaCategory = $('.qnaCategory:checked');
			if(qnaCategory.length == 0) {
				alert('qnaCategory를 선택하세요');
				return;
			}
			
			let qnaSecret = $('.qnaSecret:checked');
			if(qnaSecret.length == 0) {
				alert('qnaSecret를 선택하세요');
				return;
			}
			
			if($('#qnaTitle').val() == '') {
				alert('qnaTitle를 입력하세요');
				return;
			}
			if($('#qnaContent').val() == '') {
				alert('qnaContent를 입력하세요');
				return;
			}
			
			$('#updateForm').submit();
		}); 
	</script>
</body>
</html>