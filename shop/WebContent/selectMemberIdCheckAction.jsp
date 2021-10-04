<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 유효성 검사(null) 및 공백 검사
	if(request.getParameter("memberIdCheck") == null || request.getParameter("memberIdCheck").equals("")) {
		System.out.println("[debug] memberIdCheck의 값이 Null 이거나 공백입니다.");
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
		return;
	}
	
	// insertMemberForm에서 memberIdCheck 값 가져옴.
	String memberIdCheck = request.getParameter("memberIdCheck");
	// 디버깅 코드
	System.out.println("[debug] memberIdCheck 확인 -> " + memberIdCheck);
	
	// (1) MemberDao 객체 생성
	MemberDao memberDao = new MemberDao();
	String result = memberDao.selectMemberIdCheck(memberIdCheck); 
	// 디버깅 코드
	System.out.println("[debug] result 확인 -> " + result);
	
	if(result == null){ // memberIdCheck 값이 null이여서 아이디 사용 가능
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?memberIdCheck=" + memberIdCheck);
	} else { // memberIdCheck 값이 이미 존재하므로 아이디 사용 불가능
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?idCheckResult=ThisIDisalreadytaken");
	}
%>