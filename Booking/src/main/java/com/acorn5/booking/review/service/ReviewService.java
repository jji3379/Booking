package com.acorn5.booking.review.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.acorn5.booking.review.dto.ReviewListDto;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;

public interface ReviewService {
	public Review saveContent(Review dto);

	public Page<ReviewListDto> getList(HttpServletRequest request, Pageable pageable);

	public Page<ReviewListDto> getConditionSearchList(HttpServletRequest request, Pageable pageable, String condition,
			String keyword);

	public String saveImage(MultipartFile image, HttpServletRequest request);

	public void updateContent(Long id, Review dto);

	public void deleteContent(Long num);

	public Review getDetail(Long num);

	public ReviewDtl saveComment(HttpServletRequest request);

	public void deleteComment(Long replyId);

	public void updateComment(ReviewDtl dto);

	public Page<Review> getBookReview(String isbn, Pageable pageable);

	public Double reviewAvgRating(String isbn);

	public Long reviewTotalReply(Long refGroup);
}