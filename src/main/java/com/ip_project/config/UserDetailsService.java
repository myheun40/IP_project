package com.ip_project.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ip_project.entity.CustomUser;
import com.ip_project.entity.Member;
import com.ip_project.repository.MemberRepository;

@Service
public class UserDetailsService implements org.springframework.security.core.userdetails.UserDetailsService {

    @Autowired
    private MemberRepository repository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            Member member = repository.findByUsername(username)
                    .orElseThrow(() -> new UsernameNotFoundException(username + " not found"));
            return new CustomUser(member);
        } catch (Exception e) {
            System.out.println("Error in loadUserByUsername: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
}