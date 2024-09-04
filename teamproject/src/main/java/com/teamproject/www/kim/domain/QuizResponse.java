package com.teamproject.www.kim.domain;

import lombok.Data;

@Data
public class QuizResponse {
    private String question;
    private int currentQuestionNumber;
    private int totalQuestions;
    private int score;
    private boolean hasNext;
    private String resultMessage;  // 결과 메시지
    private String resultLink;     // 결과 링크
    private String boardtype;  // 게시판 이름

    public QuizResponse(String question, int currentQuestionNumber, int totalQuestions, int score, boolean hasNext, String resultMessage, String resultLink, String boardtype) {
        this.question = question;
        this.currentQuestionNumber = currentQuestionNumber;
        this.totalQuestions = totalQuestions;
        this.score = score;
        this.hasNext = hasNext;
        this.resultMessage = resultMessage;
        this.resultLink = resultLink;
        this.boardtype = boardtype;
    }
}