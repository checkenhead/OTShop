package ot.team1.dto;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.util.Date;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class MemberVO {
	
	@NotEmpty(message="아이디를 입력하세요!")
	private String userid;
	@NotEmpty(message="비밀번호를 입력하세요!")
	private String pwd;
	@NotEmpty(message="이름을 입력하세요!")
	private String name;
	@NotEmpty(message="성별을 선택하세요!")
	private String gender;
	@NotEmpty(message="생년월일을 입력하세요!")
	private String birthdate;
	@NotEmpty(message="전화번호를 입력하세요!")
	private String tel;
	@NotEmpty(message="이메일을 입력하세요!")
	private String email;
	
	private String zipnum;
	private String address1;
	private String address2;
	private String address3;
	private Date regdate;
	private String useyn;
	private String provider;
	
}
