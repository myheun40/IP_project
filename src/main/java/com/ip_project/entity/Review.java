package com.ip_project.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@ToString(exclude = "questions")
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "REVIEW_SEQ")
    @SequenceGenerator(name = "REVIEW_SEQ", sequenceName = "REVIEW_SEQ", allocationSize = 1)
    @Column(name = "REVIEW_IDX", nullable = false)
    private Long reviewIdx;

    @Column(name = "REVIEW_TITLE", nullable = false, length = 255) // 제목
    private String reviewTitle;

    @Column(name = "REVIEW_CONTENT", nullable = true, length = 2000) //내용
    private String reviewContent;

    public String getFormattedReviewDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return reviewDate.format(formatter); // reviewDate를 "yyyy-MM-dd" 형식으로 변환
    }

    @Column(name = "REVIEW_DATE", nullable = false) //리뷰작성일
    private LocalDateTime reviewDate;

    @Column(name = "REVIEW_COMPANY", nullable = false, length = 255) //회사
    private String reviewCompany;

    @Column(name = "REVIEW_POSITION", nullable = false, length = 255) //직무
    private String reviewPosition;

    @Column(name = "REVIEW_RESULT", nullable = false, length = 255) //결과
    private String result;

    @Column(name = "REVIEW_PERIOD", nullable = true, length = 255) //지원 분기(20xx년 상반기/하반기)
    private String period;

    @Column(name = "REVIEW_ATMOSPHERE", nullable = true, length = 255) //면접 분위기
    private String atmosphere;

    @Column(name = "REVIEW_SORROW", nullable = true, length = 255) //아쉬운점
    private String sorrow;

    @Column(name = "REVIEW_ADVICE", nullable = true, length = 255) //조언
    private String advice;

    @Column(name = "REVIEW_COUNT", nullable = true, length = 255)
    private Long count;

//    @Column(name = "REVIEW_CAREER", nullable = true, length = 255) //경력
//    private String reviewCareer;

//    @Column(name = "REVIEW_PLACE", nullable = true, length = 255) //면접장소
//    private String place;

//    @Column(name = "REVIEW_PEOPLE", nullable = true, length = 255) //지원자수
//    private String people;

//    @Column(name = "REVIEW_TYPE", nullable = true, length = 255) //면접 유형
//    private String type;

//    @Column(name = "REVIEW_PROCESS", nullable = true, length = 255) //진행방식
//    private String process;

//    @Column(name = "REVIEW_REACTION", nullable = true, length = 255) //면접관 반응
//    private String reaction;


    @ManyToOne
    @JoinColumn(name = "USERNAME", referencedColumnName = "USERNAME")
    private Member member;

    @OneToMany(mappedBy = "review", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ReviewWrite> questions = new ArrayList<>();

    public void addQuestion(ReviewWrite question) {
        this.questions.add(question);
        question.setReview(this);
    }

    @PrePersist
    protected void onCreate() {
        this.reviewDate = LocalDateTime.now();  // 엔티티가 처음 생성될 때 현재 시간 설정
    }
}
