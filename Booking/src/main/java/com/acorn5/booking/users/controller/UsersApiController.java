package com.acorn5.booking.users.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.acorn5.booking.filter.LoginDto;
import com.acorn5.booking.pay.entity.Cart;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.service.UsersService;

@RestController
@RequestMapping("/v1")
public class UsersApiController {
	
	@Autowired
	private UsersService usersService;
	
	@RequestMapping(value = "/users/login", method = RequestMethod.POST)
	public Users login(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoginDto loginDto) {
		//로그인에 관련된 로직을 서비스를 통해서 처리한다.
		//usersService.loginLogic(request, response, loginDto);
		//view page  로 forward  이동해서 응답
		return usersService.loginLogic(request, response, loginDto);
	}
	
	@RequestMapping(value = "/users/signup", method = RequestMethod.GET)
	public boolean signup (@RequestParam("loginId") String loginId) {
		return usersService.isExistId(loginId);
	}
	
	@RequestMapping(value = "/users/signup", method = RequestMethod.POST)
	public Users signup(@RequestBody Users dto) {
		//usersService.addUser(dto);
		return usersService.addUser(dto);
	}

	// 나의 리뷰 조회
	@RequestMapping(value = "/users/review/{id}", method = RequestMethod.GET)
	public Page<Review> myReview(@PathVariable Long id, Pageable pageable) {
		return usersService.getMyReview(id, pageable);
	}
	
	// 나의 리뷰 조회
	@RequestMapping(value = "/users/reply/{id}", method = RequestMethod.GET)
	public Page<ReviewDtl> myReply(@PathVariable Long id, Pageable pageable) {
		return usersService.getMyReply(id, pageable);
	}

	// 나의 리뷰 조회
	@RequestMapping(value = "/users/cart/{id}", method = RequestMethod.GET)
	public Page<Cart> myCart(@PathVariable Long id, Pageable pageable) {
		return usersService.getMyCart(id, pageable);
	}

	// 나의 리뷰 조회
	@RequestMapping(value = "/users/search/{id}", method = RequestMethod.GET)
	public Page<Search> mySearch(@PathVariable Long id, Pageable pageable) {
		return usersService.getMySearch(id, pageable);
	}

	@RequestMapping(value = "/users/pwd/{id}", method = RequestMethod.GET)
	public String getPwd(@PathVariable Long id) {
		return usersService.getPwd(id);
	}
	
}
