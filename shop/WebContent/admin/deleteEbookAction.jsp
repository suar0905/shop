<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8"); 
	
	//* 인증 방어 코드 * 
	// (1) (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 유효성 검사(null방지), 공백 방지 코드
	if(request.getParameter("ebookNo") == null || request.getParameter("ebookTitle") == null || request.getParameter("ebookNo").equals("") || request.getParameter("ebookTitle").equals("")) {
		System.out.println("[debug] ebookNo 또는 ebookTitle값이 null값이거나 공백값 입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/deleteEbookForm.jsp");
		return;
	}
	
	// deleteEbookForm에서 ebookNo, ebookTitle 값을 가져옴
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	String ebookTitle = request.getParameter("ebookTitle");
	
	// 디버깅 코드
	System.out.println("[debug] ebookNo 확인 -> " + ebookNo);
	System.out.println("[debug] ebookTitle 확인 -> " + ebookTitle);
	
	// (2) Ebook 클래스 객체 생성
	Ebook paramEbook = new Ebook();
	paramEbook.setEbookNo(ebookNo);
	paramEbook.setEbookTitle(ebookTitle);
	System.out.println("[debug] paramEbook 확인 -> " + paramEbook);
	
	// (3) EbookDao 클래스 객체 생성
	EbookDao ebookDao = new EbookDao();
	int deleteRs = ebookDao.deleteEbook(paramEbook);
	
	if(deleteRs == 1) {
		System.out.println("[debug] 정상적으로 삭제되었습니다.");
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
		return;
	} else {
		System.out.println("[debug] 삭제 실패하였습니다.");
		response.sendRedirect(request.getContextPath() + "/admin/deleteEbookForm.jsp");
		return;
	}
%>