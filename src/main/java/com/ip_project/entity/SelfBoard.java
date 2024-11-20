package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "SELF_BOARD")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SelfBoard {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SELF_BOARD_SEQ")
    @SequenceGenerator(name = "SELF_BOARD_SEQ", sequenceName = "SELF_BOARD_SEQ", allocationSize = 1)
    @Column(name = "SELF_IDX", nullable = false, length = 255)
    private Long selfIdx;

    @Column(name = "SELF_TITLE", nullable = false, length = 255)
    private String selfTitle;

    @Column(name = "SELF_COMPANY", nullable = false, length = 255)
    private String selfCompany;

    @Column(name = "SELF_POSITION", nullable = false, length = 255)
    private String selfPosition;

    @Column(updatable = false, columnDefinition = "TIMESTAMP DEFAULT SYSTIMESTAMP")
    private LocalDateTime selfDate;

    @ManyToOne
    @JoinColumn(name = "USERNAME", referencedColumnName = "USERNAME")
    private Member member;

}