package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.ConnUtil;
import vo.Ebook;

public class EbookDao {
	
	// (4) [관리자] 검색된(categoryName) ebook의 수
	public int selectTotalEbookCount(String categoryName) throws ClassNotFoundException, SQLException {
		// selectTotalEbookCount메소드의 categoryName 입력값 확인
		System.out.println("[debug] categoryName param 확인 -> " + categoryName);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member테이블에서 category_name이 ?(categoryName)일때, 총 데이터 수를 조회하여라.
		String sql = "SELECT count(*) FROM ebook WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		System.out.println("[debug] stmt 확인 -> " + stmt); 
		
		//  categoryName으로 검색된 총 데이터 개수 변수
		int searchTotalCount = 0;
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			searchTotalCount = rs.getInt("count(*)");
		}
		System.out.println("[debug] searchTotalCount 확인 -> " + searchTotalCount);
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return searchTotalCount;
	}
	
	// (3) [관리자] 전자책 목록 총 데이터 코드
	public int totalEbookCount() throws ClassNotFoundException, SQLException {
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member테이블의 총 데이터 수를 조회하여라.
		String sql = "SELECT count(*) FROM ebook";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 -> " + stmt); 
		
		//  총 데이터 개수 변수
		int totalCount = 0;
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		System.out.println("[debug] totalCount 확인 -> " + totalCount);
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return totalCount;
	}
	
	// (2) [관리자] categoryName으로 검색된 ebook 목록 출력 코드
	public ArrayList<Ebook> selectEbookListByCategory(String categoryName, int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		// selectEbookListByCategory메소드의 categoryName 입력값 확인
		System.out.println("[debug] categoryName param 확인 -> " + categoryName);
		// selectEbookListByCategory메소드의 beginRow 입력값 확인
		System.out.println("[debug] beginRow param 확인 -> " + beginRow);
		// selectEbookListByCategory메소드의 rowPerPage 입력값 확인
		System.out.println("[debug] rowPerPage param 확인 -> " + rowPerPage);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성 
		// 쿼리문 : ebook테이블에서 category_name이 ?(categoryName)일때, create_date를 내림차순으로 ?(beginRow)부터 ?(rowPerPage)까지 ebookNo, categoryName, ebookTitle, ebookState 항목을 조회하여라.
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_state ebookState FROM ebook WHERE category_name=? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 - > " + stmt);
		stmt.setString(1, categoryName);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 1.1) Ebook 클래스 배열 객체 생성
		ArrayList<Ebook> list = new ArrayList<Ebook>();
		while(rs.next()) {
			// 1.2) Ebook 클래스 객체 생성
			Ebook returnEbook = new Ebook();
			returnEbook.setEbookNo(rs.getInt("ebookNo"));
			returnEbook.setCategoryName(rs.getString("categoryName"));
			returnEbook.setEbookTitle(rs.getString("ebookTitle"));
			returnEbook.setEbookState(rs.getString("ebookState"));
			list.add(returnEbook);
		}
		System.out.println("[debug] list 확인 - > " + list);
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
	
		return list;
	}
	
	// (1) [관리자] 전자책 목록 보기
	public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		// selectEbookList메소드의 beginRow 입력값 확인
		System.out.println("[debug] beginRow param 확인 -> " + beginRow);
		// selectEbookList메소드의 rowPerPage 입력값 확인
		System.out.println("[debug] rowPerPage param 확인 -> " + rowPerPage);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성 
		// 쿼리문 : ebook테이블에서 create_date를 내림차순으로 ?(beginRow)부터 ?(rowPerPage)까지 ebookNo, categoryName, ebookTitle, ebookState 항목을 조회하여라.
		String sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_state ebookState FROM ebook ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 - > " + stmt);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 1.1) Ebook 클래스 배열 객체 생성
		ArrayList<Ebook> list = new ArrayList<Ebook>();
		while(rs.next()) {
			// 1.2) Ebook 클래스 객체 생성
			Ebook returnEbook = new Ebook();
			returnEbook.setEbookNo(rs.getInt("ebookNo"));
			returnEbook.setCategoryName(rs.getString("categoryName"));
			returnEbook.setEbookTitle(rs.getString("ebookTitle"));
			returnEbook.setEbookState(rs.getString("ebookState"));
			list.add(returnEbook);
		}
		System.out.println("[debug] list 확인 - > " + list);
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
