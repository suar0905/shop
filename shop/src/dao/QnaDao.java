package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.ConnUtil;
import vo.Member;
import vo.Qna;

public class QnaDao {
	
	// (5) [회원 및 관리자] QnA 게시물 삭제하기 코드
	public int deleteQna(int qnaNo) throws ClassNotFoundException, SQLException {
		// deleteQna메소드의 qnaNo 입력값 확인
		System.out.println("[debug] qnaNo 값 확인 -> " + qnaNo);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
		
		// 쿼리 생성
		// 쿼리문 : qna 테이블에서 qna_no가 ?(qnaNo)일때 해당 데이터를 삭제하여라.
		String sql = "DELETE FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		System.out.println("[debug] stmt 확인 -> + " + stmt);
		
		// 쿼리 실행
		int deleteRs = stmt.executeUpdate();
		
		if(deleteRs == 1) {
			System.out.println("[debug] 삭제 성공");
		} else {
			System.out.println("[debug] 삭제 실패");
		}
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return deleteRs;
	}
	
	// (4) [회원 및 관리자] QnA 게시물 수정하기 코드(회원은 로그인한 memberNo와 수정할 qna게시글의 memberNo가 같아야함)
	public int updateQna(Qna qna, int qnaNo, int checkMemberNo) throws ClassNotFoundException, SQLException {
		// updateQna메소드의 qnaCategory 입력값 확인
		System.out.println("[debug] qnaCategory param 확인 -> " + qna.getQnaCategory());
		// updateQna메소드의 qnaSecret 입력값 확인
		System.out.println("[debug] qnaSecret param 확인 -> " + qna.getQnaSecret());
		// updateQna메소드의 qnaTitle 입력값 확인
		System.out.println("[debug] qnaTitle param 확인 -> " + qna.getQnaTitle());
		// updateQna메소드의 qnaContent 입력값 확인
		System.out.println("[debug] qnaContent param 확인 -> " + qna.getQnaContent());
		// updateQna메소드의 qnaNo 입력값 확인
		System.out.println("[debug] qnaNo 값 확인 -> " + qnaNo);
		// updateQna메소드의 checkMemberNo 입력값 확인
		System.out.println("[debug] memberNo 값 확인 -> " + checkMemberNo);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
		
		// 쿼리 생성
		// 쿼리문 : qna 테이블에서 qna_no가 ?(qnaNo)이고, member_no가 ?(checkMemberNo)일때, qnaCategory, qnaSecret, qnaTitle, qnaContent, createDate, updateDate를 각각 ?,?,?,?,NOW(),NOW()로 수정하여라.
		String sql = "UPDATE qna Set qna_category=?, qna_secret=?, qna_title=?, qna_content=?, create_date=NOW(), update_date=NOW() WHERE qna_no=? AND member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategory());
		stmt.setString(2, qna.getQnaSecret());
		stmt.setString(3, qna.getQnaTitle());
		stmt.setString(4, qna.getQnaContent());
		stmt.setInt(5, qnaNo);
		stmt.setInt(6, checkMemberNo);
		System.out.println("[debug] stmt 확인 -> + " + stmt);
		
		// 쿼리 실행
		int updateRs = stmt.executeUpdate();
		
		if(updateRs == 1) {
			System.out.println("[debug] 수정 성공");
		} else {
			System.out.println("[debug] 수정 실패");
		}
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return updateRs;
	}
	
	// (3) [회원 및 관리자] QnA 게시물 추가하기 코드
	public int insertQna(Qna qna, int memberNo) throws ClassNotFoundException, SQLException {
		// insertQna메소드의 qnaCategory 입력값 확인
		System.out.println("[debug] qnaCategory param 확인 -> " + qna.getQnaCategory());
		// insertQna메소드의 qnaTitle 입력값 확인
		System.out.println("[debug] qnaTitle param 확인 -> " + qna.getQnaTitle());
		// insertQna메소드의 qnaContent 입력값 확인
		System.out.println("[debug] qnaContent param 확인 -> " + qna.getQnaContent());
		// insertQna메소드의 qnaSecret 입력값 확인
		System.out.println("[debug] qnaSecret param 확인 -> " + qna.getQnaSecret());
		// insertQna메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo 값 확인 -> " + memberNo);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
		
		// 쿼리 생성
		// 쿼리문 : qna 테이블에서 member_no가 ?(memberNo)일때, qna_category, qna_title, qna_content, qna_secret, member_no, create_date, update_date 항목에다 ?(qna.getQnaCategory()),?(qna.getQnaTitle()),?(qna.getQnaContent()),?(qna.getQnaSecret()),NOW(),NOW()값을 추가하여라.
		String sql = "INSERT INTO qna(qna_category, qna_title, qna_content, qna_secret, member_no, create_date, update_date) VALUES(?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategory());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, memberNo);
		System.out.println("[debug] stmt 확인 -> + " + stmt);
		
		// 쿼리 실행
		int insertRs = stmt.executeUpdate();
		
		if(insertRs == 1) {
			System.out.println("[debug] 입력 성공");
		} else {
			System.out.println("[debug] 입력 실패");
		}
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return insertRs;
	}
	
	// (2) [비회원 및 회원 및 관리자] QnA 상세보기 코드(qnaNo값 이용)
	public Qna selectQnaListByAllPage(int qnaNo) throws ClassNotFoundException, SQLException {
		// selectQnaListByAllPage메소드의 qnaNo 입력값 확인
		System.out.println("[debug] qnaNo param 확인 -> " + qnaNo);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
		
		// 쿼리 생성
		// 쿼리문 : qna 테이블에서 qna_no가 ?(qnaNo)일때, qnaNo, qnaCategory, qnaTitle, qnaContent, qnaSecret, memberNo, createDate, updateDate 항목의 값들을 조회하여라.
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no memberNo, create_date createDate, update_date updateDate FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		System.out.println("[debug] stmt 확인 -> + " + stmt); 
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 2.1) Qna 클래스 변수 생성
		Qna qna = null;
		
		while(rs.next()) {
			// 2.2) Qna 클래스 객체 생성(쿼리 실행 값들 저장)
			qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("memberNo"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
		}
		System.out.println("[debug] qna 확인 -> + " + qna); 
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return qna;
	}
	
	// (1) [비회원 및 회원 및 관리자] QnA 목록 페이지 보기 코드
	public ArrayList<Qna> selectQnaListPage(int beginRow, int row_per_page) throws ClassNotFoundException, SQLException {
		// selectQnaListPage메소드의 beginRow 입력값 확인
		System.out.println("[debug] beginRow param 확인 -> " + beginRow);
		// selectQnaListPage메소드의 row_per_page 입력값 확인
		System.out.println("[debug] row_per_page param 확인 -> " + row_per_page);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
		
		// 쿼리 생성
		// 쿼리문 : qna 테이블에서 create_date 값을 내림차순으로 ?(beginRow)부터 ?(row_per_page)까지, qnaNo, qnaCategory, qnaTitle, qnaSecret 항목의 값들을 조회하여라.
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_secret qnaSecret FROM qna ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, row_per_page);
		System.out.println("[debug] stmt 확인 -> + " + stmt); 
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 1.1) Qna 클래스 배열 객체 생성
		ArrayList<Qna> list = new ArrayList<Qna>();
		
		while(rs.next()) {
			// 1.2) Qna 클래스 객체 생성(쿼리 실행 값들 저장)
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			
			list.add(qna);
		}
		System.out.println("[debug] list 확인 -> + " + list); 
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
