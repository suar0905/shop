<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8"); 
	
	// * 인증 방어 코드 * 
	// (1) (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 유효성 검사(null방지) 코드
	if(request.getParameter("ebookNo") == null || request.getParameter("ebookNewPrice") == null) {
		System.out.println("[debug] ebookNo 또는 ebookNewPrice값이 null값 입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/updateEbookPriceForm.jsp");
		return;
	}
	
	// 공백 방지 코드
	if(request.getParameter("ebookNo").equals("") || request.getParameter("ebookNewPrice").equals("")) {
		System.out.println("[debug] ebookNo 또는 ebookNewPrice값이 공백값 입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/updateEbookPriceForm.jsp");
		return;
	}
	
	// updateEbookPriceForm에서 ebookNo, ebookNewPrice 값을 가져옴
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int ebookNewPrice = Integer.parseInt(request.getParameter("ebookNewPrice"));
	
	// 디버깅 코드
	System.out.println("[debug] ebookNo 확인 -> " + ebookNo);
	System.out.println("[debug] ebookNewPrice 확인 -> " + ebookNewPrice);
	
	// (2) Ebook 클래스 객체 생성
	Ebook paramEbook = new Ebook();
	paramEbook.setEbookNo(ebookNo);
	System.out.println("[debug] paramEbook 확인 -> " + paramEbook);
	
	// (3) EbookDao 클래스 객체 생성
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbookPrice(paramEbook, ebookNewPrice);
	System.out.println("[debug] ebookDao 확인 -> " + ebookDao);
	
	System.out.println("[debug] 정상적으로 수정되었습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/updateEbookPriceForm.jsp");
%>