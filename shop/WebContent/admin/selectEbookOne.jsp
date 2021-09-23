<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<%
	// 한글 깨짐 방지(request값을 받을 때는 무조건 쓰기)
	request.setCharacterEncoding("utf-8");

	// (1) (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 유효성 검사(null방지) 코드
	if(request.getParameter("ebookNo") == null) {
		System.out.println("[debug] ebookNo값이 null값 입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
		return;
	}
	
	// 공백 방지 코드
	if(request.getParameter("ebookNo").equals("")) {
		System.out.println("[debug] ebookNo값이 공백값 입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
		return;
	}
		
	// selectEbookList에서 ebookNo를 가져옴
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	// 디버깅 코드
	System.out.println("[debug] ebookNo 확인 -> " + ebookNo);
	
	// (2) EbookDao 클래스 객체 생성 
	EbookDao ebookDao = new EbookDao();
	Ebook ebook = ebookDao.selectEbookOne(ebookNo);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자책 상세보기</title>
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
		<div>	
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/deleteEbookForm.jsp?ebookNo=<%=ebook.getEbookNo()%>&ebookTitle=<%=ebook.getEbookTitle()%>">삭제</a>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/updateEbookPriceForm.jsp?ebookNo=<%=ebook.getEbookNo()%>&ebookPrice=<%=ebook.getEbookPrice()%>">가격수정</a>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/updateEbookImgForm.jsp?ebookNo=<%=ebook.getEbookNo()%>">이미지수정</a>
			<input class="btn btn-dark" type="button" value="뒤로가기" onclick="history.back();">
		</div> 
	</div>	
</body>
</html>