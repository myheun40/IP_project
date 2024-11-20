package com.ip_project.entity;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
    private Member member;

    public CustomUser(Member member) {
        super(
                member != null ? member.getUsername() : "",
                member != null ? member.getPassword() : "",
                AuthorityUtils.createAuthorityList("ROLE_USER") // 모든 사용자에게 기본 "ROLE_USER" 권한 부여
        );
        this.member = member;
    }


    // 기본 생성자
    public CustomUser() {
        super("", "", AuthorityUtils.createAuthorityList("ROLE_USER"));
    }
}