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
	if(request.getParameter("qnaNo") == null || request.getParameter("memberNo") == null || request.getParameter("qnaCommentContent") == null){
		System.out.println("[debug] qnaNo 또는 memberNo 또는 qnaCommentContent 값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp");
		return;
	}
		
	// 공백 방지
	if(request.getParameter("qnaNo").equals("") || request.getParameter("memberNo").equals("") || request.getParameter("qnaCommentContent").equals("")){
		System.out.println("[debug] qnaNo 또는 memberNo 또는 qnaCommentContent 값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp");
		return;
	}
	
	// selectQnaOne에서 qnaNo, memberNo, qnaCommentContent 값 가져오기
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String qnaCommentContent = request.getParameter("qnaCommentContent");
	System.out.println("[debug] qnaNo 확인 -> " + qnaNo);
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	System.out.println("[debug] qnaCommentContent 확인 -> " + qnaCommentContent);
	
	// QnaComment 클래스 객체 생성
	QnaComment qc = new QnaComment();
	qc.setMemberNo(memberNo);
	qc.setQnaCommentContent(qnaCommentContent);
	
	// QnaCommentDao 클래스 객체 생성
	QnaCommentDao qcDao = new QnaCommentDao();
	int insertRs = qcDao.insertComment(qnaNo, qc);
	
	if(insertRs == 1) {
		System.out.println("[debug] 입력 성공!");
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp?qnaNo=" + qnaNo);
		return;
	} else {
		System.out.println("[debug] 입력 실패!");
		response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp?qnaNo=" + qnaNo);
		return;
	}
%>