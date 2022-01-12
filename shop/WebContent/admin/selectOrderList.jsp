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
	
	// OrderDao 클래스 객체 생성
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderList(beginRow, Row_PER_PAGE);
	
	// 데이터의 총 개수()
	int totalCount = orderDao.totalOrderCount();
	
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
<title>주문관리 페이지</title>
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
			<h4> 회원 주문관리 페이지 </h4>
		</div>
		
		<div>
			<table class="table table-secondary table-bordered" style="text-align:center;" border="1">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>전자책 제목</th>
						<th>전자책 가격</th>
						<th>주문일자</th>
						<th>구매아이디</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(OrderEbookMember oem : list) {
					%>
							<tr>
								<td><%=oem.getOrder().getOrderNo()%></td>
								<td><%=oem.getEbook().getEbookTitle()%></td>
								<td><%=oem.getOrder().getOrderPrice()%></td>
								<td><%=oem.getOrder().getCrateDate()%></td>
								<td><%=oem.getMember().getMemberId()%></td>
							</tr>
					<% 		
						}
					%>
				</tbody>
			</table>
			<div class="text-center">
			<%
				// (1)에서 생성한 loginMember변수 사용
				// [처음으로(<<)] 버튼
			%>
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=1">[처음으로]</a>
			<%
				// [이전(<)] 버튼
				// 화면에 보여질 시작 페이지 번호가 화면에 보여질 페이지 번호의 개수보다 크다면 이전 버튼을 생성
				if(startPage > displayPage) {
			%>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=startPage-displayPage%>">[이전]</a>
			<% 		
				}
			
				// 페이지 번호[1,2,3..9] 버튼
				for(int i=startPage; i<=endPage; i++) {
					System.out.println("[debug] 만들어지는 페이지 수 -> " + i);
			%>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=i%>">[<%=i%>]</a>
			<% 		
				}
				
				// [다음(>)] 버튼
				// 화면에 보여질 마지막 페이지 번호가 마지막 페이지 보다 작아지면 이전 버튼을 생성
				if(endPage < lastPage) {
			%>
					<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
			<% 		
				}
				
				// [끝으로(>>)] 버튼
			%>	
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=lastPage%>">[끝으로]</a>
			</div>
		</div>
	</div>
</body>
</html>