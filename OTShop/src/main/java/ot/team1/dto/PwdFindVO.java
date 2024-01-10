package ot.team1.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class PwdFindVO {
	
	@NotNull(message = "")
	private Integer pfseq;
	@NotEmpty(message = "아이디가 없습니다.")
	private String userid;
	@NotEmpty(message = "질문을 선택하세요.")
	private String kind;
	@NotEmpty(message = "질문 답변을 입력하세요.")
	private String answer;
}
