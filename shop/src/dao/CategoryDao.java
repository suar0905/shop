package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import vo.*;
import commons.*;

public class CategoryDao {
	
	// (4) [관리자] 카테고리 사용 유무 수정 코드
	public void updateCategoryStateByAdmin(Category category) throws ClassNotFoundException, SQLException {
		// CategoryDao 패키지 안의 updateCategoryStateByAdmin메소드의 categoryName(카테고리 이름) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] CategoryDao.updateCategoryStateByAdmin param : categoryName -> " + category.getCategoryName());
		// CategoryDao 패키지 안의 updateCategoryStateByAdmin메소드의 categoryState(카테고리 상태) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] CategoryDao.updateCategoryStateByAdmin param : categoryState -> " + category.getCategoryState());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 : category 테이블에서 category_name 값이 ?(categoryName)일때, category_state 값을 ?(categoryState), update_date를 now()로 수정하여라.
		String sql = "UPDATE category SET category_state=?, update_date=now() WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 -> " + stmt); 
		stmt.setString(1, category.getCategoryState());
		stmt.setString(2, category.getCategoryName());
		
		// 쿼리 실행
		stmt.executeUpdate();
		
		// 기록 종료
		stmt.close();
		conn.close();
	}
	
	// (3) [관리자] 카테고리 추가 전 중복 카테고리 이름(categoryName) 검사 코드
	public String selectCategoryName(String categoryNameCheck) throws ClassNotFoundException, SQLException {
		// CategoryDao 패키지 안의 selectCategoryName메소드의 categoryNameCheck(중복카테고리이름 확인) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] CategoryDao.selectCategoryName param : categoryNameCheck -> " + categoryNameCheck);
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		String categoryName = null;
		// 쿼리 생성
		// 쿼리문 : category테이블에서 category_name가 ?(categoryNameCheck)일 때 categoryName 항목값을 구하여라.
		String sql = "SELECT category_name categoryName FROM category WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 -> " + stmt);
		stmt.setString(1, categoryNameCheck);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			categoryName = rs.getString("categoryName");
		}
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return categoryName; // memberId가 null이 나오면 사용가능한 id이다.
	}
	
	// (2) [관리자] 카테고리 추가 코드
	public int insertCategory(Category category) throws ClassNotFoundException, SQLException {
		// CategoryDao 패키지 안의 insertMember메소드의 categoryName(카테고리이름) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] CategoryDao.insertMember param : categoryName -> " + category.getCategoryName());
		// CategoryDao 패키지 안의 insertMember메소드의 categoryState(카테고리사용유무) 입력값,  param은 입력값을 의미한다.
		System.out.println("[debug] CategoryDao.insertMember param : categoryState -> " + category.getCategoryState());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성 
		// 쿼리문 : 카테고리 테이블의 categoryName, updateDate, createDate, categoryState에다 ?,now(),now(),? 값을 추가하여라.
		String sql = "INSERT INTO category(category_name, update_date, create_date, category_state) VALUES(?,now(),now(),?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 - > " + stmt);
		stmt.setString(1, category.getCategoryName());
		stmt.setString(2, category.getCategoryState());
		
		int insertRs = stmt.executeUpdate();
		System.out.println("[debug] insertRs 확인 -> + " + insertRs); // 디버깅 코드
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return insertRs;
	}
	
	
	// (1) [관리자] 카테고리 목록 출력 코드
	public ArrayList<Category> selectCategoryListAllByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		
		ArrayList<Category> list = new ArrayList<Category>();
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성 
		// 쿼리문 : category테이블에서 create_date값을 내림차순으로 ?(beginRow)부터 ?(rowPerPage)까지 categoryName, updateDate, createDate항목의 값을 조회하여라.
		String sql = "SELECT category_name categoryName, update_date updateDate, create_date createDate, category_state categoryState FROM category ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("[debug] stmt 확인 - > " + stmt);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		System.out.println("[debug] rs 확인 - > " + rs);
		while(rs.next()) {
			// Category 클래스 객체 생성
			Category category = new Category();
			category.setCategoryName(rs.getString("categoryName"));
			category.setUpdateDate(rs.getString("updateDate"));
			category.setCreateDate(rs.getString("createDate"));
			category.setCategoryState(rs.getString("categoryState"));
			list.add(category);
		}
		
		// 기록 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
