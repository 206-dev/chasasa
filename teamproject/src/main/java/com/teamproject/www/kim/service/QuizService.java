package com.teamproject.www.kim.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.www.kim.domain.Question;

import java.util.ArrayList;
import java.util.Arrays;

@Service
public class QuizService {
    private List<Question> questions;
    private int currentQuestionIndex;
    private int score;

    public QuizService() {
        this.questions = new ArrayList<>();
        this.currentQuestionIndex = 0;
        this.score = 0;

        // 샘플 문제
        questions.add(new Question("캠핑장에서 쓰레기는 반드시 되가져와야 한다?", true));
        questions.add(new Question("불 피울때는 역시 낙엽이 안전하고 최고죠?", false));
        questions.add(new Question("릴선은 감아서 사용하는게 안전하다?", false));
    }

    public Question getCurrentQuestion() {
        if (currentQuestionIndex < questions.size()) {
            return questions.get(currentQuestionIndex);
        } else {
            return null;
        }
    }

    public int getCurrentQuestionNumber() {
        return currentQuestionIndex + 1;
    }

    public int getTotalQuestions() {
        return questions.size();
    }

    public int getScore() {
        return score;
    }

    public void answerQuestion(boolean answer) {
        if (currentQuestionIndex < questions.size() && questions.get(currentQuestionIndex).isCorrectAnswer(answer)) {
            score++;
        }
        currentQuestionIndex++;
    }

    public boolean hasNextQuestion() {
        return currentQuestionIndex < questions.size();
    }

    public void resetQuiz() {
        currentQuestionIndex = 0;
        score = 0;
    }
}

