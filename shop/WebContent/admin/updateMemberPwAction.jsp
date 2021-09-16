<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.Member"%>
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
	if(request.getParameter("memberNo") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
		return;
	}
	
	// updateMemberPwForm에서 memberNo, memberPw, memberName을 받아옴.
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberNewPw = request.getParameter("memberNewPw");
	String memberName = request.getParameter("memberName");
	
	// 디버깅 코드
	System.out.println("[debug] memberNo 확인 ->" + memberNo);
	System.out.println("[debug] memberNewPw 확인 ->" + memberNewPw);
	System.out.println("[debug] memberName 확인 -> " + memberName);
	
	// (1) Member 객체 생성
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberPw(memberNewPw);
	member.setMemberPw(memberName);
	
	// (2) MemberDao 객체 생성
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMemberPwByAdmin(member, memberNewPw);
	System.out.println("[debug] row 확인 -> " + row);
	
	if(row == 1) {
		System.out.println("비밀번호를 수정하였습니다!");
		response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
	}
%>	