package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
public class Company {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "COMPANY_SEQ")
    @SequenceGenerator(name = "COMPANY_SEQ", sequenceName = "COMPANY_SEQ", allocationSize = 1)
    @Column(name = "COMPANY_IDX", nullable = false, length = 255)
    private Long companyIdx;

    @Column(name = "COMPANY_NAME", nullable = true, length = 255)
    private String companyName;

    @Column(name = "COMPANY_CEO", nullable = true, length = 255)
    private String companyCeo;


    @Column(name = "COMPANY_HISTORY", nullable = true, length = 4000)
    private String companyHistory;

    @Column(name = "COMPANY_INDUSTRY", nullable = true, length = 255)
    private String companyIndustry;

    @Column(name = "COMPANY_TYPE", nullable = true, length = 255)
    private String companyType;

    @Column(name = "COMPANY_EMPLOYEES", nullable = true, length = 255)
    private Integer companyEmployees;

    @Column(name = "COMPANY_ADDRESS", nullable = true, length = 255)
    private String companyAddress;

    @Column(name = "COMPANY_HOMEPAGE", nullable = true, length = 255)
    private String companyHomepage;

    @Column(name = "COMPANY_CONTENT", length = 4000)
    private String companyContent;

    @Column(name = "IMG", nullable = true, length = 4000)
    private String img;

    @Column(name = "COMPANY_DATE", columnDefinition = "TIMESTAMP DEFAULT SYSTIMESTAMP")
    private LocalDateTime companyDate;

}
