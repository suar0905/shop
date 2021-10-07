<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<%
	// 한글 깨짐 방지(request값을 받을 때는 무조건 쓰기)
	request.setCharacterEncoding("utf-8");

	// (1) 로그인 하지 못한 사람은 페이지에 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 페이징
 	int currentPage = 1;
 	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[debug] currentPage 확인 -> " + currentPage);
	
	// 1페이지에 보여질 데이터 출력 수
	final int ROW_PER_PAGE = 10;
	
	// 데이터 시작 행
	int beginRow = (currentPage-1) * ROW_PER_PAGE;
	
	// 디버깅 코드
	System.out.println("[debug] memberNo 확인 -> " + loginMember.getMemberNo());
	
	// (2) OrderDao 클래스 객체 생성
	OrderDao orderDao = new OrderDao();
	
	// (3) OrderEbookMember 클래스 배열 객체 생성(해당 memberNo를 갖는 주문관리 페이지)
	ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(loginMember.getMemberNo(), beginRow, ROW_PER_PAGE);
	
	// (4) OrderCommentDao 클래스 객체 생성
	OrderCommentDao orderCommentDao = new OrderCommentDao();
%>	
<html>
<head>
<meta charset="UTF-8">
<title>나의 주문 목록</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<%
		// 로그인 하지 못했거나(비회원), 회원등급이 1미만일 때(회원) 
		if(loginMember == null || loginMember.getMemberLevel() < 1) {
	%>
			<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
			<div>
				<!-- 절대주소(기준점이 같음) -->
				<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
			</div>
			<!-- end : mainMenu include -->
	<% 		
		// 로그인 하였고, 회원등급이 0초과일 때(관리자)
		} else if(loginMember != null && loginMember.getMemberLevel() > 0) {
	%>
			<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
			<div>
			<!-- 절대주소(기준점이 같음) -->
				<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
			</div>
			<!-- end : mainMenu include -->
	<% 		
		}
	%>
	
	<div class="jumbotron">
		<h1>나의 주문목록 페이지</h1>
		<table class="table table-secondary table-bordered" border="1">
			<thead>
				<tr>
					<th>orderNo</th>
					<th>ebookTitle</th>
					<th>orderPrice</th>
					<th>createDate</th>
					<th>memberId</th>
					<th>상세주문내역</th>
					<th>ebook후기</th>
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
							<td><a class="btn btn-outline-dark" href="">상세주문내역</a></td>
							<% 
								// 후기가 없다면
								if(orderCommentDao.selectOrderEbookCommentCheck(oem.getOrder().getOrderNo(), oem.getEbook().getEbookNo()) == 0) {
							%>
									<td><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/insertOrderCommentForm.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>&ebookNo=<%=oem.getEbook().getEbookNo()%>">ebook후기</a></td>
							<% 		
								} else {
							%>		
									<td>후기작성 완료!</td>
							<% 				
								}
							%>
						</tr>
				<% 		
					}
				%>
			</tbody>
		</table>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp?currentPage=<%=currentPage-1%>">[이전]</a>
		<a class="btn btn-dark" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp?currentPage=<%=currentPage+1%>">[다음]</a>
	</div>
</body>
</html>