<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	// 유효성 검사(null 방지)
	if(request.getParameter("orderNo") == null || request.getParameter("ebookNo") == null) {
		System.out.println("[debug] orderNo 또는 ebookNo 값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectOrderListByMember.jsp");
		return;
	}
	
	// 공백 방지
	if(request.getParameter("orderNo").equals("") || request.getParameter("ebookNo").equals("")) {
		System.out.println("[debug] orderNo 또는 ebookNo 값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectOrderListByMember.jsp");
		return;
	}
	
	// selectOrderListByMember에서 orderNo, ebookNo 가져옴
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	System.out.println("[debug] orderNo 확인 -> " + orderNo);
	System.out.println("[debug] ebookNo 확인 -> " + ebookNo);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자책 후기 페이지</title>
</head>
<body>
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<!-- 전자책 후기 작성 -->
	<div class="jumbotron">
		<h1><%=orderNo%>번 주문번호의 <%=ebookNo%>번 전자책 후기 작성</h1>
		<form action="<%=request.getContextPath()%>/insertOrderCommentAction.jsp" method="post">
		<table class="table table-secondary table-bordered" border="1">
			<tr>
				<!-- 주문 번호 -->
				<input type="text" hidden="hidden" name="orderNo" value=<%=orderNo%> readonly="readonly"> 
			</tr>
			<tr>
				<!-- 전자책 상품 번호 -->
				<input type="text" hidden="hidden" name="ebookNo" value=<%=ebookNo%> readonly="readonly"> 
			</tr>
			<tr>
				<th>전자책 상품 별점</th>
				<td>
					<select name="orderScore">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
						<option value="9">9</option>
						<option value="10">10</option>
					</select>
				</td>	
			</tr>
			<tr>
				<th>전자책 상품 내용</th>
				<td><textarea name="orderCommentContent" rows="5" cols="80" placeholder="Enter Comment"></textarea></td>
			</tr>
		</table>
			<div>
				<input class="btn btn-dark" type="submit" value="작성하기">
				<input class="btn btn-dark" type="reset" value="초기화">
				<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
			</div>
		</form>
	</div>
</body>
</html>