package com.ip_project.service;

import com.ip_project.entity.Company;
import com.ip_project.entity.LikeCompany;
import com.ip_project.entity.Member;
import com.ip_project.repository.LikeCompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LikeCompanyService {

    @Autowired
    private LikeCompanyRepository likeCompanyRepository;

    @Autowired
    private MemberService memberService;

    @Autowired
    private CompanyService companyService;

    // "좋아요" 등록/해제 처리 메서드
    public String toggleLikeCompany(String username, Long companyIdx) {
        Member member = memberService.findByUsername(username);
        Company company = companyService.get(companyIdx);

        if (member == null) {
            throw new RuntimeException("회원 정보가 잘못되었습니다.");
        }
        if (company == null) {
            throw new RuntimeException("기업 정보가 잘못되었습니다.");
        }

        if (likeCompanyRepository.existsByMemberAndCompany(member, company)) {
            // 이미 좋아요 한 경우 해제
            LikeCompany likeCompany = likeCompanyRepository.findByMemberAndCompany(member, company);
            likeCompanyRepository.delete(likeCompany);
            return "관심기업에서 성공적으로 삭제되었습니다.";
        } else {
            // 좋아요 등록
            LikeCompany likeCompany = new LikeCompany();
            likeCompany.setMember(member);
            likeCompany.setCompany(company);
            likeCompanyRepository.save(likeCompany);
            return "관심기업이 성공적으로 등록되었습니다!";
        }
    }

    // 사용자가 등록한 관심 기업 리스트를 조회
    public List<LikeCompany> getFavoriteCompanies(String username) {
        Member member = memberService.findByUsername(username);
        return likeCompanyRepository.findByMember(member);
    }


    // 관심 기업 삭제 메서드
    public void removeFavoriteCompany(String username, Long companyIdx) {
        Member member = memberService.findByUsername(username);
        Company company = companyService.get(companyIdx);

        if (member != null && company != null) {
            LikeCompany likeCompany = likeCompanyRepository.findByMemberAndCompany(member, company);
            if (likeCompany != null) {
                likeCompanyRepository.delete(likeCompany);
            }
        }
    }

    // 특정 회원이 특정 기업을 좋아요 했는지 확인하는 메서드
    public boolean hasLikedCompany(String username, Long companyIdx) {
        Member member = memberService.findByUsername(username);
        Company company = companyService.get(companyIdx);
        return likeCompanyRepository.existsByMemberAndCompany(member, company);
    }
}