package com.teamproject.www.kim.domain;

import lombok.Data;

@Data
public class Question {
    private String question;
    private boolean correctAnswer;

    public Question(String question, boolean correctAnswer) {
        this.question = question;
        this.correctAnswer = correctAnswer;
    }

    public String getQuestion() {
        return question;
    }

    public boolean isCorrectAnswer(boolean answer) {
        return correctAnswer == answer;
    }
}