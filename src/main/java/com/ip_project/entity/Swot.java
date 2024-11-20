package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Swot {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SWOT_SEQ")
    @SequenceGenerator(name = "SWOT_SEQ", sequenceName = "SWOT_SEQ", allocationSize = 1)
    @Column(name = "SWOT_IDX", nullable = true, length = 255)
    private Long swotIdx;

    @Column(name = "STRENGTH", nullable = true, length = 255)
    private String strength;

    @Column(name = "WEAKNESS", nullable = true, length = 255)
    private String weakness;

    @Column(name = "OPPORTUNITY", nullable = true, length = 255)
    private String opportunity;

    @Column(name = "THREAT", nullable = true, length = 255)
    private String threat;

    @ManyToOne
    @JoinColumn(name = "COMPANY_IDX", referencedColumnName = "COMPANY_IDX")
    private Company company;
}
