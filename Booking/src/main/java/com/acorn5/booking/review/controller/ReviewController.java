package com.acorn5.booking.review.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.review.dto.ReviewDto;
import com.acorn5.booking.review.service.ReviewService;

@Controller
public class ReviewController {
	// by남기._2021224
	
	//의존객체 DI 을 필드에 선언해둔다.
	@Autowired
	private ReviewService service;
	
	//글 목록 요청처리
	@RequestMapping("/review/list")
	public ModelAndView list(ModelAndView mView, 
			HttpServletRequest request) {
		service.getList(mView, request);
		mView.setViewName("review/list");
		return mView;
	}
	
	//새 리뷰 글쓰기 요청 처리
	@RequestMapping("/review/private/insertform")
	public String insertform() {
		// /WEB-INF/views/    Review/private/insertform      .jsp 
		return "review/private/insertform";
	}
	
	@RequestMapping(value = "/review/private/insert", method = RequestMethod.POST)
	public String insert(ReviewDto dto, HttpServletRequest request) {
		service.saveContent(dto, request);
		return "redirect:/review/list.do";
	}
	
	
}