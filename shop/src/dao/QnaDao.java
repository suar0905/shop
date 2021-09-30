package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.ConnUtil;
import vo.Qna;

public class QnaDao {
	
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
