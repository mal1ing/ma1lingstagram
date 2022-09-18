package com.ghfkd1235.spring.ex.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ghfkd1235.spring.ex.user.bo.UserBO;
import com.ghfkd1235.spring.ex.user.model.User;

@RestController // @Controller + @ResponseBody
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	//회원가입 기능
	@PostMapping("/signup")
	public Map<String, String> signup(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, @RequestParam("name") String name
			, @RequestParam("email") String email){
		
		int count = userBO.addUser(loginId, password, email, name);
		
//		성공시 {"result" : "success"}
//		실패시 {"result" : "fail"}
		
		Map<String, String> result = new HashMap<>();
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	//로그인 과정을 진행하는 기능
	@PostMapping("/signin")
	public Map<String, String> signIn(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, HttpServletRequest request){
		
		User user = userBO.getUser(loginId, password);
		
		Map<String, String> result = new HashMap<>();
		if(user != null) { //성공
			result.put("result", "success");
			
			HttpSession session = request.getSession();
			// 사용자 이름 저장
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
			
		} else { // 로그인 실패
			result.put("result", "fail");
		}
		return result;
	}
	
	
	//id 중복 체크 api
	@GetMapping("/duplicate_id")
	@ResponseBody
	public Map<String, Boolean> isDuplicate(
			@RequestParam("loginId") String loginId) {
		
		boolean isDuplicate = userBO.isDuplicate(loginId);
		
		Map<String, Boolean> result = new HashMap<>();
		//Boolean 은 디폴트가 true false라 그냥 그 값만 적는다
		if(isDuplicate) {
			result.put("id_duplicate", true);
		} else {
			result.put("id_duplicate", false);
		}
		
		return result;
	}
	
}
