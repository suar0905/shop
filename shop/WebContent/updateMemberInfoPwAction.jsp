<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 로그인 하지 못한 사람은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 유효성 검사(null 방지)
	if(request.getParameter("memberNewPw") == null) {
		System.out.println("[debug] memberNewPw가 null값 입니다");
		response.sendRedirect(request.getContextPath() + "/updateMemberInfoPwForm.jsp");
		return;
	}
	
	// 공백 방지
	if(request.getParameter("memberNewPw").equals("")) {
		System.out.println("[debug] memberNewPw가 공백값 입니다");
		response.sendRedirect(request.getContextPath() + "/updateMemberInfoPwForm.jsp");
		return;
	}
	
	// updateMemberInfoPwForm에서 memberNo, memberNewPw값 가져옴
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberNewPw = request.getParameter("memberNewPw");
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	System.out.println("[debug] memberNewPw 확인 -> " + memberNewPw);
	
	// (1) Member 클래스 객체 생성 
	Member paramMember = new Member();
	paramMember.setMemberNo(memberNo);
	
	// (2) MemberDao 클래스 객체 생성
	MemberDao memberDao = new MemberDao();
	memberDao.updateMemberPwByAdmin(paramMember, memberNewPw);
	
	// 완료 후 index로 이동
	System.out.println("[debug] 비밀번호가 정상적으로 변경되었습니다.");
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>	