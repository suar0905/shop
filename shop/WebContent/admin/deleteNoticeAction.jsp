<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8"); 
	
	// * 인증 방어 코드 * 
	// (로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 유효성 검사(null)
	if(request.getParameter("noticeNo") == null){
		System.out.println("[debug] noticeNo값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/deleteNoticeForm.jsp");
		return;
	}
	
	// 공백 방지
	if(request.getParameter("noticeNo").equals("")){
		System.out.println("[debug] noticeNo값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/deleteNoticeForm.jsp");
		return;
	}
	
	// deleteNoticeForm에서 noticeNo값을 가져옴
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// 디버깅 코드
	System.out.println("[debug] noticeNo 확인 -> " + noticeNo);
		
	// (1) NoticeDao클래스 객체 생성
	NoticeDao noticeDao = new NoticeDao();
	// (3) deleteRs 변수에다 deleteNotice 메소드 값 저장
	int deleteRs = noticeDao.deleteNotice(noticeNo);
	
	if(deleteRs == 1){ // 삭제성공
		System.out.println("[debug] 정상적으로 삭제되었습니다!");
		response.sendRedirect(request.getContextPath() + "/selectNoticeOne.jsp");
	} else{ // 삭제실패
		System.out.println("[debug] 삭제 실패하였습니다. 다시 시도해주세요.");
		response.sendRedirect(request.getContextPath() + "/admin/deleteNoticeForm.jsp");
	}
%>