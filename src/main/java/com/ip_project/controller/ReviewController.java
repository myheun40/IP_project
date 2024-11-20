package com.ip_project.controller;

import com.ip_project.dto.ReviewDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.ip_project.entity.Review;
import com.ip_project.service.ReviewService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;


@Controller
@RequestMapping("/review_board")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService service;

    @PostMapping("/write")
    public String writeReview(@ModelAttribute ReviewDTO reviewDTO, @AuthenticationPrincipal UserDetails userDetails) {
        service.saveReview(reviewDTO, userDetails.getUsername());
        return "redirect:/review_board/review_list";
    }

    @GetMapping("/review_list")
    public String list(Model model, @RequestParam(name = "page", defaultValue = "1") int pageNum) {
        service.list(model);

        int pageSize = 15; // 한 페이지당 게시글 수
        int totalCount = service.getTotalCount(); // 전체 게시글 수
        int totalPages = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수

        // 현재 페이지 그룹의 시작과 끝 페이지 계산
        int pageGroupSize = 10; // 페이지 그룹 크기
        int currentGroup = (int) Math.ceil((double) pageNum / pageGroupSize);
        int groupStart = (currentGroup - 1) * pageGroupSize + 1;
        int groupEnd = Math.min(currentGroup * pageGroupSize, totalPages);

        List<Review> list = service.getListByPage(pageNum, pageSize);

        model.addAttribute("list", list);
        model.addAttribute("currentPage", pageNum);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("groupStart", groupStart);
        model.addAttribute("groupEnd", groupEnd);
        model.addAttribute("pageGroupSize", pageGroupSize);

        return "review_board/review_list";
    }

    @GetMapping("/search")
    public String getReviews(
            @RequestParam(value = "orderBy", required = false, defaultValue = "all") String orderBy,
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            Model model
    ) {
        List<Review> reviews = service.getReviews(orderBy, keyword);
        model.addAttribute("list", reviews);
        return "review_board/review_list";  // redirect 제거
    }


    @GetMapping("/review_view/{idx}")
    public String reviewView(Model model, @PathVariable("idx") Long idx) {
        service.findById(idx, model);
        return "review_board/review_view";
    }

    @GetMapping("/review_write")
    public String write() {
        return "review_board/review_write";
    }

    @GetMapping("/get")
    @ResponseBody
    public Review get(@RequestParam Long idx) {
        return service.get(idx);
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Review vo) {
        service.register(vo);
        return "redirect:list";
    }

    @GetMapping("/remove/{idx}")
    public String removeReview(@PathVariable("idx") Long idx, RedirectAttributes redirectAttributes) {
        try {
            service.deleteReview(idx);
            redirectAttributes.addFlashAttribute("message", "리뷰가 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "리뷰 삭제 중 오류가 발생했습니다.");
            return "redirect:/error/500";
        }
        return "redirect:/review_board/review_list"; // 삭제 후 리뷰 리스트 페이지로 리다이렉트
    }


}