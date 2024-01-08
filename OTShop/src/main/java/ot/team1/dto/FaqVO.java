package ot.team1.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class FaqVO {
	@NotEmpty(message = "")
	private int fseq;
	
	@NotEmpty(message = "카테고리를 선택하세요.")
	private int fcseq;
	
	private String name;
	
	@NotEmpty(message = "제목을 입력하세요.")
	private String title;
	
	@NotEmpty(message = "내용을 입력하세요.")
	private String content;
}
