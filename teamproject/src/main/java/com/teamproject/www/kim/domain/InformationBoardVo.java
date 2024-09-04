package com.teamproject.www.kim.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@ToString
public class InformationBoardVo {
    private Long boardNo;
    private String title;
    private String content;
    private String userid;
    private String nickname;
    private Integer boardTypeNo;
    private Date regdate;
    private Date updatedate;
    private Long views;
    private Long likes;
    private Long replycount;
    private String category;
    
    private String boardtype; // boardtype 컬럼과 매핑
    
    //어떤 키워드에 의해 선정되었는지 확인
    private String matchingKeyword;

    // 일간 best 용
    private String boardName;
    private String tbNo; 
    private String tbTitle; 
    private String tbViews; 
    private String tbBoardType; 
    
    // 첨부파일
    private List<AttachBoardDto> attachList;
}
