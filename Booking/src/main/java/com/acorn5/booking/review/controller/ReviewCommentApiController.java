package com.acorn5.booking.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.review.repository.ReviewRepository;
import com.acorn5.booking.review.service.ReviewService;

@RestController
@RequestMapping("/v1")
public class ReviewCommentApiController {
	// by남기, 의존객체 DI 을 필드에 선언해둔다_210303
		@Autowired
		private ReviewService service;
		
		@Autowired
		private ReviewRepository reviewRepository;
		
		//by우석, navbar cartitem count 보이기위한 cartservice 주입_20210315
		@Autowired
		private CartService cartservice;

		@CrossOrigin(methods = RequestMethod.PUT)
		@RequestMapping(value = "/review/reply", method = RequestMethod.PUT)
		public void update(@RequestBody ReviewDtl dto) {
			// by남기, 수정할 리뷰의 정보를 dto에서 가져온다_210303
			service.updateComment(dto);
		}
		
		@RequestMapping(value = "/review/reply/{id}", method = RequestMethod.DELETE)
		public void delete(@PathVariable Long id) {
			// by남기, 삭제할 글 번호가 파라미터로 넘어온다_210303
			service.deleteComment(id);
		}
}
