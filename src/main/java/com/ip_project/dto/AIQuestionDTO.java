package com.ip_project.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AIQuestionDTO {
    private Long id;
    private String content;
    private Integer orderNumber;
    private String questionType;  // 추가
    private String answer;        // 추가
}