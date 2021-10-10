package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.ConnUtil;
import vo.Notice;

public class NoticeDao {
	
	// (6) [비회원 및 회원 및 관리자] 공지사항 게시글 총 데이터 코드
	public int totalNoticeCount() throws ClassNotFoundException, SQLException {
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : notice테이블의 총 데이터 수를 조회하여라.
		String sql = "SELECT count(*) FROM notice";
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
	
	// (5) [관리자] 공지사항 삭제 코드
	public int deleteNotice(int noticeNo) throws ClassNotFoundException, SQLException {
		// deleteNotice메소드의 noticeNo 입력값 확인
		System.out.println("[debug] noticeNo param 확인 -> " + noticeNo);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn);
		
		// 쿼리 생성
		// 쿼리문 : notice 테이블에서 notice_no가 ?(noticeNo)일때의 데이터를 삭제하여라.
		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
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
	
	// (4) [관리자] 공지사항 수정 코드
	public int updateNotice(Notice notice) throws ClassNotFoundException, SQLException {
		// updateNotice메소드의 noticeTitle 입력값 확인
		System.out.println("[debug] noticeTitle param 확인 -> " + notice.getNoticeTitle());
		// updateNotice메소드의 noticeContent 입력값 확인
		System.out.println("[debug] noticeContent param 확인 -> " + notice.getNoticeContent());
		// updateNotice메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo param 확인 -> " + notice.getMemberNo());
		// updateNotice메소드의 noticeNo 입력값 확인
		System.out.println("[debug] noticeNo param 확인 -> " + notice.getNoticeNo());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn);
		
		// 쿼리 생성
		// 쿼리문 : notice 테이블에서 notice_no가 ?(notice.getNoticeNo())일때, notice_title=?(notice.getNoticeTitle()), notice_content=?(notice.getNoticeContent()), member_no=?(notice.getMemberNo())값으로 수정하어라. 
		String sql = "UPDATE notice SET notice_title=?, notice_content=?, member_no=? WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getMemberNo());
		stmt.setInt(4, notice.getNoticeNo());
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
	
	// (3) [관리자] 공지사항 추가 코드
	public int insertNotice(Notice notice) throws ClassNotFoundException, SQLException {
		// insertNotice메소드의 noticeTitle 입력값 확인
		System.out.println("[debug] noticeTitle param 확인 -> " + notice.getNoticeTitle());
		// insertNotice메소드의 noticeContent 입력값 확인
		System.out.println("[debug] noticeContent param 확인 -> " + notice.getNoticeContent());
		// insertNotice메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo param 확인 -> " + notice.getMemberNo());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn);
		
		// 쿼리 생성
		// 쿼리문 : notice 테이블에서 notice_title, notice_content, member_no, create_date, update_date 항목의 값을 ?(notice.getNoticeTitle()),?(notice.getNoticeContent()),?(notice.getMemberNo()),NOW(),NOW()으로 추가하여라.
		String sql = "INSERT INTO notice(notice_title, notice_content, member_no, create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getMemberNo());
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
	
	// (2) [비회원 및 회원 및 관리자] 최근 공지사항 5개 보기코드
	public ArrayList<Notice> selectNoticeListRecentDatePage() throws ClassNotFoundException, SQLException {
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
		
		// 쿼리 생성
		// 쿼리문 : notice 테이블에서 create_date 값을 내림차순으로 1행부터 5행까지, noticeNo, noticeTitle, noticeContent, memberNo, createDate, updateDate 항목의 값들을 조회하여라.
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, member_no memberNo, create_date createDate, update_date updateDate FROM notice ORDER BY create_date DESC LIMIT 0,5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 -> + " + stmt); 
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 1.1) Notice 클래스 배열 객체 생성
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		while(rs.next()) {
			// 1.2) Notice 클래스 객체 생성(쿼리 실행 값들 저장)
			Notice notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
			
			list.add(notice);
		}
		System.out.println("[debug] list 확인 -> + " + list); 
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// (1) [비회원 및 회원 및 관리자] 공지사항 페이지 상세보기 코드
	public ArrayList<Notice> selectNoticeListByAllPage(int beginRow, int row_per_page) throws ClassNotFoundException, SQLException {
		// selectNoticeListByAllPage메소드의 beginRow 입력값 확인
		System.out.println("[debug] beginRow param 확인 -> " + beginRow);
		// selectNoticeListByAllPage메소드의 row_per_page 입력값 확인
		System.out.println("[debug] row_per_page param 확인 -> " + row_per_page);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
		
		// 쿼리 생성
		// 쿼리문 : notice 테이블에서 create_date 값을 내림차순으로 ?(beginRow)부터 ?(row_per_page)까지, noticeNo, noticeTitle, noticeContent, memberNo, createDate, updateDate 항목의 값들을 조회하여라.
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, member_no memberNo, create_date createDate, update_date updateDate FROM notice ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, row_per_page);
		System.out.println("[debug] stmt 확인 -> + " + stmt); 
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 1.1) Notice 클래스 배열 객체 생성
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		while(rs.next()) {
			// 1.2) Notice 클래스 객체 생성(쿼리 실행 값들 저장)
			Notice notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
			
			list.add(notice);
		}
		System.out.println("[debug] list 확인 -> + " + list); 
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
