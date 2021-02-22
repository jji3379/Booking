package com.acorn5.booking.review.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.review.dto.ReviewCommentDto;
import com.acorn5.booking.review.dto.ReviewDto;

public interface ReviewService {
	//새 리뷰를 저장하는 메소드 
	public void saveContent(ReviewDto dto);
	//글목록을 얻어오고 페이진 처리에 필요한 값들을 ModelAndView 객체에 담아주는 메소드 
	public void getList(ModelAndView mView, HttpServletRequest request);
	//글하나의 정보를 ModelAndView 객체에 담아주는 메소드
	public void getDetail(int num, ModelAndView mView);
	//글을 수정하는 메소드
	public void updateContent(ReviewDto dto);
	//글을 삭제하는 메소드
	public void deleteContent(int num);
	//댓글을 저장하는 메소드
	public void saveComment(HttpServletRequest request);
	public void deleteComment(HttpServletRequest request);//댓글 삭제
	public void updateComment(ReviewCommentDto dto);//댓글 수정
	public void moreCommentList(HttpServletRequest request);//댓글 추가 응답
}
