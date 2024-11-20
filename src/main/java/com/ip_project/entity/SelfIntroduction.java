package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "SELF_INTRODUCTION")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SelfIntroduction {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INTRO_SEQ")
    @SequenceGenerator(name = "INTRO_SEQ", sequenceName = "INTRO_SEQ", allocationSize = 1)
    @Column(name = "INTRO_IDX", nullable = true, length = 255)
    private Long introIdx;

    @Column(name = "INTRO_QUESTION", nullable = true, length = 1000)
    private String introQuestion;

    @Column(name = "INTRO_ANSWER", nullable = true, length = 2000)
    private String introAnswer;

    @ManyToOne
    @JoinColumn(name = "SELF_IDX", referencedColumnName = "SELF_IDX")
    private SelfBoard selfBoard;
}