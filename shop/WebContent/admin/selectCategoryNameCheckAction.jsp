<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 유효성 검사(null) 및 공백 검사
	if(request.getParameter("categoryNameCheck") == null || request.getParameter("categoryNameCheck").equals("")) {
		System.out.println("[debug] categoryNameCheck의 값이 Null 이거나 공백입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/insertCategoryForm.jsp");
		return;
	}
	
	// insertCategoryForm에서 categoryNameCheck 값 가져옴.
	String categoryNameCheck = request.getParameter("categoryNameCheck");
	// 디버깅 코드
	System.out.println("[debug] categoryNameCheck 확인 -> " + categoryNameCheck);
	
	// (1) MemberDao 객체 생성
	CategoryDao categoryDao = new CategoryDao();
	String result = categoryDao.selectCategoryName(categoryNameCheck); 
	// 디버깅 코드
	System.out.println("[debug] result 확인 -> " + result);
	
	if(result == null){ // memberIdCheck 값이 null이여서 아이디 사용 가능
		response.sendRedirect(request.getContextPath() + "/admin/insertCategoryForm.jsp?categoryNameCheck=" + categoryNameCheck);
	} else { // memberIdCheck 값이 이미 존재하므로 아이디 사용 불가능
		response.sendRedirect(request.getContextPath() + "/admin/insertCategoryForm.jsp?NameCheckResult=ThisIDisalreadytaken");
	}
%>