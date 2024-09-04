package com.teamproject.www.lee.domain.board;
import lombok.Data;

@Data
public class BoardListDto {
	private Integer boardno;
	private String title;
	private String nickname;
	private String regdate;
	private String newWrite;
	private Integer likes;
	private Integer views;
	private Integer replycount;
}
