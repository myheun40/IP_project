package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
public class InterviewBoard {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INTERVIEW_BOARD_SEQ")
    @SequenceGenerator(name = "INTERVIEW_BOARD_SEQ", sequenceName = "INTERVIEW_BOARD_SEQ", allocationSize = 1)
    @Column(name = "INTERVIEW_IDX", nullable = false)
    private Long interviewIdx;

    @Column(name = "INTERVIEW_TITLE", nullable = false)
    private String interviewTitle;

    @Column(name = "INTERVIEW_DATE")
    private LocalDateTime interviewDate;

    @ManyToOne
    @JoinColumn(name = "SELF_IDX", referencedColumnName = "SELF_IDX")
    private SelfBoard selfBoard;

    @PrePersist
    protected void onCreate() {
        this.interviewDate= LocalDateTime.now();
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

}