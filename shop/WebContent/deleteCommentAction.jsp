<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%> 
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 로그인 정보가 없으면 로그인 하도록 로그인페이지로 이동
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		System.out.println("[debug] 로그인 하세요.");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	// 유효성 검사(null값 방지) 
	if(request.getParameter("qnaCommentNo") == null || request.getParameter("qnaNo") == null){
		System.out.println("[debug] qnaCommentNo 또는 qnaNo 값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp");
		return;
	}
		
	// 공백 방지
	if(request.getParameter("qnaCommentNo").equals("") || request.getParameter("qnaNo").equals("")){
		System.out.println("[debug] qnaCommentNo 또는 qnaNo 값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp");
		return;
	}
	
	// selectQnaOne에서 qnaCommentNo, qnaNo 값 가져오기
	int qnaCommentNo = Integer.parseInt(request.getParameter("qnaCommentNo"));
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("[debug] qnaCommentNo 확인 -> " + qnaCommentNo);
	System.out.println("[debug] qnaNo 확인 -> " + qnaNo);
		
	//(1) QnaCommentDao 클래스 객체 생성
	QnaCommentDao qcDao = new QnaCommentDao();
	int deleteRs = qcDao.deleteComment(qnaCommentNo, qnaNo);
	
	if(deleteRs == 1) {
		System.out.println("[debug] 삭제 성공!");
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp?qnaNo=" + qnaNo);
		return;
	} else {
		System.out.println("[debug] 삭제 실패!");
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp?qnaNo=" + qnaNo);
		return;
	}
%>