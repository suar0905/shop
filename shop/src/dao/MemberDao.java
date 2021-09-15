package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.ConnUtil;
import vo.Member;

public class MemberDao {
	
	// (6) [관리자] 검색된 회원의 수
	public int selectTotalMemberCount(String searchMemberId, int rowPerPage) throws ClassNotFoundException, SQLException {
		int searchTotalCount = 0;
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리생성 및 실행
		// 쿼리문 : member테이블에서 member_id가 ?(%searchMemberId%)가 포함될 때의 행의 개수를 구하여라.
		String sql = "SELECT count(*) FROM member WHERE member_id LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 -> " + stmt); 
		stmt.setString(1, "%" + searchMemberId + "%");
		
		ResultSet rs= stmt.executeQuery();
		System.out.println("[debug] rs 확인 -> " + rs);
		while(rs.next()) {
			searchTotalCount = rs.getInt("count(*)");
		}
		System.out.println("[debug] searchTotalCount 회원수 확인 -> " + searchTotalCount);

		return searchTotalCount;
	}
	
	// (5) [관리자] 회원 목록 출력(searchMemberId로 검색)
	public ArrayList<Member> selectMemberListAllBySearchMemberId(int beginRow, int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException{
		ArrayList<Member> list = new ArrayList<Member>();
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드 
		
		// 쿼리 생성 및 사용
		// 쿼리문 : member 테이블에서 member_id가 ?("%" + searchMemberId + "%")가 들어갈때, create_date 값이 내림차순으로 ?(beginRow)부터 ?(rowPerPage)까지 memberNo, memberId, memberLevel, memberAge, memberGender, updateDate, createDate 항목을 조회하여라.   
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id LIKE ? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 - > " + stmt);
		stmt.setString(1, "%" + searchMemberId + "%"); // ?의 값을 찾기위해 %?%를 사용한다.
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		System.out.println("[debug] rs 확인 - > " + rs);
		while(rs.next()) {
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
		System.out.println("[debug] list 확인 - > " + list);
		
		// 세션 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// (4) [관리자] 총 멤버회원 수
	public int totalMemberCount(int rowPerPage) throws ClassNotFoundException, SQLException {
		int totalCount = 0 ;
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드 
		
		// 쿼리 생성 및 실행
		// 쿼리문 : member테이블의 모든 행의 수를 구하여라.
		String sql = "SELECT count(*) FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 -> " + stmt); 
		
		ResultSet rs= stmt.executeQuery();
		System.out.println("[debug] rs 확인 -> " + rs);
		while(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		System.out.println("[debug] totalCount 회원수 확인 -> " + totalCount);

		return totalCount;
	}
		
	// (3) [관리자] 회원 목록 출력 코드
	public ArrayList<Member> selectMemberListAllByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		ArrayList<Member> list = new ArrayList<Member>();
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드 
		
		// 쿼리 생성 및 사용
		// 쿼리문 : member 테이블에서 create_date 값이 내림차순으로 ?(beginRow)부터 ?(rowPerPage)까지 memberNo, memberId, memberLevel, memberAge, memberGender, updateDate, createDate 항목을 조회하여라. 
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 - > " + stmt);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		System.out.println("[debug] rs 확인 - > " + rs);
		while(rs.next()) {
			// Member 객체 생성
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
		
		// 세션 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// (2) [회원] 로그인 메소드 코드
	// 로그인 성공시 리턴값 : Member를 리턴 -> memberId 와 memberPw를 리턴한다.
	// 로그인 실패시 리턴값 : Member를 리턴 -> null값을 리턴한다.
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		// MemberDao 패키지 안의 login메소드의 memberId(아이디) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] MemberDao.login param : memberId -> " + member.getMemberId());
		// MemberDao 패키지 안의 login메소드의 memberPw(비밀번호) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] MemberDao.login param : memberPw -> " + member.getMemberPw());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드 
		
		// 쿼리 생성 및 실행
		// 쿼리문 : member테이블에서 member_id값이 ?이고, member_pw값이 ?일때, memberNo, memberId, memberLevel, memberName 항목을 조회하여라.
		// Alias 생략
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt -> " + stmt); // 디버깅
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		
		ResultSet rs = stmt.executeQuery();
		System.out.println("[debug] rs -> " + rs);
		if(rs.next()) {
			// Member클래스의 returnMember변수 객체 생성
			Member returnMember = new Member();
			// 쿼리문을 통해 받아온 member_id, member_name값을 returnMember변수에 저장.
			returnMember.setMemberNo(rs.getInt("memberNo")); // 원래는 member_no인데 별칭 memberNo를 사용했기 때문에 memberNo를 적어준다. 
			returnMember.setMemberId(rs.getString("memberId")); // 원래는 member_id인데 별칭 memberId를 사용했기 때문에 memberId를 적어준다. 
			returnMember.setMemberLevel(rs.getInt("memberLevel")); // 원래는 member_level인데 별칭 memberLevel을 사용했기 때문에 memberLevel을 적어준다.
			returnMember.setMemberName(rs.getString("memberName")); // 원래는 member_name인데 별칭 memberName을 사용했기 때문에 memberName을 적어준다.
			return returnMember;
		} 
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return null;
	}
	
	// (1) [비회원] 회원가입 메소드 코드
	public int insertMember(Member member) throws ClassNotFoundException, SQLException {
		// MemberDao 패키지 안의 insertMember메소드의 memberId(아이디) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] MemberDao.insertMember param : memberId -> " + member.getMemberId());
		// MemberDao 패키지 안의 insertMember메소드의 memberPw(비밀번호) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] MemberDao.insertMember param : memberPw -> " + member.getMemberPw());
		// MemberDao 패키지 안의 insertMember메소드의 memberLevel(레벨) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] MemberDao.insertMember param : memberLevel -> " + member.getMemberLevel());
		// MemberDao 패키지 안의 insertMember메소드의 memberName(이름) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] MemberDao.insertMember param : memberName -> " + member.getMemberName());
		// MemberDao 패키지 안의 insertMember메소드의 memberAge(나이) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] MemberDao.insertMember param : memberAge -> " + member.getMemberAge());
		// MemberDao 패키지 안의 insertMember메소드의 memberGender(성별) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] MemberDao.insertMember param : memberGender -> " + member.getMemberGender());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		/* 쿼리 생성 및 실행
		   쿼리문 : member테이블에서 member_id, member_pw, member_level, member_name, member_age, member_gender, update_date, create_date 항목의 값을 ?,PASSWORD(?),0,?,?,?,now(),now()값으로 추가하여라.
		   PASSWORD(?) -> ?를 입력한 값이 암호화된다. */
		String sql = "INSERT INTO member(member_id, member_pw, member_level, member_name, member_age, member_gender, update_date, create_date) VALUES(?,PASSWORD(?),?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 -> + " + stmt); // 디버깅 코드
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setInt(3, member.getMemberLevel());
		stmt.setString(4, member.getMemberName());
		stmt.setInt(5, member.getMemberAge());
		stmt.setString(6, member.getMemberGender());
		
		int insertRs = stmt.executeUpdate();
		System.out.println("[debug] insertRs 확인 -> + " + insertRs); // 디버깅 코드
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return insertRs;
	}
}
