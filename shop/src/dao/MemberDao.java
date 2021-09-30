package dao;

import java.sql.*;
import java.util.*;
import commons.*;
import vo.Member;

public class MemberDao {
	
	// (11) [관리자] 회원상세보기 코드
	public ArrayList<Member> selectMemberOne(int memberNo) throws ClassNotFoundException, SQLException {
		// selectMemberOne메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo param 확인 -> " + memberNo);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member 테이블에서 member_no가 ?(memberNo)일때, create_date 값을 내림차순으로 memberNo, memberId, memberLevel, memberAge, memberGender, updateDate, createDate 항목을 조회하여라.
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_no=? ORDER BY create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 11.1) Member 클래스 배열 객체 생성
		ArrayList<Member> list = new ArrayList<Member>();
		
		while(rs.next()) {
			// 11.2) Member 클래스 객체 생성
			Member returnMember = new Member();
			returnMember.setMemberNo(rs.getInt("memberNo"));
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(rs.getInt("memberLevel"));
			returnMember.setMemberName(rs.getString("memberName"));
			returnMember.setMemberAge(rs.getInt("memberAge"));
			returnMember.setMemberGender(rs.getString("memberGender"));
			returnMember.setUpdateDate(rs.getString("updateDate"));
			returnMember.setCreateDate(rs.getString("createDate"));
			list.add(returnMember);
		}
		System.out.println("[debug] list 확인 -> " + list);
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;			
	}
	
	// (10) [회원] 회원가입 전 중복 아이디 검사 코드
	public String selectMemberIdCheck(String memberIdCheck) throws ClassNotFoundException, SQLException {
		// selectMemberIdCheck메소드의 memberIdCheck 입력값 확인
		System.out.println("[debug] memberIdCheck param 확인 -> " + memberIdCheck);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member테이블에서 member_id가 ?(memberIdCheck)일때, memberId값을 구하여라.
		String sql = "SELECT member_id memberId FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberIdCheck);
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 쿼리 실행한 값을 저장하기 위한 변수(memberId) 생성
		String memberId = null;
		
		if(rs.next()) {
			memberId = rs.getString("memberId");
		}
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return memberId;
	}
	
	// (9) [관리자] 회원정보 삭제 코드
	public void deleteMemberByAdmin(Member member) throws ClassNotFoundException, SQLException {
		// deleteMemberByAdmin메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo param 확인 -> " + member.getMemberNo());
		// deleteMemberByAdmin메소드의 memberName 입력값 확인
		System.out.println("[debug] memberName param 확인 -> " + member.getMemberName());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member테이블에서 member_no가 ?(member.getMemberNo())이고 member_name이 ?(member.getMemberName())이면 데이터를 삭제하여라.
		String sql = "DELETE FROM member WHERE member_no=? AND member_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberNo());
		stmt.setString(2, member.getMemberName());
		System.out.println("[debug] stmt 확인 -> " + stmt); 
		
		// 쿼리 실행
		stmt.executeUpdate();
		
		// 기록 종료
		stmt.close();
		conn.close();
	}
	
	// (8) [관리자] 회원비밀번호 수정 코드
	public void updateMemberPwByAdmin(Member member, String memberNewPw) throws ClassNotFoundException, SQLException {
		// updateMemberPwByAdmin메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo param 확인 -> " + member.getMemberNo());
		// updateMemberPwByAdmin메소드의 memberNewPw 입력값 확인
		System.out.println("[debug] memberNewPw param 확인 -> " + memberNewPw);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member테이블에서 member_no가 ?(member.getMemberNo())일때, member_pw을 ?(memberNewPw)로 수정하여라.
		String sql = "UPDATE member SET member_pw=password(?) WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberNewPw);
		stmt.setInt(2, member.getMemberNo());
		System.out.println("[debug] stmt 확인 -> " + stmt); 
		
		// 쿼리 실행
		stmt.executeUpdate();
		
		// 기록 종료
		stmt.close();
		conn.close();
}
	
	// (7) [관리자] 회원등급 수정 코드
	public void updateMemberLevelByAdmin(Member member, int memberNewLevel) throws ClassNotFoundException, SQLException {
		// updateMemberLevelByAdmin메소드의 memberNo 입력값 확인
		System.out.println("[debug] memberNo param 확인 -> " + member.getMemberNo());
		// updateMemberLevelByAdmin메소드의 memberNewLevel 입력값 확인
		System.out.println("[debug] memberNewLevel param 확인 -> " + memberNewLevel);
				
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member테이블에서 member_no가 ?(member.getMemberNo())일때, member_level을 ?(memberNewLevel)로 수정하여라.
		String sql = "UPDATE member SET member_level=? WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNewLevel);
		stmt.setInt(2, member.getMemberNo());
		System.out.println("[debug] stmt 확인 -> " + stmt); 
		
		// 쿼리 실행
		stmt.executeUpdate();
		
		// 기록 종료
		stmt.close();
		conn.close();
	}
	
	// (6) [관리자] 검색된(searchMemberId) 회원의 수
	public int selectTotalMemberCount(String searchMemberId) throws ClassNotFoundException, SQLException {
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member테이블에서 member_id가 ?(%searchMemberId%)가 포함될 때의 행의 개수를 구하여라.
		String sql = "SELECT count(*) FROM member WHERE member_id LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchMemberId + "%");
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		//  searchMemberId로 검색된 총 데이터 개수 변수
		int searchTotalCount = 0;
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			searchTotalCount = rs.getInt("count(*)");
		}
		System.out.println("[debug] searchTotalCount 회원수 확인 -> " + searchTotalCount);
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return searchTotalCount;
	}
	
	// (5) [관리자] 검색된(searchMemberId) 회원목록 출력 코드
	public ArrayList<Member> selectMemberListAllBySearchMemberId(int beginRow, int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException {
		// (5.1) Member 클래스의 배열 객체 생성
		ArrayList<Member> list = new ArrayList<Member>();
		
		// selectMemberListAllBySearchMemberId메소드의 beginRow 입력값 확인
		System.out.println("[debug] beginRow param 확인 -> " + beginRow);
		// selectMemberListAllBySearchMemberId메소드의 rowPerPage 입력값 확인
		System.out.println("[debug] rowPerPage param 확인 -> " + rowPerPage);
		// selectMemberListAllBySearchMemberId메소드의 searchMemberId 입력값 확인
		System.out.println("[debug] searchMemberId param 확인 -> " + searchMemberId);
				
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member 테이블에서 member_id가 ?("%" + searchMemberId + "%")가 들어갈때, create_date 값이 내림차순으로 ?(beginRow)부터 ?(rowPerPage)까지 memberNo, memberId, memberLevel, memberAge, memberGender, updateDate, createDate 항목을 조회하여라.
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id LIKE ? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchMemberId + "%"); // ?의 값을 찾기위해 %?%를 사용한다.
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			// (5.2) Member 클래스 객체 생성
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// (4) [관리자] 회원목록 총 데이터 코드
	public int totalMemberCount() throws ClassNotFoundException, SQLException {
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member테이블의 총 데이터 수를 조회하여라.
		String sql = "SELECT count(*) FROM member";
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
	
	// (3) [관리자] 회원목록 출력 코드
	public ArrayList<Member> selectMemberListAllByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		// (3.1) Member 클래스 배열 객체 생성
		ArrayList<Member> list = new ArrayList<Member>();
		
		// selectMemberListAllByPage메소드의 beginRow 입력값 확인
		System.out.println("[debug] beginRow param 확인 -> " + beginRow);
		// selectMemberListAllByPage메소드의 rowPerPage 입력값 확인
		System.out.println("[debug] rowPerPage param 확인 -> " + rowPerPage);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member 테이블에서 create_date 값이 내림차순으로 ?(beginRow)부터 ?(rowPerPage)까지 memberNo, memberId, memberLevel, memberAge, memberGender, updateDate, createDate 항목을 조회하여라.
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			// (3.2) Member 클래스 객체 생성
			Member selectMember = new Member();
			selectMember.setMemberNo(rs.getInt("memberNo"));
			selectMember.setMemberId(rs.getString("memberId"));
			selectMember.setMemberLevel(rs.getInt("memberLevel"));
			selectMember.setMemberName(rs.getString("memberName"));
			selectMember.setMemberAge(rs.getInt("memberAge"));
			selectMember.setMemberGender(rs.getString("memberGender"));
			selectMember.setUpdateDate(rs.getString("updateDate"));
			selectMember.setCreateDate(rs.getString("createDate"));
			list.add(selectMember);
		}
		System.out.println("[debug] list 확인 -> " + list);
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// (2) [비회원] 로그인 메소드 코드
	// 로그인 성공 시 : memberId와 memberPw를 return
	// 로그인 실패 시 : null값 return
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		// login메소드의 memberId 입력값 확인
		System.out.println("[debug] memberId param 확인 -> " + member.getMemberId());
		// login메소드의 memberPw 입력값 확인
		System.out.println("[debug] memberPw param 확인 -> " + member.getMemberPw());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : member테이블에서 memberId가 ?(member.getMemberId())이고, memberPw가 ?(member.getMemberPw())일때, memberNo, memberId, memberLevel, memberName 값을 조회하여라.
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		// (2.1) Member 클래스 객체 생성 
		Member selectMember = null;
		
		if(rs.next()) {
			// selectMember변수에 쿼리문 조회 값들 저장
			selectMember = new Member();
			selectMember.setMemberNo(rs.getInt("memberNo"));
			selectMember.setMemberId(rs.getString("memberId"));
			selectMember.setMemberLevel(rs.getInt("memberLevel"));
			selectMember.setMemberName(rs.getString("memberName"));
			return selectMember;
		}
		System.out.println("[debug] selectMember 확인 -> " + selectMember);
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return null;
	}
	
	// (1) [비회원] 회원가입 메소드 코드
	public int insertMember(Member member) throws ClassNotFoundException, SQLException {
		// insertMember메소드의 memberId 입력값 확인
		System.out.println("[debug] memberId param 확인 -> " + member.getMemberId());
		// insertMember메소드의 memberPw 입력값 확인
		System.out.println("[debug] memberPw param 확인 -> " + member.getMemberPw());
		// insertMember메소드의 memberLevel 입력값 확인
		System.out.println("[debug] memberLevel param 확인 -> " + member.getMemberLevel());
		// insertMember메소드의 memberName 입력값 확인
		System.out.println("[debug] memberName param 확인 -> " + member.getMemberName());
		// insertMember메소드의 memberAge 입력값 확인
		System.out.println("[debug] memberAge param 확인 -> " + member.getMemberAge());
		// insertMember메소드의 memberGender 입력값 확인
		System.out.println("[debug] memberGender param 확인 -> " + member.getMemberGender());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 :
		String sql = "INSERT INTO member(member_id, member_pw, member_level, member_name, member_age, member_gender, update_date, create_date) VALUES(?,PASSWORD(?),?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setInt(3, member.getMemberLevel());
		stmt.setString(4, member.getMemberName());
		stmt.setInt(5, member.getMemberAge());
		stmt.setString(6, member.getMemberGender());
		System.out.println("[debug] stmt 확인 -> " + stmt);
		
		// 쿼리 실행
		int insertRs = stmt.executeUpdate();
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return insertRs;
	}
}