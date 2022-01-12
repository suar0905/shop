<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// (1) Member클래스 객체 생성, (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("[debug] 로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// categoryNameCheck : categoryName 중복 여부 확인 변수
	String categoryNameCheck = "";
	if(request.getParameter("categoryNameCheck") != null) {
		categoryNameCheck = request.getParameter("categoryNameCheck");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 추가 페이지</title>
</head>
<body>
	<!-- 페이지 상단부분에 patial 폴더안의 adminMenu 내용 포함시키기 -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	
	<div class="container"> 
		<div class="jumbotron" style="text-align:center;">
		<h4>카테고리 추가 페이지</h4>
		</div>
		
		<div>
			<!-- 카테고리이름(categoryName) 중복여부 확인하는 폼 -->
			<form action="<%=request.getContextPath()%>/admin/selectCategoryNameCheckAction.jsp" method="post">
				<div>
					중복 카테고리이름 검사 :
					<input class="btn btn-light" type="text" name="categoryNameCheck" placeholder="Enter Name">
					<input class="btn btn-outline-dark" type="submit" value="중복 카테고리이름 검사하기">
					<input type="hidden" value="<%=request.getParameter("existName")%>"> 
				</div>
			</form>
			
			<!-- 카테고리 추가 폼 -->
			<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
				<table class="table table-secondary table-bordered" border="1">
					<tr>
						<th>카테고리 이름</th>
						<td><input class="btn btn-outline-secondary" type="text" name="categoryName" value="<%=categoryNameCheck%>" readonly="readonly" placeholder="Enter checkName"></td>
					</tr>
					<tr>
						<th>카테고리 상태</th>
						<td>
							<select name="categoryState">
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</td>
					</tr>
				</table>
				<br>
				<div>
					<input class="btn btn-dark" type="submit" value="추가하기">
					<input class="btn btn-dark" type="reset" value="초기화">
					<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
				</div>
			</form>
		</div>
	</div>
</body>
</html>