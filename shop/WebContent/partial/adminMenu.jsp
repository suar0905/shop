<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- 관리자 페이지와 관련된 곳에 들어갈 메뉴 -->
<div class="container">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<div class="col-sm-10">
			<ul class="navbar-nav">
				<li class="nav-item active">
					<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">[홈으로]</a>
				</li>
			    <li class="nav-item active">
			      <a class="navbar-brand" href="<%=request.getContextPath()%>/selectNoticeOne.jsp">[공지사항게시판]</a>
			    </li>
			    <li class="nav-item active">
			      <a class="navbar-brand" href="<%=request.getContextPath()%>/selectQnaList.jsp">[QnA게시판]</a>
			    </li>
			 </ul>	
		</div>
		<div class="col-sm-2">
			<div class="dropdown" style="text-align:right;">
				<button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
			    	<%
						// Member 클래스 변수 생성(로그인 기록정보 저장)
						Member loginMember = (Member)session.getAttribute("loginMember");
					
						// 로그인 전(session 영역안에 null값이면)
						if(loginMember.getMemberLevel() == 1) {
					%>
							<%=loginMember.getMemberName()%>님
					<% 		
						}
					%>
			  	</button>
			  	<div class="dropdown-menu" style="text-align:center;">
			    	<a class="dropdown-item" href="<%=request.getContextPath()%>/logOut.jsp">로그아웃</a>
			    	<a class="dropdown-item" href="<%=request.getContextPath()%>/selectMemberInfo.jsp">회원정보</a>
			    	<a class="dropdown-item" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp">나의 주문목록</a>
			  	</div>
			</div>
		</div>
	</nav>
	<ul class="nav nav-tabs nav-justified">
	  <!-- 회원 관리 : 회원목록 보기, 회원등급 수정, 회원비밀번호 수정, 회원강제 탈퇴 -->
	  <li class="nav-item">
	    <a class="nav-link active" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp">[회원관리]</a>
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
	  <li class="nav-item">
	    <a class="nav-link active" href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp">[전자책 카테고리 관리]</a>
	  </li>
	  <!-- 전자책 관리 : 목록, 추가(이미지 추가), 수정, 삭제 -->
	  <li class="nav-item">
	    <a class="nav-link active" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp">[전자책 관리]</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link active" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp">[주문 관리]</a>
	  </li>
	</ul>
</div>