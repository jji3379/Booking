package com.acorn5.booking.review.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;

public interface ReviewService {
	// by남기, 새 리뷰를 저장하는 메소드 _210303
	public Review saveContent(Review dto);
	// by남기, 글목록을 얻어오고 페이징 처리에 필요한 값들을 ModelAndView 객체에 담아주는 메소드 _210303
	public Page<Review> getList(HttpServletRequest request, Pageable pageable);

	public Page<Review> getConditionSearchList(HttpServletRequest request, Pageable pageable, String condition, String keyword);
	// by남기, 이미지를 저장하는 메소드_210303
	public String saveImage(MultipartFile image, HttpServletRequest request);
	// by남기, 리뷰를 수정하는 메소드_210303
	public void updateContent(Long id, Review dto);
	// by남기, 리뷰를 삭제하는 메소드_210303
	public void deleteContent(Long num);
	// by남기, 리뷰 하나의 정보를 ModelAndView 객체에 담아주는 메소드_210303
	public Review getDetail(Long num);
	
	// by남기, 댓글을 저장하는 메소드_210303
	public ReviewDtl saveComment(HttpServletRequest request);
	// by남기, 댓글 삭제_210303
	public void deleteComment(Long replyId);
	// by남기, 댓글 수정_210303
	public void updateComment(ReviewDtl dto);
	
	// by준익, 책 별 리뷰 조회
	public Page<Review> getBookReview(String isbn, Pageable pageable);

	// by준익, 책 별점 평균 조회
	public Double reviewAvgRating(String isbn);
	
	// by준익, 리뷰의 댓글 총 개수 조회
	public Long reviewTotalReply(Long refGroup);
}