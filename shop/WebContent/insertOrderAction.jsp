<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	// 로그인 정보 없으면 메인페이지로 돌아가기.
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 유효성 검사(null 방지)
	if(request.getParameter("ebookNo") == null || request.getParameter("memberNo") == null || request.getParameter("orderPrice") == null) {
		System.out.println("[debug] ebookNo, memberNo, orderPrice값이 null값 입니다.");
		response.sendRedirect(request.getContextPath() + "/selectEbookOne.jsp");
		return;
	}
	
	// 공백 방지 코드
	if(request.getParameter("ebookNo").equals("") || request.getParameter("memberNo").equals("") || request.getParameter("orderPrice").equals("")) {
		System.out.println("[debug] ebookNo, memberNo, orderPrice값이 공백값 입니다.");
		response.sendRedirect(request.getContextPath() + "/selectEbookOne.jsp");
		return;
	}
	
	// selectEbookOne에서 ebookNo, memberNo, orderPrice값을 가져옴
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	System.out.println("[debug] ebookNo 확인 -> " + ebookNo);
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	System.out.println("[debug] orderPrice 확인 -> " + orderPrice);
	
	// (1) OrderDao 클래스 객체 생성
	OrderDao orderDao = new OrderDao();
	int insertRs = orderDao.insertOrder(ebookNo, memberNo, orderPrice);
	
	if(insertRs == 1) {
		System.out.println("[debug] 정상적으로 주문되었습니다.");
		response.sendRedirect(request.getContextPath() + "/selectOrderListByMember.jsp");
	} else {
		System.out.println("[debug] 주문 실패하였습니다.");
		response.sendRedirect(request.getContextPath() + "/selectOrderListByMember.jsp");
	}
%>
