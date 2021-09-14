<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%> <!-- vo 패키지안의 Member 클래스 정보이용 -->
<%@ page import="dao.MemberDao"%> <!-- dao 패키지안의 MemberDao 클래스 정보이용 -->
<%
	//* 인증 방어 코드 * 
	// 로그인 전(session.getAttribute("loginMember") -> null)에만 페이지 열람 가능하다.
	if(session.getAttribute("loginMember") != null){
		System.out.println("[debug] 이미 로그인 되어 있습니다.");
		// 상대주소 표기
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return; // 메소드를 종료시켜라.
	}

	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	
	// 유효성 검사 
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberLevel") == null || request.getParameter("memberName") == null || request.getParameter("memberAge") == null || request.getParameter("memberGender") == null){
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
		return;
	}
		
	// 공백 방지
	if(request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberLevel").equals("") || request.getParameter("memberName").equals("") || request.getParameter("memberAge").equals("") || request.getParameter("memberGender").equals("")){
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
		return;
	}
	
	// insertMemberForm에서 변수값 가져오기
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	
	// 디버깅 코드
	System.out.println("[debug] memberId 입력값 -> " + memberId);
	System.out.println("[debug] memberPw 입력값 -> " + memberPw);
	System.out.println("[debug] memberLevel 입력값 -> " + memberLevel);
	System.out.println("[debug] memberName 입력값 -> " + memberName);
	System.out.println("[debug] memberAge 입력값 -> " + memberAge);
	System.out.println("[debug] memberGender 입력값 -> " + memberGender);
	
	// (1) Member 클래스 객체 생성
	// member라는 변수에 입력받은 값들 저장하기.
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberLevel(memberLevel);
	paramMember.setMemberName(memberName);
	paramMember.setMemberAge(memberAge);
	paramMember.setMemberGender(memberGender);
	// 디버깅 코드
	System.out.println("[debug] member변수에 잘 저장됬는지 확인 -> " + paramMember);
	
	// (2) MemberDao 클래스 객체 생성
	MemberDao memberDao = new MemberDao();
	int insertRs = memberDao.insertMember(paramMember);
	System.out.println("[debug] insertRs변수에 잘 저장됬는지 확인 -> " + insertRs);
	
	if(insertRs == 1){ // 입력성공
		System.out.println("[debug] 정상적으로 입력이 수행되었습니다!");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	} else{ // 입력실패
		System.out.println("[debug] 입력에 실패하였습니다. 다시 시도해주세요.");
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
	}
%>