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
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
		
	// deleteMemberInfoForm에서 memberNo, memberName값 가져옴
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberName = request.getParameter("memberName");
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	System.out.println("[debug] memberName 확인 -> " + memberName);
	
	// (1) Member 클래스 객체 생성 
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberName(memberName);
	
	// (2) MemberDao 클래스 객체 생성
	MemberDao memberDao = new MemberDao();
	memberDao.deleteMemberByAdmin(member);
	
	// 완료 후 index로 이동
	System.out.println("[debug] 정상적으로 회원탈퇴 되었습니다.");
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
%>	