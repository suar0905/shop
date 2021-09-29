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
	if(request.getParameter("noticeTitle") == null || request.getParameter("noticeContent") == null || request.getParameter("memberNo") == null || request.getParameter("noticeNo") == null){
		System.out.println("[debug] noticeTitle 또는 noticeContent 또는 memberNo 또는 noticeNo값이 null값입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/updateNoticeForm.jsp");
		return;
	}
	
	// 공백 방지
	if(request.getParameter("noticeTitle").equals("") || request.getParameter("noticeContent").equals("") || request.getParameter("memberNo").equals("") || request.getParameter("noticeNo").equals("")){
		System.out.println("[debug] noticeTitle 또는 noticeContent 또는 memberNo 또는 noticeNo값이 공백값입니다.");
		response.sendRedirect(request.getContextPath() + "/admin/updateNoticeForm.jsp");
		return;
	}
	
	// updateNoticeForm에서 noticeTitle, noticeContent, memberNo, noticeNo값을 가져옴
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// 디버깅 코드
	System.out.println("[debug] noticeTitle 확인 -> " + noticeTitle);
	System.out.println("[debug] noticeContent 확인 -> " + noticeContent);
	System.out.println("[debug] memberNo 확인 -> " + memberNo);
	System.out.println("[debug] noticeNo 확인 -> " + noticeNo);
	
	// (1) Notice 클래스 객체 생성(위에 가져온 값들 paramNotice변수에다 저장)
	Notice paramNotice = new Notice();
	paramNotice.setNoticeTitle(noticeTitle);
	paramNotice.setNoticeContent(noticeContent);
	paramNotice.setMemberNo(memberNo);
	paramNotice.setNoticeNo(noticeNo);
	// 디버깅 코드
	System.out.println("[debug] paramNotice 확인 -> " + paramNotice);
	
	// (2) NoticeDao클래스 객체 생성
	NoticeDao noticeDao = new NoticeDao();
	// (3) updateRs 변수에다 updateNotice 메소드 값 저장
	int updateRs = noticeDao.updateNotice(paramNotice);
	
	if(updateRs == 1){ // 수정성공
		System.out.println("[debug] 정상적으로 수정되었습니다.!");
		response.sendRedirect(request.getContextPath() + "/selectNoticeOne.jsp");
	} else{ // 수정실패
		System.out.println("[debug] 수정 실패하였습니다. 다시 시도해주세요.");
		response.sendRedirect(request.getContextPath() + "/admin/updateNoticeForm.jsp");
	}
%>