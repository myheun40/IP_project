package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Data
@Entity
public class InterviewPro {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "IPRO_SEQ")
    @SequenceGenerator(name = "IPRO_SEQ", sequenceName = "IPRO_SEQ", allocationSize = 1)
    @Column(name = "IPRO_IDX", nullable = false)
    private Long iproIdx;

    @Column(name = "IPRO_QUESTION", length = 255, nullable = false)
    private String iproQuestion;

    @Column(name = "IPRO_ANSWER", length = 4000)
    private String iproAnswer;

    @Column(name = "CREATED_AT")
    @CreationTimestamp
    private LocalDateTime createdAt;

    @Column(name = "IPRO_TYPE")
    private String iproType; //직무 or 인성

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SELF_IDX", referencedColumnName = "SELF_IDX")
    private SelfBoard selfBoard;

    // getters and setters
    @ManyToOne
    @JoinColumn(name = "USERNAME", referencedColumnName = "USERNAME")
    private Member member;
}