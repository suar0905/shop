<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//한글 깨짐 방지(request값을 받을 때는 무조건 쓰기)
	request.setCharacterEncoding("utf-8");

	// (1) 로그인 하지 못한 사람은 페이지에 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 유효성 검사(null 방지)
	if(request.getParameter("orderNo") == null || request.getParameter("ebookNo") == null || request.getParameter("orderScore") == null || request.getParameter("orderCommentContent") == null) {
		System.out.println("[debug] orderScore 또는 orderCommentContent 값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/insertOrderCommentForm.jsp");
		return;
	}
	
	// 공백 방지
	if(request.getParameter("orderNo").equals("") || request.getParameter("ebookNo").equals("") ||request.getParameter("orderScore").equals("") || request.getParameter("orderCommentContent").equals("")) {
		System.out.println("[debug] orderScore 또는 orderCommentContent 값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/insertOrderCommentForm.jsp");
		return;
	}
	
	// insertOrderCommentForm에서 orderScore, orderCommentContent 가져옴
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int orderScore = Integer.parseInt(request.getParameter("orderScore"));
	String orderCommentContent = request.getParameter("orderCommentContent");
	System.out.println("[debug] orderNo 확인 -> " + orderNo);
	System.out.println("[debug] ebookNo 확인 -> " + ebookNo);
	System.out.println("[debug] orderScore 확인 -> " + orderScore);
	System.out.println("[debug] orderCommentContent 확인 -> " + orderCommentContent);
	
	// (2) OrderComment 클래스 객체 생성
	OrderComment orderComment = new OrderComment();
	orderComment.setOrderNo(orderNo);
	orderComment.setEbookNo(ebookNo);
	orderComment.setOrderScore(orderScore);
	orderComment.setOrderCommentContent(orderCommentContent);
	
	// (3) OrderCommentDao 클래스 객체 생성
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	
	int insertRs = orderCommentDao.insertOrderEbookComment(orderComment); 
	
	if(insertRs == 1) {
		System.out.println("[debug] 정상적으로 후기가 작성되었습니다.");
		response.sendRedirect(request.getContextPath() + "/selectOrderListByMember.jsp?");
		return;
	}
%>