<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 유효성 검사(null 방지)
	if(request.getParameter("ebookNo") == null) {
		System.out.println("[debug] ebookNo값은 null값 입니다.");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 공백 방지
	if(request.getParameter("ebookNo").equals("")) {
		System.out.println("[debug] ebookNo값은 공백값 입니다.");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	System.out.println("[debug] ebookNo 확인 -> " + ebookNo);
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 디버깅 코드
	System.out.println("[debug] currentPage 확인 -> " + currentPage);
	
	// 목록 데이터 보여질 행의 수(final -> 바뀔 수 없음)
	final int ROW_PER_PAGE = 10;
	
	// 목록 데이터 시작 행
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세보기(주문가능)</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<!-- 상품을 상세하게 보면서 주문할 수 있는 페이지 -->
	<div class="jumbotron">
		<div>
			<!-- 상품상세출력 -->
			<%
				// (1) EbookDao 클래스 객체 생성
				EbookDao ebookDao = new EbookDao();
			
				// (2) Ebook 클래스 변수 생성(selectEbookOne)
				Ebook ebook = ebookDao.selectEbookOne(ebookNo);
			%>
			<div>
				<h2>* <%=ebook.getEbookNo()%>번 '<%=ebook.getEbookTitle()%>' 전자책 상세보기 *</h2>
			</div>
			<table class="table table-secondary table-bordered" border="1">
				<tr>
					<th>categoryName</th>
					<td><%=ebook.getCategoryName()%></td>
				</tr>
				<tr>
					<th>ebookAuthor</th>
					<td><%=ebook.getEbookAuthor()%></td>
				</tr>
				<tr>
					<th>ebookCompany</th>
					<td><%=ebook.getEbookCompany()%></td>
				</tr>
				<tr>
					<th>ebookPageCount</th>
					<td><%=ebook.getEbookPageCount()%></td>
				</tr>
				<tr>
					<th>ebookPrice</th>
					<td><%=ebook.getEbookPrice()%></td>
				</tr>
				<tr>
					<th>ebookCompany</th>
					<td><img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg()%>"></td>
				</tr>
				<tr>
					<th>ebookSummary</th>
					<td><%=ebook.getEbookSummary()%></td>
				</tr>
				<tr>
					<th>ebookState</th>
					<td><%=ebook.getEbookState()%></td>
				</tr>
				<tr>
					<th>createDate</th>
					<td><%=ebook.getCreateDate()%></td>
				</tr>
				<tr>
					<th>updateDate</th>
					<td><%=ebook.getUpdateDate()%></td>
				</tr>
			</table>	
		</div>
		<!-- 주문 입력하는 폼 -->
		<%
			// (3) Member 클래스 변수 생성
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(loginMember == null) {
		%>
				<div>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/loginForm.jsp">로그인 후 주문하기</a>
					<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
				</div>
		<% 		
			} else {
		%>	
				<form action="<%=request.getContextPath()%>/insertOrderAction.jsp" method="post">
					<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
					<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
					<input type="hidden" name="orderPrice" value="<%=ebook.getEbookPrice()%>">
					<input class="btn btn-dark" type="submit" value="주문하기">
					<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
				</form>
		<%
			}
		%>	
	</div>

	<div class="jumbotron">
		<!-- 해당 상품의 별점 평균 -->
		<div>
			<%
				// (3) OrderCommentDao 클래스 객체 생성
				OrderCommentDao orderCommentDao = new OrderCommentDao();
				double avgScore = orderCommentDao.selectOrderScoreAvg(ebookNo);
				int totalCount = orderCommentDao.totalOrderComment(ebookNo);
			%>
			<h2>* 총 <%=totalCount%>개의 구매 후기 *</h2>
			<h3>별점 평균 : <%=avgScore%></h3>
		</div>
		<!-- 해당 상품의 후기 -->
		<div>
			<%
				// (4) OrderComment 클래스 배열 변수 생성(selectOrderEbookComment메소드 이용)
				ArrayList<OrderComment> list = orderCommentDao.selectOrderEbookComment(ebookNo, beginRow, ROW_PER_PAGE);
			%>
			<table class="table table-secondary border="1">
				<thead>
					<tr>
						<th>별점</th>
						<th>후기</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(OrderComment oc : list) {
					%>
							<tr>
								<td><%=oc.getOrderScore()%>점</td>
								<td><%=oc.getOrderCommentContent()%></td>
							</tr>
					<% 		
						}
					%>
				</tbody>
			</table>	
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=currentPage-1%>">[이전]</a>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
		</div>
	</div>
</body>
</html>