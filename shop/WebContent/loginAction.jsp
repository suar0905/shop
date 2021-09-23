<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.Member"%>
<%@ page import = "dao.MemberDao"%>
<%
	//* 인증 방어 코드 * 
	// 로그인 전(session.getAttribute("loginMember") -> null)에만 페이지 열람 가능하다.
	if(session.getAttribute("loginMember") != null){
		System.out.println("[debug] 이미 로그인 되어 있습니다.");
		// 상대주소 표기
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return; // 메소드를 종료시켜라.
	}

	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// loginForm에서 memberId, memberPw 입력값을 받아옴
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	// 디버깅 코드
	System.out.println("[debug] memberId 입력값 확인 -> " + memberId);
	System.out.println("[debug] memberPw 입력값 확인 -> " + memberPw);
	
	// (1) Member클래스 객체 생성
	// paramMember 변수에 memberId, memberPw 입력값 저장
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// (2) MemberDao클래스 객체 생성
	MemberDao memberDao = new MemberDao();
	
	Member returnMember = memberDao.login(paramMember);
	
	if(returnMember == null){ // 로그인 실패
		System.out.println("로그인에 실패하였습니다.");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return; 
	} else {
		System.out.println("로그인에 성공하였습니다.");
		System.out.println("[debug] 로그인 정보 -> " + returnMember.getMemberNo());
		System.out.println("[debug] 로그인 정보 -> " + returnMember.getMemberId());
		System.out.println("[debug] 로그인 정보 -> " + returnMember.getMemberLevel());
		System.out.println("[debug] 로그인 정보 -> " + returnMember.getMemberName());
		// 변수이름:loginMember, 값:returnMebmer, loginMember안에는 Member타입의 returnMember변수(memberId, memberName)가 들어가 있다.
		session.setAttribute("loginMember", returnMember);
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>