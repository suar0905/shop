package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.ConnUtil;
import vo.Ebook;
import vo.Member;
import vo.Order;
import vo.OrderEbookMember;

public class OrderDao {
	
	// (4) [회원 및 관리자] 해당 상품 주문하는 코드
	public int insertOrder(int ebookNo, int memberNo, int orderPrice) throws ClassNotFoundException, SQLException {
		// insertOrder메소드의 ebookNo 입력값 확인
		System.out.println("[debug] ebookNo param 확인 -> " + ebookNo);
		// insertOrder메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo param 확인 -> " + memberNo);
		// insertOrder메소드의 memberNo 입력값 확인
		System.out.println("[debug] orderPrice param 확인 -> " + orderPrice);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 :  
		String sql = "INSERT INTO orders(ebook_no, member_no, order_price, create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		stmt.setInt(2, memberNo);
		stmt.setInt(3, orderPrice);
		System.out.println("[debug] stmt 확인 - > " + stmt);
		
		// 쿼리 실행
		int insertRs = stmt.executeUpdate();
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return insertRs;
	}
	
	// (3) [회원 및 관리자] 나의 주문관리 목록 출력 코드
	public ArrayList<OrderEbookMember> selectOrderListByMember(int memberNo, int beginRow, int row_per_page) throws ClassNotFoundException, SQLException {
		// selectOrderListByMember메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo param 확인 -> " + memberNo);
		// selectOrderListByMember메소드의 beginRow 입력값 확인
		System.out.println("[debug] beginRow param 확인 -> " + beginRow);
		// selectOrderListByMember메소드의 memberNo 입력값 확인
		System.out.println("[debug] row_per_page param 확인 -> " + row_per_page);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 :  
		String sql = "SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.create_date createDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no WHERE m.member_no=? ORDER BY o.create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 - > " + stmt);
		stmt.setInt(1, memberNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, row_per_page);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 1.1) OrderEbookMember 클래스 배열 객체 생성
		ArrayList<OrderEbookMember> list = new ArrayList<OrderEbookMember>();
		
		while(rs.next()) {
			// 1.2) OrderEbookMember 클래스 객체 생성
			OrderEbookMember oem = new OrderEbookMember();
			// 1.3) Order 클래스 객체 생성
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCrateDate(rs.getString("createDate"));
			oem.setOrder(o);
			// 1.4) Ebook 클래스 객체 생성
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			// 1.5) Member 클래스 객체 생성
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);
		}
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
		
	// (2) [관리자] 주문관리 목록 총 데이터 개수 코드
	public int totalOrderCount() throws ClassNotFoundException, SQLException {
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : orders테이블의 총 데이터 수를 조회하여라.
		String sql = "SELECT count(*) FROM orders";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 -> " + stmt); 
		
		// 총 데이터 개수 변수
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
		
	// (1) [관리자] 주문관리 전체목록 출력 코드
	public ArrayList<OrderEbookMember> selectOrderList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		// selectOrderList메소드의 beginRow 입력값 확인
		System.out.println("[debug] beginRow param 확인 -> " + beginRow);
		// selectOrderList메소드의 rowPerPage 입력값 확인
		System.out.println("[debug] rowPerPage param 확인 -> " + rowPerPage);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 :  
		String sql = "SELECT o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.create_date createDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no ORDER BY o.create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 - > " + stmt);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 1.1) OrderEbookMember 클래스 배열 객체 생성
		ArrayList<OrderEbookMember> list = new ArrayList<OrderEbookMember>();
		
		while(rs.next()) {
			// 1.2) OrderEbookMember 클래스 객체 생성
			OrderEbookMember oem = new OrderEbookMember();
			// 1.3) Order 클래스 객체 생성
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCrateDate(rs.getString("createDate"));
			oem.setOrder(o);
			// 1.4) Ebook 클래스 객체 생성
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			// 1.5) Member 클래스 객체 생성
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);
		}
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
