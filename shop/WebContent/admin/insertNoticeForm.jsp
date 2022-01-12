<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8"); 

	// * 인증 방어 코드 * 
	// (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 추가 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> <!-- jQuery 사용 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- bootstrap 사용 -->
</head>
<body>
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	<div class="container"> 
		<div class="jumbotron" style="text-align:center;">
			<h4> 공지사항 추가 </h4>
		</div>
		
		<div>
			<form id="insertForm" action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
				<input class="btn btn-outline-secondary" type="hidden" id="memberNo" name="memberNo" value="<%=loginMember.getMemberNo()%>">
				<table class="table table-secondary table-bordered" border="1">
					<tr>
						<th>공지사항 제목</th>
						<td><input class="btn btn-outline-secondary" type="text" id="noticeTitle" name="noticeTitle" placeholder="Enter Title"></td>
					</tr>
					<tr>
						<th>공지사항 내용</th>
						<td><textarea class="btn btn-outline-secondary" id="noticeContent" name="noticeContent" rows="5" cols="100" placeholder="Enter Content"></textarea></td>
					</tr>
				</table>
				<div>
					<input class="btn btn-dark" id="insertBtn" type="button" value="추가하기">
					<input class="btn btn-dark" type="reset" value="초기화">
					<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
				</div>
			</form>
		</div>
	</div>
	
	<script>
		// jQuery와 자바스크립트 이용하여 유효성 검사
		$('#insertBtn').click(function(){
			if($('#noticeTitle').val() == ''){
				alert('noticeTitle을 입력하세요');
				return;
			} else if($('#noticeContent').val() == ''){
				alert('noticeContent를 입력하세요');
				return;
			} else if($('#memberNo').val() == ''){
				alert('memberNo를 입력하세요');
				return;
			} else{
				$('#insertForm').submit();
			}
		});
	</script>
</body>
</html>