package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "LIKE_COMPANY")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeCompany {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "LIKE_COMPANY_SEQ_GEN")
    @SequenceGenerator(name = "LIKE_COMPANY_SEQ_GEN", sequenceName = "LIKE_COMPANY_SEQ", allocationSize = 1)
    @Column(name = "LIKE_IDX")
    private Long likIdx;

    @ManyToOne
    @JoinColumn(name = "USERNAME", referencedColumnName = "USERNAME", nullable = false)
    private Member member;  // 관심 기업을 등록한 사용자

    @ManyToOne
    @JoinColumn(name = "COMPANY_IDX", referencedColumnName = "COMPANY_IDX", nullable = false)
    private Company company;  // 관심 등록된 기업
}