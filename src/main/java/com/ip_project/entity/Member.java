package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "MEMBER")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString  // 디버깅을 위해 추가
public class Member {
    @Id
    @Column(name = "IDX")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MEMBER_SEQ")
    @SequenceGenerator(name = "MEMBER_SEQ", sequenceName = "MEMBER_SEQ", allocationSize = 1)
    private Long idx;

    @Column(name = "USERNAME", unique = true)
    private String username;

    @Column(name = "PASSWORD", nullable = false, length = 100)
    private String password;

    @Column(name = "NAME", nullable = false, length = 100)
    private String name;

    @Column(name = "EMAIL", nullable = false, length = 40)
    private String email;

    @Column(name = "PHONE", nullable = true, length = 13)
    private String phone;

    @Column(name = "INDATE", nullable = false)
    private LocalDateTime indate;

}