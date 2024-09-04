package com.teamproject.www.kim.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InformationCriteria {
    private int pageNum; // 페이지 번호
    private int amount; // 한 페이지 당 보여질 게시물 갯수
    private String type; // 검색항목(제목/내용/작성자)
    private String keyword; // 검색어(사용자 입력값)
    private String sort;
    private String category; // 카테고리

    public InformationCriteria() {
        this(1, 10); // 1페이지, 10개 (기본 페이지)
    }

    public InformationCriteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public String[] getTypeArr() {
        if (type != null) {
            return type.split("");
        }
        return null;
    }
}
