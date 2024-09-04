package com.teamproject.www.kim.domain;

import lombok.Data;

@Data
public class MainPageImageDto {
	private int boardNo;
    private String uploadPath;
    private String title;
    private int replyCount;
}
