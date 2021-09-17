<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 관리자 페이지와 관련된 곳에 들어갈 메뉴 -->
<div class="container-fluid">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<ul class="navbar-nav">
		<!-- 회원 관리 : 회원목록 보기, 회원등급 수정, 회원비밀번호 수정, 회원강제 탈퇴 -->
	    <li class="nav-item active">
	      <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">[회원관리]</a>
	    </li>
	    <!-- 전자책 카테고리 관리 : 목록, 추가, 사용유무 수정 ... 페이징X 
	    	1) Category.class 
	    	2) CategoryDao.class
	    	3) selectCategoryList.jsp (페이징X) 
	    	4) insertCategoryForm.jsp 
	    	5) insertCategoryAction.jsp 
	    	6) selectCategoryNameCheckAction.jsp 
	        7) updateCategoryStateAction.jsp -? selectCategoryList.jsp에서 바로 실행될 수 있도록
	    -->
	    <li class="nav-item active">
	      <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp">[전자책 카테고리 관리]</a>
	    </li>
	    <!-- 전자책 관리 : 목록, 추가(이미지 추가), 수정, 삭제 -->
	    <li class="nav-item active">
	      <a class="navbar-brand" href="<%=request.getContextPath()%>">[전자책 관리]</a>
	    </li>
	    <li class="nav-item active">
	      <a class="navbar-brand" href="<%=request.getContextPath()%>">[주문 관리]</a>
	    </li>
	    <li class="nav-item active">
	      <a class="navbar-brand" href="<%=request.getContextPath()%>">[상품명 관리]</a>
	    </li>
	    <li class="nav-item active">
	      <a class="navbar-brand" href="<%=request.getContextPath()%>">[공지게시판 관리]</a>
	    </li>
	    <li class="nav-item active">
	      <a class="navbar-brand" href="<%=request.getContextPath()%>">[QnA게시판 관리]</a>
	    </li>
	 </ul>	
	<a class="btn btn-outline-success" href="<%=request.getContextPath()%>/logOut.jsp">로그아웃</a>
	</nav>
</div>