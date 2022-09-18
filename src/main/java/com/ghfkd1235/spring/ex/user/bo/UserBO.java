package com.ghfkd1235.spring.ex.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ghfkd1235.spring.ex.common.EncryptUtils;
import com.ghfkd1235.spring.ex.user.dao.UserDAO;
import com.ghfkd1235.spring.ex.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	
	public int addUser(String loginId, String password, String email, String name) {
		
		//비밀번호 암호화
		String encryptPassword = EncryptUtils.md5(password);
		
		return userDAO.insertUser(loginId, encryptPassword, name, email);
	}
	
	//아이디 패스워드로 사용자 조회
	public User getUser(String loginId, String password) {
		
		String encryptPassword = EncryptUtils.md5(password);
		
		return userDAO.selectUser(loginId, encryptPassword);
	}
	
	//id 중복여부를 알려주는 기능
	public boolean isDuplicate(String loginId) {
		int count = userDAO.selectCountloginId(loginId);
		
//		if(count == 0) {
//			return false;
//		} else {
//			return true;
//		}
		
		return count != 0;
		
	}
}
