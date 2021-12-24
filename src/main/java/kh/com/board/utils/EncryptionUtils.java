package kh.com.board.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptionUtils {

	//SHA-512를 통해 비밀번호를 암호화 해주는 메서드 생성
	public static String getSHA512(String pw) {
		// MessageDigest 클래스 인스턴스를 생성
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-512");
			// 인스턴스를 초기화해주는 작업
			md.reset();
			// 변환할 데이터를 utf-8 바이트코드로 변환 후 인스턴스에 추가 
			md.update(pw.getBytes("utf-8"));
			// 세팅해준 바이트코드로 변환된 원본 데이터를 128바이트의 문자로 변환
			pw = String.format("%0128x", new BigInteger(1,md.digest()));
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return pw;
	}
}
