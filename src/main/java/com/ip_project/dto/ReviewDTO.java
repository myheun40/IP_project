package com.ip_project.dto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ReviewDTO {
    private Long reviewIdx;
    private String reviewTitle;
    private String reviewContent;
    private LocalDateTime reviewDate;
    private String reviewCareer;
    private String reviewCompany;
    private String reviewPosition;
    private String result;
    private Long count;
    private String atmosphere;
    private String sorrow;
    private String advice;
    private String username;
    private String period;
    private String formatType;
    private List<IntroQuestionDTO> questions;


    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class IntroQuestionDTO {
        private Long introIdx;
        private String question; // List가 아니라 단일 String 값
        private String answer; // List가 아니라 단일 String 값
        private Long reviewIdx;
    }
}
