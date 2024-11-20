package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class UserInformation {

    @Id
    @Column(name = "USERNAME", length = 255, nullable = false)
    private String username;

    @Column(name = "EDUCATION", length = 255, nullable = false)
    private String education;

    @Column(name = "CAREER", length = 255, nullable = false)
    private String career;

    @Column(name = "SKILL", length = 255, nullable = false)
    private String skill;

    @Column(name = "PHOTO", length = 500, nullable = false)
    private String photo;

    @Column(name = "LOCATION", length = 255, nullable = false)
    private String location;

    @Column(name = "SALARY", length = 255, nullable = false)
    private Long salary;

    @Column(name = "JOB_TYPE", length = 255, nullable = false)
    private String jobType;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "USERNAME")
    private Member member;
}