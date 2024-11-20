package com.ip_project.entity;
import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

@Entity
@Data
@ToString(exclude = "review")
public class ReviewWrite {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INTRO_SEQ")
    @SequenceGenerator(name = "INTRO_SEQ", sequenceName = "INTRO_SEQ", allocationSize = 1)
    @Column(name = "WRITE_IDX")
    private Long introIdx;

    @Column(name = "WRITE_QUESTION")
    private String introQuestion;

    @Column(name = "WRITE_ANSWER")
    private String introAnswer;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "REVIEW_IDX")
    private Review review;
}