<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8"); 
	
	//* 인증 방어 코드 * 
	// (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 유효성 검사(null)
	if(request.getParameter("categoryName") == null || request.getParameter("categoryState") == null){
		System.out.println("[debug] categoryName 또는 categoryState값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/insertCategoryForm.jsp");
		return;
	}
	
	// 공백 방지
	if(request.getParameter("categoryName").equals("") || request.getParameter("categoryState").equals("")){
		System.out.println("[debug] categoryName 또는 categoryState값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
		return;
	}
	
	// insertCategoryForm에서 categoryName, categoryState값을 가져옴
	String categoryName = request.getParameter("categoryName");
	String categoryState = request.getParameter("categoryState");
	// 디버깅 코드
	System.out.println("[debug] categoryName 확인 -> " + categoryName);
	System.out.println("[debug] categoryState 확인 -> " + categoryState);
	
	// (1) Category클래스 객체 생성
	Category paramCategory = new Category();
	paramCategory.setCategoryName(categoryName);
	paramCategory.setCategoryState(categoryState);
	// 디버깅 코드
	System.out.println("[debug] paramCategory 확인 -> " + paramCategory);
	
	// (2) CategoryDao클래스 객체 생성
	CategoryDao categoryDao = new CategoryDao();
	int insertRs = categoryDao.insertCategory(paramCategory);
	
	if(insertRs == 1){ // 입력성공
		System.out.println("[debug] 정상적으로 입력이 수행되었습니다!");
		response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");
	} else{ // 입력실패
		System.out.println("[debug] 입력에 실패하였습니다. 다시 시도해주세요.");
		response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");
	}
%>