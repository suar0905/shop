<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- 역할 : request 대신 사용  -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 역할 : 파일이름 중복을 피할 수 있도록  -->

<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	//관리자가 아닌 사람은 페이지 실행 불가
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember.getMemberLevel() < 1) {
		System.out.println("당신은 관리자 계정이 아닙니다.");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// multipart/form-date로 넘겨졌기 때문에 request.getParameter("ebookNo")형태로 사용불가하다.
	
	// MultipartRequest 매개변수 순서 - > (매개변수, 어디에 저장될것인지, 용량, 인코딩, DefaultFileRenamePolicy)
	MultipartRequest mr = new MultipartRequest(request, "C:/Users/gustn/git/shop/shop/WebContent/image",1024*1024*1024, "utf-8", new DefaultFileRenamePolicy()); // 1024*1024*1024 = 1기가바이트
															
	// insertEbookForm.jsp에서 값 가져오기
	String ebookISBN = mr.getParameter("ebookISBN");
	String categoryName = mr.getParameter("categoryName");
	String ebookTitle = mr.getParameter("ebookTitle");
	String ebookAuthor = mr.getParameter("ebookAuthor");
	String ebookCompany = mr.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(mr.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(mr.getParameter("ebookPrice"));
	String ebookImg = mr.getFilesystemName("ebookImg");
	String ebookSummary = mr.getParameter("ebookSummary");
	String ebookState = mr.getParameter("ebookState");
	
	// System.out.println("ebookISBN => " + ebookISBN);
	// System.out.println("categoryName => " + categoryName);
	// System.out.println("ebookTitle => " + ebookTitle);
	// System.out.println("ebookAuthor => " + ebookAuthor);
	// System.out.println("ebookCompany => " + ebookCompany);
	// System.out.println("ebookPageCount => " + ebookPageCount);
	// System.out.println("ebookPrice => " + ebookPrice);
	// System.out.println("ebookImg => " + ebookImg);
	// System.out.println("ebookSummary => " + ebookSummary);
	// System.out.println("ebookState => " + ebookState);
	
	
	// Ebook 클래스 객체 생성
	Ebook ebook = new Ebook();
	ebook.setEbookISBN(ebookISBN);
	ebook.setCategoryName(categoryName);
	ebook.setEbookTitle(ebookTitle);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookImg(ebookImg);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookState(ebookState);
	
	System.out.println("뷰에서 입력받은 ebook 객체 값 => " + ebook.toString());
	
	EbookDao ebookDao = new EbookDao();
	int insertRs = ebookDao.insertEbook(ebook);
	
	if(insertRs == 1) {
		System.out.println("추가 성공!");
		response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
	} else {
		System.out.println("추가 실패!");
		response.sendRedirect(request.getContextPath() + "/admin/insertEbookForm.jsp");
	}
%>