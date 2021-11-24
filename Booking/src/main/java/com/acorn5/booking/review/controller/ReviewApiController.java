package com.acorn5.booking.review.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.service.ReviewService;

@RestController
public class ReviewApiController {
	// by남기, 의존객체 DI 을 필드에 선언해둔다_210303
		@Autowired
		private ReviewService service;
		//by우석, navbar cartitem count 보이기위한 cartservice 주입_20210315
		@Autowired
		private CartService cartservice;

		// by남기, 글 목록 요청처리_210303
		@RequestMapping("/reviews")
		public Page<Review> list(ModelAndView mView ,HttpServletRequest request) {
			
			Long id=(Long)request.getSession().getAttribute("id");
			if(id!=null) {
			//by 우석, view page 에서 cartitem 불러오기_210315 
			//cartservice.listCart(request); 
			}
			
			return service.getList(request);
		}
}
