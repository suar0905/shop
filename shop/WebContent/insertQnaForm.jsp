<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 유효성 검사(null 방지)
	if(request.getParameter("memberNo") == null) {
		System.out.println("[debug] memberNo값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	// 공백 방지
	if(request.getParameter("memberNo").equals("")) {
		System.out.println("[debug] memberNo값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
		return;
	}
	
	// selectQnaList에서 memberNo값 가져오기
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	System.out.println("[debug] memberNo값 확인 -> " + memberNo);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 게시물 추가하기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- 페이지 상단부분에 patial 폴더안의 mainMenu 내용 포함시키기 -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>

	<div class="jumbotron">
		<h1>* QnA 게시물 추가페이지 *</h1>
		<form id="insertForm" action="<%=request.getContextPath()%>/insertQnaAction.jsp" method="post">
			<div>
				QnA 카테고리 :
				<select class="btn btn-outline-secondary" name="qnaCategory" >
					<option class="qnaCategory" value="개인정보관련">개인정보관련</option>
					<option class="qnaCategory" value="전자책관련">전자책관련</option>
					<option class="qnaCategory" value="주문관련">주문관련</option>
					<option class="qnaCategory" value="공지사항관련">공지사항관련</option>
					<option class="qnaCategory" value="기타">기타</option>
				</select>
			</div>
			<div>
				QnA 제목 : 
				<input class="btn btn-outline-secondary" type="text" id="qnaTitle" name="qnaTitle" placeholder="qnaTitle 입력">
			</div>
			<div>
				QnA 내용 :
				<textarea class="btn btn-outline-secondary" id="qnaContent" name="qnaContent" rows="5" cols="100" placeholder="qnaContent 입력"></textarea>
			</div>
			<div>
				QnA 비밀글 유무 :
				<input type="radio" class="qnaSecret" name="qnaSecret" value="Y">Y (개방글)
				<input type="radio" class="qnaSecret" name="qnaSecret" value="N">N (비밀글)
			</div>
			<input type="hidden" name="memberNo" value="<%=memberNo%>">
			<br>
			<div>
				<input class="btn btn-dark" type="button" id="insertBtn" value="추가하기">
				<input class="btn btn-dark" type="reset" value="초기화">
				<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
			</div>
		</form>
	</div>
	
	<script>
		// $ = jquery, 유효성 검사
		$('#insertBtn').click(function(){ // insertBtn 버튼을 클릭 했을 때 함수를 실행시켜라.	
			let qnaCategory = $('.qnaCategory:checked');
			if(qnaCategory.length == 0) {
				alert('qnaCategory를 선택하세요');
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
			
			let qnaSecret = $('.qnaSecret:checked');
			if(qnaSecret.length == 0) {
				alert('qnaSecret를 선택하세요');
				return;
			}
			
			$('#insertForm').submit();
		}); 
	</script>
</body>
</html>