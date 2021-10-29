package com.acorn5.booking.review.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.review.dto.ReviewCommentDto;
import com.acorn5.booking.review.dto.ReviewDto;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;

public interface ReviewService {
	// by남기, 새 리뷰를 저장하는 메소드 _210303
	public void saveContent(Review dto, HttpServletRequest request);
	// by남기, 글목록을 얻어오고 페이징 처리에 필요한 값들을 ModelAndView 객체에 담아주는 메소드 _210303
	public List<Review> getList(ModelAndView mView, HttpServletRequest request);
	// by남기, 이미지를 저장하는 메소드_210303
	public String saveImage(MultipartFile image, HttpServletRequest request);
	// by남기, 리뷰를 수정하는 메소드_210303
	public void updateContent(Review dto);
	// by남기, 리뷰를 삭제하는 메소드_210303
	public void deleteContent(Review num);
	// by남기, 리뷰 하나의 정보를 ModelAndView 객체에 담아주는 메소드_210303
	public void getDetail(Long num, ModelAndView mView);
	
	// by남기, 댓글을 저장하는 메소드_210303
	public void saveComment(HttpServletRequest request);
	// by남기, 댓글 삭제_210303
	public void deleteComment(HttpServletRequest request);
	// by남기, 댓글 수정_210303
	public void updateComment(ReviewDtl dto);
	// by남기, 댓글 추가 응답_210303
	public void moreCommentList(HttpServletRequest request);
	
	// by욱현, 내가 쓴 리뷰 모아보기 메소드_2021309
	public List<ReviewDto> getMyReview(HttpSession session, ModelAndView mView, HttpServletRequest request);
}