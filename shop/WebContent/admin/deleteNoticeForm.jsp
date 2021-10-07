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
	
	// selectNoticeOne에서 noticeNo값 가져옴
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	// 디버깅 코드
	System.out.println("[debug] noticeNo 확인 -> " + noticeNo);
	System.out.println("[debug] noticeTitle 확인 -> " + noticeTitle);
	System.out.println("[debug] noticeContent 확인 -> " + noticeContent);
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정 페이지</title>
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
	
	<div class="jumbotron">
	<h1>* 공지사항 삭제 *</h1>
	<form id="deleteForm" action="<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp" method="post">
		<div><input type="hidden" name="noticeNo" value="<%=noticeNo%>"></div>
		<table class="table table-secondary table-bordered" border="1">
			<tr>
				<th>noticeTitle</th>
				<td><input class="btn btn-outline-secondary" type="text" value="<%=noticeTitle%>" readonly="readonly"></td>
			</tr>
			<tr>
				<th>noticeContent</th>
				<td><textarea class="btn btn-outline-secondary" rows="5" cols="100" readonly="readonly"><%=noticeContent%></textarea></td>
			</tr>
			<tr>
				<th>memberNo</th>
				<td><input class="btn btn-outline-secondary" type="text" value="<%=memberNo%>" readonly="readonly"></td>
			</tr>
		</table>
		<h3>정말로 <%=noticeNo%>번 공지를 삭제하시겠습니까?</h3>
		<div>
			<input class="btn btn-dark" id="deleteBtn" type="button" value="삭제하기">
			<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
		</div>
	</form>
	</div>
	
	<script>
		// jQuery와 자바스크립트 이용하여 삭제
		$('#deleteBtn').click(function(){
			$('#deleteForm').submit();
		});
	</script>
</body>
</html>