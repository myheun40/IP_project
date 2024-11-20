package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AIQuestion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String content;
    private Integer orderNumber;
    private String answer;
    private String questionType;

    @Column(name = "VIDEO_URL", length = 500)  // 추가
    private String videoUrl;                    // 추가

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "interview_id")
    private AIInterview interview;
}