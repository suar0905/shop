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
	if(request.getParameter("qnaCategory") == null || request.getParameter("qnaTitle") == null || request.getParameter("qnaContent") == null || request.getParameter("qnaSecret") == null || request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath() + "/insertQnaForm.jsp");
		return;
	}
		
	// 공백 방지
	if(request.getParameter("qnaCategory").equals("") || request.getParameter("qnaTitle").equals("") || request.getParameter("qnaContent").equals("") || request.getParameter("qnaSecret").equals("") || request.getParameter("memberNo").equals("")){
		response.sendRedirect(request.getContextPath() + "/insertQnaForm.jsp");
		return;
	}
	
	// insertQnaForm에서 변수값 가져오기
	String qnaCategory = request.getParameter("qnaCategory");
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaSecret = request.getParameter("qnaSecret");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 디버깅 코드
	System.out.println("[debug] qnaCategory 입력값 -> " + qnaCategory);
	System.out.println("[debug] qnaTitle 입력값 -> " + qnaTitle);
	System.out.println("[debug] qnaContent 입력값 -> " + qnaContent);
	System.out.println("[debug] qnaSecret 입력값 -> " + qnaSecret);
	System.out.println("[debug] memberNo 값 -> " + memberNo);
	
	// (1) qna 클래스 객체 생성
	// qna라는 변수에 입력받은 값들 저장하기.
	Qna paramQna = new Qna();
	paramQna.setQnaCategory(qnaCategory);
	paramQna.setQnaTitle(qnaTitle);
	paramQna.setQnaContent(qnaContent);
	paramQna.setQnaSecret(qnaSecret);
	
	// (2) QnaDao 클래스 객체 생성
	QnaDao qnaDao = new QnaDao();
	int insertRs = qnaDao.insertQna(paramQna, memberNo);
	System.out.println("[debug] insertRs변수에 잘 저장됬는지 확인 -> " + insertRs);
	
	if(insertRs == 1){ // 입력성공
		System.out.println("[debug] 정상적으로 입력이 수행되었습니다!");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
	} else{ // 입력실패
		System.out.println("[debug] 입력에 실패하였습니다. 다시 시도해주세요.");
		response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
	}
%>