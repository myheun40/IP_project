package com.ip_project.repository;

import com.ip_project.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    @Query(value = """
            SELECT * FROM (
                SELECT a.*, ROWNUM rnum FROM (
                    SELECT * FROM REVIEW ORDER BY review_idx DESC
                ) a WHERE ROWNUM <= :endRow
            ) WHERE rnum > :startRow
            """, nativeQuery = true)
    List<Review> findByPage(@Param("startRow") int startRow, @Param("endRow") int endRow);

    List<Review> findByMemberUsername(@Param("username") String username);

    // 키워드를 기준으로 모든 리뷰를 검색
    @Query("SELECT r FROM Review r WHERE r.reviewCompany LIKE %:keyword%")
    List<Review> findAllByKeyword(@Param("keyword") String keyword);

    // 특정 합격 여부와 키워드를 기준으로 리뷰를 검색
    @Query("SELECT r FROM Review r WHERE r.result = :orderBy AND r.reviewCompany LIKE %:keyword%")
    List<Review> findByReviewResultAndKeyword(@Param("orderBy") String orderBy, @Param("keyword") String keyword);


}