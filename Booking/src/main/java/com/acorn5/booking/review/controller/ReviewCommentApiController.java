package com.acorn5.booking.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.review.service.ReviewService;

@RestController
@RequestMapping("/v1")
public class ReviewCommentApiController {

	@Autowired
	private ReviewService reviewService;
	
	@CrossOrigin(methods = RequestMethod.PUT)
	@PutMapping(value = "/review/reply")
	public void update(@RequestBody ReviewDtl dto) {
		reviewService.updateComment(dto);
	}
	
	@DeleteMapping(value = "/review/reply/{id}")
	public void delete(@PathVariable Long id) {
		reviewService.deleteComment(id);
	}
}
