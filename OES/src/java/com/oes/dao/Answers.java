package com.oes.dao;

public class Answers {
    private int answerId, examId, questionId;
    private String question, answer, correctAnswer, status;

    public Answers(int answerId, int examId, int questionId, String question, String answer, String correctAnswer, String status) {
        this.answerId = answerId;
        this.examId = examId;
        this.questionId = questionId;
        this.question = question;
        this.answer = answer;
        this.correctAnswer = correctAnswer;
        this.status = status;
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public int getExamId() {
        return examId;
    }

    public void setExamId(int examId) {
        this.examId = examId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
