<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<%
	// 한글 깨짐 방지(request값을 받을 때는 무조건 쓰기)
	request.setCharacterEncoding("utf-8");

	// (1)(로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
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
	
	// (2) Ebook 클래스 객체 생성
	Ebook ebook = new Ebook();
	
	// (3) EbookDao 클래스 객체 생성
	EbookDao ebookDao = new EbookDao();
	
	// (4) CategoryDao 클래스 객체 생성
	CategoryDao categoryDao = new CategoryDao();
		
	// (5) Category 클래스 배열 객체 생성
	ArrayList<Category> categoryList = new ArrayList<Category>();
	categoryList = categoryDao.selectCategoryListAllByPage(beginRow, Row_PER_PAGE);
	System.out.println("[debug] categoryList 확인 -> " + categoryList);
	
	// (6) Ebook 클래스 배열 객체 생성
	ArrayList<Ebook> ebookList = new ArrayList<Ebook>();
	
	// categoryName을 기준으로 검색 문제 해결
	String categoryName="";
	int selectCountNum = 0; // 검색어 유, 무 구분하기 위한 변수
	if(request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		ebookList = ebookDao.selectEbookList(beginRow, Row_PER_PAGE);
		selectCountNum = ebookDao.totalEbookCount();
	} else {
		categoryName = request.getParameter("categoryName");
		ebookList = ebookDao.selectEbookListByCategory(categoryName, beginRow, Row_PER_PAGE);
		selectCountNum = ebookDao.selectTotalEbookCount(categoryName);
	}
	System.out.println("[debug] categoryName 확인 -> " + categoryName);
		
	// 데이터의 총 개수()
	int totalCount = ebookDao.totalEbookCount();
	
	// 마지막 페이지
	int lastPage = totalCount / Row_PER_PAGE;
	if(totalCount % Row_PER_PAGE != 0) {
		lastPage = lastPage + 1;
	}
	System.out.println("[debug] lastPage 확인 -> " + lastPage);
	
	// 화면에 보여질 페이지 번호의 개수([1], [2], [3] ... [10])
	int displayPage = 10;
	
	// 화면에 보여질 시작 페이지 번호
	// ((현재페이지번호 - 1) / 화면에 보여질 페이지 번호) * 화면에 보여질 페이지번호 + 1;
	// (currentPage - 1)을 하는 이유는 현재페이지가 10일시에도 startPage가 1이기 위해
	int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
	System.out.println("[debug] startPage 확인 -> " + startPage);
	
	// 화면에 보여질 끝 페이지 번호
	// 화면에 보여질 시작 페이지 번호 + 화면에 보여질 페이지 번호 - 1
	// -1을 하는 이유: 페이지 번호의 개수가 10개이기 때문에 startPage에서 더한 1을 빼준다.
	int endPage = startPage + displayPage - 1;
	System.out.println("[debug] endPage 확인 -> " + endPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자책 관리 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
			<h4> 전자책 관리 페이지 </h4>
		</div>
		
		<div>
			<form action="<%=request.getContextPath()%>/admin/selectEbookList.jsp" method="post">
				<select name="categoryName">
					<%
						if(categoryName==""){
					%>
							<option value="" selected>전체목록</option>
					<%
						} else{
					%>
							<option value="">전체목록</option>
					<%
						}
					%>
					<%
						for(Category c : categoryList){
							if(categoryName.equals(c.getCategoryName())){
					%>
								<option value="<%=c.getCategoryName() %>" selected><%=c.getCategoryName() %></option>
					<%
							} else{
					%>
								<option value="<%=c.getCategoryName() %>"><%=c.getCategoryName() %></option>
					<%
							}
					%>
					<%	
						}
					%>
				</select>
				<input class="btn btn-outline-dark" type="submit" value="출력하기">
				<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/admin/insertEbookForm.jsp">추가하기</a>
			</form>
			
			<!-- 전자책 목록 출력 : 카테코리별 출력 -->
			<form action="<%=request.getContextPath()%>/admin/selectEbookList.jsp" method="post">
			<table class="table table-secondary table-bordered" style="text-align:center;" border="1">
				<thead>
					<tr>	
						<th>전자책 번호</th>
						<th>카테고리 이름</th>
						<th>전자책 제목</th>
						<th>전자책 상태</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Ebook e : ebookList) {
					%>
							<tr>
								<td><%=e.getEbookNo()%></td>
								<td><%=e.getCategoryName()%></td>
								<td><a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></td>
								<td><%=e.getEbookState()%></td>
							</tr>	
					<% 		
						}
					%>
				</tbody>
			</table>
			</form>
				<div class="text-center">
				<%
					// (1)에서 생성한 loginMember변수 사용
					// [처음으로(<<)] 버튼
				%>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=1&categoryName=<%=categoryName%>">[처음으로]</a>
				<%
					// [이전(<)] 버튼
					// 화면에 보여질 시작 페이지 번호가 화면에 보여질 페이지 번호의 개수보다 크다면 이전 버튼을 생성
					if(startPage > displayPage) {
				%>
						<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=startPage-displayPage%>&categoryName=<%=categoryName%>">[이전]</a>
				<% 		
					}
				
					// 페이지 번호[1,2,3..9] 버튼
					for(int i=startPage; i<=endPage; i++) {
						System.out.println("[debug] 만들어지는 페이지 수 -> " + i);
				%>
						<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&categoryName=<%=categoryName%>">[<%=i%>]</a>
				<% 		
					}
					
					// [다음(>)] 버튼
					// 화면에 보여질 마지막 페이지 번호가 마지막 페이지 보다 작아지면 이전 버튼을 생성
					if(endPage < lastPage) {
				%>
						<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">[다음]</a>
				<% 		
					}
					
					// [끝으로(>>)] 버튼
				%>	
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=lastPage%>&categoryName=<%=categoryName%>">[끝으로]</a>
				</div>	
			</div>
	</div>
</body>
</html>