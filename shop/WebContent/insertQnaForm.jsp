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
<title>QnA 게시물 작성하기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- 페이지 상단부분에 patial 폴더안의 mainMenu 내용 포함시키기 -->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	
	<div class="container">
		<div class="jumbotron" style="text-align:center;">
			<h4> QnA 게시물 작성 </h4>
		</div>
		<form id="insertForm" action="<%=request.getContextPath()%>/insertQnaAction.jsp" method="post">
			<input type="hidden" name="memberNo" value="<%=memberNo%>">
			
			<div class="form-group">
		    	<h4><label class="form-label mt-4">QnA 카테고리</label></h4>
		    	<select class="form-select btn btn-outline-secondary" name="qnaCategory">
		        	<option class="qnaCategory" value="개인정보관련">개인정보관련</option>
					<option class="qnaCategory" value="전자책관련">전자책관련</option>
					<option class="qnaCategory" value="주문관련">주문관련</option>
					<option class="qnaCategory" value="공지사항관련">공지사항관련</option>
					<option class="qnaCategory" value="기타">기타</option>
		      </select>
			</div>
			
			<div class="form-group">
		      <h4><label class="form-label mt-4">QnA 제목</label></h4>
		      <input class="form-control" style="text-align:left;" type="text" id="qnaTitle" name="qnaTitle" placeholder="제목 입력">
		    </div>
			
			<div class="form-group">
		      <h4><label class="form-label mt-4">QnA 내용</label></h4>
		      <textarea class="form-control" style="text-align:left;" id="qnaContent" name="qnaContent" rows="5" cols="100" placeholder="내용 입력"></textarea>
		    </div>
		    
		    <div class="form-group">
		      <h4><label class="form-label mt-4">QnA 비밀글 유무</label></h4>
		      <input type="radio" class="qnaSecret" name="qnaSecret" value="Y"> Y (개방글) <br>
			  <input type="radio" class="qnaSecret" name="qnaSecret" value="N"> N (비밀글)
		    </div>

			<br>
			<div>
				<input class="btn btn-dark" type="button" id="insertBtn" value="작성하기">
				<input class="btn btn-dark" type="reset" value="초기화">
				<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
			</div>
		</form>
	</div>
	
	
	<script>
		// $ = jquery, 유효성 검사
		$('#insertBtn').click(function(){ // insertBtn 버튼을 클릭 했을 때 함수를 실행시켜라.	
			if($('#qnaTitle').val() == '') {
				alert('제목을 입력하세요');
				return;
			}
			if($('#qnaContent').val() == '') {
				alert('내용을 입력하세요');
				return;
			}
			
			let qnaSecret = $('.qnaSecret:checked');
			if(qnaSecret.length == 0) {
				alert('비밀여부를 선택하세요');
				return;
			}
			
			$('#insertForm').submit();
		}); 
	</script>
</body>
</html>