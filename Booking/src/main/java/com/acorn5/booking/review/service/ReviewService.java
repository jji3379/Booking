package com.acorn5.booking.review.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.dto.BookDto;
import com.acorn5.booking.review.dto.ReviewDto;

public interface ReviewService {
	// by남기._2021224

	//새 리뷰를 저장하는 메소드 
	public void saveContent(ReviewDto dto, HttpServletRequest request);
	//글목록을 얻어오고 페이징 처리에 필요한 값들을 ModelAndView 객체에 담아주는 메소드 
	public void getList(ModelAndView mView, HttpServletRequest request);
	//이미지를 저장하는 메소드
	public String saveImage(MultipartFile image, HttpServletRequest request);
	
}