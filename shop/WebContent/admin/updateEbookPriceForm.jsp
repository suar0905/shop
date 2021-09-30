<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
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
	
	// 유효성 검사(null방지) 코드
	if(request.getParameter("ebookNo") == null || request.getParameter("ebookPrice") == null) {
		System.out.println("[debug] ebookNo 또는 ebookPrice값이 null값 입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookOne.jsp");
		return;
	}
	
	// 공백 방지 코드
	if(request.getParameter("ebookNo").equals("") || request.getParameter("ebookPrice").equals("")) {
		System.out.println("[debug] ebookNo 또는 ebookPrice값이 공백값 입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookOne.jsp");
		return;
	}
	
	// selectEbookOne에서 ebookNo, ebookPrice를 가져옴
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	
	// 디버깅 코드
	System.out.println("[debug] ebookNo 확인 -> " + ebookNo);
	System.out.println("[debug] ebookPrice 확인 -> " + ebookPrice);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자책 가격수정 페이지</title>
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
	<h2>전자책 가격수정</h2>
	<form action="<%=request.getContextPath()%>/admin/updateEbookPriceAction.jsp" method="post">
		<div>
			수정할 전자책 번호 :
			<input class="btn btn-outline-dark" type="text" name="ebookNo" value="<%=ebookNo%>" readonly="readonly">
		</div>
		<div>
			현재 전자책 가격 :
			<input class="btn btn-outline-dark" type="text" value="<%=ebookPrice%>" readonly="readonly">
		</div>
		<div>
			수정할 전자책 가격 :
			<input class="btn btn-outline-dark" type="text" name="ebookNewPrice" placeholder="Enter ebookNewPrice">
		</div>
		<div>
			<input class="btn btn-dark" type="submit" value="수정하기">
			<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
		</div>
	</form>	
	</div>
</body>
</html>