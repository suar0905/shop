<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!--  모든 친구의 메뉴로 들어갈 페이지 -->
<div>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<ul class="navbar-nav">
		<li class="nav-item active">
			<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">홈으로</a>
		</li>
		<li class="nav-item active">
			<a class="navbar-brand" href="">menu</a>
		</li>	
		<li class="nav-item active">
			<a class="navbar-brand" href="">menu</a>
		</li>
		<li class="nav-item active">
			<a class="navbar-brand" href="">menu</a>
		</li>
		<li class="nav-item active">
			<a class="navbar-brand" href="<%=request.getContextPath()%>/selectNoticeOne.jsp">공지사항</a>
		</li>
	</ul>
	</nav>
</div>