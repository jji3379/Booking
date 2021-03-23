package com.acorn5.booking.users.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.exception.DBFailException;
import com.acorn5.booking.users.dto.UsersDto;

@Repository
public class UsersDaoImpl implements UsersDao {
	
    //by욱현.빈에서 SqlSession 객체를 DI해오기 위해 준비시킨다__2021222
	@Autowired
	private SqlSession session;
	
	//by욱현.개인정보의 프로필사진을 업로드_2021222
	@Override
	public void updateProfile(UsersDto dto) {
		session.update("users.updateProfile", dto);
	}
	
	//by욱현.아이디 중복 여부 검사관련 sql실행문_2021222
	@Override
	public boolean isExist(String id) {
		UsersDto dto=session.selectOne("users.isExist", id);
		if(dto==null) {
			return false;
		}else {
			return true;
		}
	}
	
	//by욱현.비밀번호 변경_2021222
	@Override
	public boolean updatePwd(UsersDto dto) {
		int count=session.update("users.updatePwd", dto);
		if(count==0) {
			return false;
		}else {
			return true;
		}
	}

	//by욱현.개인정보의 이메일, 관심사 수정 _2021222
	@Override
	public void update(UsersDto dto) {
		session.update("users.update", dto);
	}

	//by욱현.회원탈퇴_2021222
	@Override
	public void delete(String id) {
		session.delete("users.delete", id);
	}

	//by욱현.회원정보 dto 얻기_2021222
	@Override
	public UsersDto getData(String id) {
		UsersDto dto=session.selectOne("users.getData", id);
		if(dto==null) {
			throw new DBFailException("아이디가 없습니다."); 
		} //by욱현.미등록 아이디에 관한 예외처리 수정_21320
		return dto; 
	}

	//by욱현.회원가입시 아이디중복검사_2021222
	@Override
	public boolean isValid(UsersDto dto) {
		String id=session.selectOne("users.isValid", dto);
		if(id==null) { //잘못된 아이디와 비밀번호
			return false;
		}else {//유효한 아이디와 비밀번호 
			return true;
		}
	}
	
	//by욱현.회원가입 insert문 실행_2021222
	@Override
	public void insert(UsersDto dto) {
		session.insert("users.insert", dto);
	}
	
	//by욱현.최근검색어 유저의 recentsearch칼럼에 추가_2021308
	@Override
	public void searchInput(UsersDto dto) {
		session.update("users.searchInput", dto);
	}

	@Override
	public String getPwd(String id) {
		String pwd=session.selectOne("users.getPwd",id);
		return pwd;
	}

	@Override
	public UsersDto getCareEmail(String inputId) {
		UsersDto dto = session.selectOne("users.getData", inputId);
		return dto;
	}

}