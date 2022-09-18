package com.ghfkd1235.spring.ex.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptUtils {

	
	//암호화 기능
	public static String md5(String message) {
		String resultData = "";
		
		try {
			MessageDigest md = MessageDigest.getInstance("md5");
			
			//문자열 -> byte[]
			byte[] bytes = message.getBytes();
			md.update(bytes);
			
			//암호화된 결과 얻어오기
			byte[] digest = md.digest();
			
			//16진수 형태의 문자열로 변환
			for(int i = 0; i < digest.length; i++) {
				resultData += Integer.toHexString(digest[i] & 0xff);
			}
			
			
			
		} catch (NoSuchAlgorithmException e) {

			e.printStackTrace();
		}
		
		return resultData;
	}
}
