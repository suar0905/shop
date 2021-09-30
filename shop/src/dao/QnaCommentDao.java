package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.ConnUtil;
import vo.QnaComment;


public class QnaCommentDao {
	
	// (3) [회원 및 관리자] QnA 항목 댓글 삭제 코드
	public int deleteComment(int qnaCommentNo, int qnaNo) throws ClassNotFoundException, SQLException {
		// deleteComment메소드의 qnaCommentNo 입력값 확인
		System.out.println("[debug] qnaCommentNo param 확인 -> " + qnaCommentNo);
		// deleteComment메소드의 qnaNo 입력값 확인
		System.out.println("[debug] qnaNo param 확인 -> " + qnaNo);
				
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
			
		// 쿼리 생성
		// 쿼리문 : qna_comment 테이블에서 qna_comment_no가 ?(qnaCommentNo)이고, qna_no가 ?(qnaNo)인 행의 데이터를 삭제하여라.
		String sql = "DELETE FROM qna_comment WHERE qna_comment_no=? AND qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaCommentNo);
		stmt.setInt(2, qnaNo);
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		// 쿼리 실행
		int deleteRs = stmt.executeUpdate();
		
		if(deleteRs == 1) {
			System.out.println("삭제 성공");
		} else {
			System.out.println("삭제 실패");
		}
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return deleteRs;
	}
	
	// (2) [회원 및 관리자] QnA 항목 댓글 추가 코드
	public int insertComment(int qnaNo, QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		// insertComment메소드의 qnaNo 입력값 확인
		System.out.println("[debug] qnaNo param 확인 -> " + qnaNo);
		// insertComment메소드의 qnaCommentContent 입력값 확인
		System.out.println("[debug] qnaCommentContent param 확인 -> " + qnaComment.getQnaCommentContent());
		// insertComment메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo param 확인 -> " + qnaComment.getMemberNo());
				
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
			
		// 쿼리 생성
		// 쿼리문 : qna_comment테이블에서 qna_no, qna_comment_content, member_no, create_date, update_date 항목에다 ?(qnaNo),?(qnaComment.getQnaCommentContent()),?(qnaComment.getMemberNo()),NOW(),NOW() 값을 추가하여라.
		String sql = "INSERT INTO qna_comment(qna_no, qna_comment_content, member_no, create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		stmt.setString(2, qnaComment.getQnaCommentContent());
		stmt.setInt(3, qnaComment.getMemberNo());
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		// 쿼리 실행
		int insertRs = stmt.executeUpdate();
		
		if(insertRs == 1) {
			System.out.println("입력 성공");
		} else {
			System.out.println("입력 실패");
		}
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return insertRs;
	}
	
	// (1) [관리자] QnA 항목 댓글 전체보기 코드
	public ArrayList<QnaComment> selectCommentListByAllPage(int qnaNo, int commentCurrentPage, int commentRowPerPage) throws ClassNotFoundException, SQLException{
		// selectCommentListByAllPage메소드의 qnaNo 입력값 확인
		System.out.println("[debug] qnaNo param 확인 -> " + qnaNo);
		// selectCommentListByAllPage메소드의 commentCurrentPage 입력값 확인
		System.out.println("[debug] commentCurrentPage param 확인 -> " + commentCurrentPage);
		// selectCommentListByAllPage메소드의 commentRowPerPage 입력값 확인
		System.out.println("[debug] commentRowPerPage param 확인 -> " + commentRowPerPage);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
					
		// 댓글 데이터 시작 행
		int commentBeginRow = (commentCurrentPage - 1) * commentRowPerPage; 
					
		// 쿼리 생성
		// 쿼리문 : qna_comment 테이블에서 qna_no가 ?(qnaNo)값과 같을 때, create_date를 내림차순으로 qnaCommentNo, qnaNo, qnaCommentContent, memberNo, createDate, updateDate 항목을 ?(commentBeginRow)부터 ?(commentRowPerPage)까지 조회하여라.
		String sql = "SELECT qna_comment_no qnaCommentNo, qna_no qnaNo, qna_comment_content qnaCommentContent, member_no memberNo, create_date createDate, update_date updateDate FROM qna_comment WHERE qna_no=? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		stmt.setInt(2, commentBeginRow);
		stmt.setInt(3, commentRowPerPage);
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
					
		// 1.1) QnaComment 클래스 배열 객체 생성
		ArrayList<QnaComment> qcList = new ArrayList<QnaComment>();
		
		while(rs.next()) {
			// QnaComment 클래스 객체 생성
			QnaComment qc = new QnaComment();
			qc.setQnaCommentNo(rs.getInt("qnaCommentNo"));
			qc.setQnaNo(rs.getInt("qnaNo"));
			qc.setQnaCommentContent(rs.getString("qnaCommentContent"));
			qc.setMemberNo(rs.getInt("memberNo"));
			qc.setCreateDate(rs.getString("createDate"));
			qc.setUpdateDate(rs.getString("updateDate"));
			
			qcList.add(qc);
		}
		System.out.println("[debug] qcList 확인 -> " + qcList);
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return qcList;
	}
}
