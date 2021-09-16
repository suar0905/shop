<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 관리자 페이지와 관련된 곳에 들어갈 메뉴 -->
<div>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">[회원관리]</a>
		<li><a href="<%=request.getContextPath()%>">[전자책 카테고리 관리]</a>
		<li><a href="<%=request.getContextPath()%>">[전자책 관리]</a>
		<li><a href="<%=request.getContextPath()%>">[주문 관리]</a>
		<li><a href="<%=request.getContextPath()%>">[상품명 관리]</a>
		<li><a href="<%=request.getContextPath()%>">[공지게시판 관리]</a>
		<li><a href="<%=request.getContextPath()%>">[QnA게시판 관리]</a>		
	</ul>
	<a href="<%=request.getContextPath()%>/logOut.jsp">로그아웃</a>
</div>