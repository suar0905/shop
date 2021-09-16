<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// * 인증 방어 코드 * 
	// (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// null 방지 코드 
	if(request.getParameter("memberNo") == null || request.getParameter("memberNewLevel") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
		return;
	}

    // updateMemberLevelForm에서 memberNo, memberNewLevel 받아옴
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int memberNewLevel = Integer.parseInt(request.getParameter("memberNewLevel"));
	
	// 디버깅 코드
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	System.out.println("[debug] memberNewLevel 확인 -> " + memberNewLevel);

    // (1) Member 객체 생성
	Member paramMember = new Member();
	paramMember.setMemberNo(memberNo);
	paramMember.setMemberLevel(memberNewLevel);
	// 디버깅 코드
	System.out.println("[debug] paramMember 확인 -> " + paramMember);
	
	// (2) MemberDao 객체 생성
	MemberDao memberDao = new MemberDao();
	memberDao.updateMemberLevelByAdmin(paramMember, memberNewLevel);
	// 디버깅 코드
	System.out.println("[debug] memberDao 확인 -> " + memberDao);
	
	//완료 후 selectMemberList로 이동
	response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
%>