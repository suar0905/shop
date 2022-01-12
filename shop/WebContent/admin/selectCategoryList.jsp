<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// (1) Member클래스 객체 생성, (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("[debug] 로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 데이터 출력 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 디버깅 코드
	System.out.println("[debug] currentPage 확인 -> " + currentPage);
	
	// 카테고리 목록 보여질 데이터 행의 수
	final int ROW_PER_PAGE = 10;
	
	// 카테고리 목록 데이터 시작 행
 	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
	// (2) CategoryDao 클래스 객체 생성
	CategoryDao categoryDao = new CategoryDao();
	
	// (3) Category 클래스 배열 객체 생성(selectCategoryListAllByPage 메소드 이용)
	ArrayList<Category> categoryList = new ArrayList<Category>();
	categoryList = categoryDao.selectCategoryListAllByPage(beginRow, ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 목록 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- 페이지 상단부분에 patial 폴더안의 adminMenu 내용 포함시키기 -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	
	<div class="container"> 
		<div class="jumbotron" style="text-align:center;">
			<h4> 전자책 카테고리 관리 페이지 </h4>
		</div>
		
		<div>
			<div style="text-align:right;">
				<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가하기</a>
			</div>
			<table class="table table-secondary table-bordered" style="text-align:center;" border="1">
				<thead>
					<tr>
						<th>카테고리 이름</th>
						<th>카테고리 상태</th>
						<th>수정일</th>
						<th>생성일</th>
						<th>카테고리 사용유무</th>
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
									<select name="categoryState">
									<!-- 해당 카테고리 상태값이 카테고리 상태유무 기본값으로 지정되게 표시 설정 -->
									<%
										if(c.getCategoryState().equals("Y")) {
									%>
											<option value="Y" selected="selected">Y</option>
											<option value="N">N</option>
									<% 		
										} else {
									%>
											<option value="Y">Y</option>
											<option value="N" selected="selected">N</option>
									<% 		
										}
									%>
									</select>
									<input class="btn btn-outline-dark" type="submit" value="수정하기">
								</form>
							</td>
						</tr>
					<% 		
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>