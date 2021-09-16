<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.Member"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// * 인증 방어 코드 * 
	// (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	// 이미 로그인한 기록을 loginMember변수에 저장
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// null 방지 코드 
	if(request.getParameter("memberNo") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
		return;
	}
	
	// selectMemberList에서 memberNo를 받아옴.
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 디버깅 코드
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	
	// (1) MemberDao 객체 생성
	MemberDao memberDao = new MemberDao();
	memberDao.deleteMemberByAdmin(memberNo); // meberDao = selectMemberList에서 받아온 memberNo를 deleteMemberByAdmin메소드에 적용
	// 디버깅 코드
	System.out.println("[debug] memberDao 확인 -> " + memberDao);
	response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
%>