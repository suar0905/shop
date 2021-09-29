package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.ConnUtil;
import vo.Notice;

public class NoticeDao {
	
	// (2) [비회원 및 회원 및 관리자] 최근 공지사항 5개 보기코드
	public ArrayList<Notice> selectNoticeListRecentDatePage() throws ClassNotFoundException, SQLException {
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); 
		
		// 쿼리 생성
		// 쿼리문 :  
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
		// 쿼리문 :  
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
