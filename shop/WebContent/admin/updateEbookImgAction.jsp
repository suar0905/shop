<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- 역할 : request 대신 사용  -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 역할 : 파일이름 중복을 피할 수 있도록  -->

<%
	// 한글 깨짐 방지(request값을 받을 때는 무조건 쓰기)
	request.setCharacterEncoding("utf-8");

	// (1)(로그인 하지 못한 사람)과 (로그인을 했더라도 memberLevel이 1보다 작은 사람)은 들어오지 못하게 하는 코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		System.out.println("로그인을 하세요");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// multipart/form-date로 넘겨졌기 때문에 request.getParameter("ebookNo")형태로 사용불가하다.
	
	// MultipartRequest 매개변수 순서 - > (매개변수, 어디에 저장될것인지, 용량, 인코딩, DefaultFileRenamePolicy)
	MultipartRequest mr = new MultipartRequest(request, "C:/Users/gustn/git/shop/shop/WebContent/image",1024*1024*1024, "utf-8", new DefaultFileRenamePolicy()); // 1024*1024*1024 = 1기가바이트
	
	int ebookNo = Integer.parseInt(mr.getParameter("ebookNo"));
	String ebookImg = mr.getFilesystemName("ebookImg");
	
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setEbookImg(ebookImg);
	
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbookImg(ebook);
	
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookOne.jsp?ebookNo=" + ebookNo);
%>	