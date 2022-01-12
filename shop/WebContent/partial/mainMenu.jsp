<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!--  모든 친구의 메뉴로 들어갈 페이지 -->
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
		<div class="col-sm-2" style="text-align:right;">
			<%
				// Member 클래스 변수 생성(로그인 기록정보 저장)
				Member loginMember = (Member)session.getAttribute("loginMember");
			
				// 로그인 전(session 영역안에 null값이면)
				if(session.getAttribute("loginMember") == null){
			%>
				<!-- request.getContextPath() : 실제로 프로젝트명이 변경되도 변경된 값을 가져온다. -->
				<div class="row row-2">
					<a class="btn btn-light" href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a>&ensp;
					<a class="btn btn-light" href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
				</div>
			<% 
				// 로그인 후(session 영역안에 값이 있으면)
				} else if(loginMember.getMemberLevel() == 0) {
			%>
				<div class="dropdown" style="text-align:right;">
				<button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
					<%=loginMember.getMemberName()%>님
			  	</button>
			  	<div class="dropdown-menu" style="text-align:center;">
			    	<a class="dropdown-item" href="<%=request.getContextPath()%>/logOut.jsp">로그아웃</a>
			    	<a class="dropdown-item" href="<%=request.getContextPath()%>/selectMemberInfo.jsp">회원정보</a>
			    	<a class="dropdown-item" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp">나의 주문목록</a>
			  	</div>
				</div>	
			<% 		
				}
			%>
		</div>
	</nav>
</div>