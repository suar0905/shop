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
	
	// 유효성 검사(null방지), 공백 방지 코드
	if(request.getParameter("ebookNo") == null || request.getParameter("ebookTitle") == null || request.getParameter("ebookNo").equals("") || request.getParameter("ebookTitle").equals("")) {
		System.out.println("[debug] ebookNo 또는 ebookTitle값이 null값이거나 공백값 입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/deleteEbookForm.jsp");
		return;
	}
	
	// selectEbookOne에서 ebookNo, ebookTitle을 가져옴
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	String ebookTitle = request.getParameter("ebookTitle");
	
	// 디버깅 코드
	System.out.println("[debug] ebookNo 확인 -> " + ebookNo);
	System.out.println("[debug] ebookTitle 확인 -> " + ebookTitle);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자책 삭제 페이지</title>
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
			<h4>'<%=ebookTitle%>' 전자책 삭제</h4>
		</div>
		
		<div>	
			<form action="<%=request.getContextPath()%>/admin/deleteEbookAction.jsp?ebookNo=<%=ebookNo%>&ebookTitle=<%=ebookTitle%>" method="post">
				<h2>● 해당 전자책을 정말로 삭제하시겠습니까?</h2>
				<div>
					<input class="btn btn-outline-danger" type="submit" value="삭제하기">
					<input class="btn btn-outline-danger" type="button" value="뒤로가기" onclick="history.back();">
				</div>
			</form>	
		</div>
	</div>
</body>
</html>