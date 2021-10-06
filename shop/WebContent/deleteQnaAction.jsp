<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%> 
<%@ page import="dao.*"%> 
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	//* 인증 방어 코드 * 
	// 로그인 하지 못한 사람은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	// 유효성 검사 
	if(request.getParameter("qnaNo") == null){
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp");
		return;
	}
		
	// 공백 방지
	if(request.getParameter("qnaNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp");
		return;
	}
	
	// deleteQnaForm에서 변수값 가져오기
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	// 디버깅 코드
	System.out.println("[debug] qnaNo 값 -> " + qnaNo);
	
	// (1) QnaDao 클래스 객체 생성
	QnaDao qnaDao = new QnaDao();
	int deleteRs = qnaDao.deleteQna(qnaNo);
	System.out.println("[debug] deleteRs변수에 잘 저장됬는지 확인 -> " + deleteRs);
	
	if(deleteRs == 1){ // 삭제성공
		System.out.println("[debug] 정상적으로 삭제 되었습니다!");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
	} else{ // 삭제실패
		System.out.println("[debug] 삭제 실패하였습니다. 다시 시도해주세요.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
	}
%>