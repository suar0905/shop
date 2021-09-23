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
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo")); 
	
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- start : mainMenu include - submenu.jsp의 내용을 가져온다. -->
	<div>
		<!-- 절대주소(기준점이 같음) -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<!-- application/x-www-form-urlencoded : 액션으로 문자열을 넘길때 사용한다.(기본적으로 사용(default값) -->
	<!-- enctype="multipart/form-data" : 액션으로 기계어코드(0,1)를 넘길때 사용한다. -->
	<form action="<%=request.getContextPath()%>/admin/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data"> 
		<input type="text" name="ebookNo" value="<%=ebookNo%>" readonly=readonly> 
		<input type="file" name="ebookImg">
		<input type="submit" value="이미지파일 수정">	
	</form>
</body>
</html>