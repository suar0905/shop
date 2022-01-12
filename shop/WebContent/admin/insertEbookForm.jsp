<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import="java.util.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 관리자가 아닌 사람은 페이지 접근 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember.getMemberLevel() < 1) {
		System.out.println("당신은 관리자 계정이 아닙니다.");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자책 추가</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<div class="jumbotron">
		<h1>※ 전자책 추가</h1><br>
		<form action="<%=request.getContextPath()%>/admin/insertEbookAction.jsp" method="post" enctype="multipart/form-data">
			<table class="table table-bordered table-secondary" border="1">
				<tr>
					<th>전자책 핀번호</th>
					<td><input class="btn btn-light" type="text" name="ebookISBN"></td>
				</tr>
				<tr>
					<th>전자책 카테고리 이름</th>
					<td>
						<select class="form-control-sm" name="categoryName">
							<option value="경제">경제</option>
							<option value="만화">만화</option>
							<option value="소설">소설</option>
							<option value="여행">여행</option>
							<option value="외국어">외국어</option>
							<option value="컴퓨터">컴퓨터</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>전자책 제목</th>
					<td><input class="btn btn-light" type="text" name="ebookTitle"></td>
				</tr>
				<tr>
					<th>전자책 작가</th>
					<td><input class="btn btn-light" type="text" name="ebookAuthor"></td>
				</tr>
				<tr>
					<th>전자책 출판사</th>
					<td><input class="btn btn-light" type="text" name="ebookCompany"></td>
				</tr>
				<tr>
					<th>전자책 총페이지 수</th>
					<td><input class="btn btn-light" type="text" name="ebookPageCount"></td>
				</tr>
				<tr>
					<th>전자책 가격</th>
					<td><input class="btn btn-light" type="text" name="ebookPrice"></td>
				</tr>
				<tr>
					<th>전자책 이미지</th>
					<td><input class="btn btn-light" type="file" name="ebookImg"></td>
				</tr>
				<tr>
					<th>전자책 줄거리</th>
					<td><textarea class="form-control-lg" rows="5" cols="50" name="ebookSummary"></textarea></td>
				</tr>
				<tr>
					<th>전자책 상태</th>
					<td>
						<select class="form-control-sm" name="ebookState">
							<option value="판매중">판매중</option>
							<option value="품절">품절</option>
							<option value="절판">절판</option>
							<option value="구편절판">구편절판</option>
						</select>
					</td>
				</tr>
			</table><br>
			
			<div>
				<button class="btn btn-outline-dark" type="submit">추가하기</button>
				<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">전자책 목록</a>
			</div>
		</form>
	</div>
</body>
</html>