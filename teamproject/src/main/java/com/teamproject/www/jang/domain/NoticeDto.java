package com.teamproject.www.jang.domain;

import lombok.Data;

import java.util.Date;
import java.util.concurrent.TimeUnit;

@Data
public class NoticeDto {
    private Long boardNo;
    private String title;
    private String content;
    private String nickname;
    private Date regdate;
    private int views;
    private boolean newPost;

    public void calcNewPost() {
    	long diffInMillis = System.currentTimeMillis() - regdate.getTime();
        long diffInDays = TimeUnit.MILLISECONDS.toDays(diffInMillis);
        System.out.println("diffInDays: " + diffInDays);
        this.newPost = diffInDays <= 1; // 1일 이내인 경우 newPost를 true로 설정
    }
}

