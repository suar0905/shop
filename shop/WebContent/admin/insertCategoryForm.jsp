<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8"); 

	//* 인증 방어 코드 * 
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
<title>카테고리 추가 페이지</title>
</head>
<body>
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<div>
	<%
		// categoryNameCheck : 카테고리 이름 중복확인 값
		String categoryNameCheck = "";
		if(request.getParameter("categoryNameCheck") != null) {
			categoryNameCheck = request.getParameter("categoryNameCheck");
		}		
	%>
	
	<!-- selectMemberIdCheckAction에서 idCheckResult값 가져옴 -->
	<div><input type="hidden" value="<%=request.getParameter("NameCheckResult")%>"></div>
	
	<!-- (1) 카테고리 이름(categoryName)을 사용가능한지 확인하는 폼 -->
	<form class="talbe table-info table-striped" action="<%=request.getContextPath()%>/admin/selectCategoryNameCheckAction.jsp" method="post">
		<div>
			중복카테고리 이름 검사 :
			<input type="text" name="categoryNameCheck">
			<input class="btn btn-dark" type="submit" value="중복카테고리 이름 검사">
		</div>
	</form>
	
	<!-- (2) 카테고리 추가할 때 사용하는 폼 -->	
	<h1>카테고리 추가 페이지</h1>
	<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
		<table border="1">
			<!-- categoryName -->
			<tr>
				<th>카테고리 이름 : </th>
				<td><input type="text" name="categoryName" readonly="readonly" value="<%=categoryNameCheck%>"></td>
			</tr>
			<!-- categoryState -->
			<tr>
				<th>카테고리 사용유무 : </th>
				<td>
					<input type="radio" name="categoryState" value="Y">사용
					<input type="radio" name="categoryState" value="N">미사용
				</td>
			</tr>			
		</table>
		<br>
		<div>
			<input class="btn btn-dark" type="submit" value="카테고리 추가하기">
			<input class="btn btn-dark" type="reset" value="초기화">
			<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
		</div>
	</form>
	</div>
</body>
</html>