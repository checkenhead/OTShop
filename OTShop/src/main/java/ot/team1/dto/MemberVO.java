package ot.team1.dto;

import java.sql.Timestamp;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class MemberVO {
	
	@NotEmpty(message="아이디를 입력하세요")
	private String userid;
	@NotEmpty(message="비밀번호를 입력하세요")
	private String pwd;
	@NotEmpty(message="이름을 입력하세요")
	private String name;
	@NotEmpty(message="성별을 선택하세요")
	private String gender;
	// Timestamp = NotNull , String = NotEmpty
	@NotNull(message="생년월일을 입력하세요")
	private Timestamp birthdate;
	@NotEmpty(message="전화번호를 입력하세요")
	private String tel;
	@NotEmpty(message="이메일을 입력하세요")
	private String email;
	
	private String zipnum;
	private String address1;
	private String address2;
	private String address3;
	private Timestamp regdate;
	private String useyn;
	private String provider;
	

}
