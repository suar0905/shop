<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<%
	// 한글 깨짐 방지(request값을 받을 때는 무조건 쓰기)
	request.setCharacterEncoding("utf-8");

	// (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 디버깅 코드
	System.out.println("[debug] currentPage 확인 -> " + currentPage);
	
	// 목록 데이터 보여질 행의 수(final -> 바뀔 수 없음)
	final int Row_PER_PAGE = 10;
	
	// 목록 데이터 시작 행
	int beginRow = (currentPage - 1) * Row_PER_PAGE;
	
	// (1) CategoryDao 클래스 객체 생성
	CategoryDao categoryDao = new CategoryDao();
	
	ArrayList<Category> categoryList = null;
	categoryList = categoryDao.selectCategoryListAllByPage(beginRow, Row_PER_PAGE);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 목록 페이지(페이징X)</title>
</head>
<body>
	<div class="container-fluid">

	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<h1>카테고리 목록</h1>
	<div>
		<a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가하기</a>
	</div>
	<br>
	<table class="talbe table-info table-striped" border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>categoryState</th>
				<th>updateDate</th>
				<th>createDate</th>
				<th>카테고리 사용유무</th>				
				<th></th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Category c : categoryList) {
			%>
				<tr>
					<td><%=c.getCategoryName()%></td>
					<td><%=c.getCategoryState()%></td>
					<td><%=c.getUpdateDate()%></td>
					<td><%=c.getCreateDate()%></td>
					<td>
						<form action="<%=request.getContextPath()%>/admin/updateCategoryStateAction.jsp?categoryName=<%=c.getCategoryName()%>" method="post">
							<!-- 카테고리 사용 유무를 수정한다. -->
							<select name="categoryState">
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
							<input type="submit" value="선택">
						</form>
					</td>
				</tr>
			<%      
            	}
         	%>
         </tbody>
	</table>
	</div>	
</body>
</html>