package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.ConnUtil;
import vo.Member;

public class MemberDao {
	
	// (2) 로그인 메소드 코드
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
	
	// (1) 회원가입 메소드 코드
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
