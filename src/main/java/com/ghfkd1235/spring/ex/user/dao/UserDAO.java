package com.ghfkd1235.spring.ex.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ghfkd1235.spring.ex.user.model.User;

@Repository
public interface UserDAO {

	//회원가입
	public int insertUser(
			@Param("loginId") String loginId
			, @Param("password") String password
			, @Param("name") String name
			, @Param("email") String email);
	
	
	//loginId 와 password가 일치하는 사용자 정보를 돌려주는 기능
	public User selectUser(
			@Param("loginId") String loginId
			, @Param("password") String password);
	
	
	//아이디 중복
	public int selectCountloginId(
			@Param("loginId") String loginId);
}
