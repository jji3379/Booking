package com.acorn5.booking.review.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.service.ReviewService;
import com.acorn5.booking.users.entity.Users;

@RestController
@RequestMapping("/v1")
public class ReviewApiController {
	// by남기, 의존객체 DI 을 필드에 선언해둔다_210303
		@Autowired
		private ReviewService service;
		//by우석, navbar cartitem count 보이기위한 cartservice 주입_20210315
		@Autowired
		private CartService cartservice;

		// by남기, 글 목록 요청처리_210303
		@RequestMapping("/review")
		public Page<Review> list(HttpServletRequest request) {
			
			Long id=(Long)request.getSession().getAttribute("id");
			if(id!=null) {
			//by 우석, view page 에서 cartitem 불러오기_210315 
			//cartservice.listCart(request); 
			}
			
			return service.getList(request);
		}
		
		// by남기, 글 상세정보 요청처리_210303  
		@RequestMapping(value = "/review/{id}", method = RequestMethod.GET)
		public Review detail(@PathVariable Long id
				,HttpServletRequest request) {
			// by남기, 자세히 보여줄 글번호가 파라미터로 넘어온다_210303
			service.getDetail(id);
			Long loginId=(Long)request.getSession().getAttribute("id");
			
			if(loginId!=null) { //by 우석, view page 에서 cartitem 불러오기_210315
				//cartservice.listCart(mView, request); 
			}
			// by남기, view page 로 forward 이동해서 응답_210303
			//mView.setViewName("review/reviewDetail");
			return service.getDetail(id);
		}
		
		// by남기, 글 삭제 요청처리_210303
		@RequestMapping(value = "/review/{id}", method = RequestMethod.DELETE)
		public void delete(@PathVariable Long id) {
			// by남기, 삭제할 글 번호가 파라미터로 넘어온다_210303
			service.deleteContent(id);
			// by남기, view page 로 forward 이동해서 응답_210303
			//return "review/private/reviewDelete";
		}
		
		// by남기, 리뷰 수정 요청 처리_210303
		@RequestMapping(value = "/review/{id}", method = RequestMethod.PUT)
		public String update(@PathVariable("id") Long id, @RequestBody Review review) {
			// by남기, 수정할 리뷰의 정보를 dto에서 가져온다_210303
			service.updateContent(id, review);
			// by남기, view page 로 forward 이동해서 응답_210303
			return "review/private/reviewUpdate";
		}
		
		// by남기, 새 리뷰 작성 요청 처리_210303
		@RequestMapping(value = "/review", method = RequestMethod.POST)
		public ResponseEntity<Review> insert(@RequestBody Review dto, HttpServletRequest request) {
			Users users = new Users();
			Long loginId=(Long)request.getSession().getAttribute("id");
			users.setId(loginId);
			dto.setWriter(users);
			// by남기, 추가할 리뷰 정보가 파라미터로 넘어온다_210303
			Review saveReview = service.saveContent(dto);
			// by남기, view page 로 forward 이동해서 응답_210303
			return ResponseEntity.ok(saveReview);
		}
}
