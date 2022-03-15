package com.acorn5.booking.review.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.service.ReviewService;
import com.acorn5.booking.users.entity.Users;

@RestController
@RequestMapping("/v1")
public class ReviewApiController {

	@Autowired
	private ReviewService service;

	// 전체 리뷰 조회 api
	@GetMapping(value = "/reviews") 
	public Page<Review> getReviewList(HttpServletRequest request, Pageable pageable) {
		
		return service.getList(request, pageable);
	}

	// 리뷰 검색 조회 api
	@GetMapping(value = "/review/{condition}/{keyword}")
	public Page<Review> getSearchReview(HttpServletRequest request, Pageable pageable,
			@PathVariable String condition, @PathVariable String keyword) {
		
		return service.getConditionSearchList(request, pageable, condition, keyword);
	}
	
	// 리뷰 등록 api
	@PostMapping(value = "/review")
	public ResponseEntity<Review> insertReview(@RequestBody Review dto, HttpServletRequest request) {
		Users users = new Users();
		Long loginId = (Long) request.getSession().getAttribute("id");
		users.setId(loginId);
		dto.setWriter(users);
		
		Review saveReview = service.saveContent(dto);
		
		return ResponseEntity.ok(saveReview);
	}
	
	// 리뷰 디테일 조회 api
	@GetMapping(value = "/review/{id}")
	public Review getReviewDetail(@PathVariable Long id, HttpServletRequest request) {
	
		return service.getDetail(id);
	}
	
	// 리뷰 수정 api
	@CrossOrigin(methods = RequestMethod.PUT)
	@PutMapping(value = "/review/{id}")
	public void updateReview(@PathVariable("id") Long id, @RequestBody Review review) {
		service.updateContent(id, review);
	}
	
	// 리뷰 삭제 api
	@DeleteMapping(value = "/review/{id}")
	public void deleteReview(@PathVariable Long id) {
		service.deleteContent(id);
	}
	
	// by준익, 글 상세정보 요청처리_210303  
	@RequestMapping(value = "/review/{isbn}/rating", method = RequestMethod.GET)
	public String reviewAvgRating(@PathVariable String isbn) {
		return String.format("%.1f", service.reviewAvgRating(isbn));
	}
	
}
