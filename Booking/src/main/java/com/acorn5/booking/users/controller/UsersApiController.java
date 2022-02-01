package com.acorn5.booking.users.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.filter.LoginDto;
import com.acorn5.booking.pay.entity.Cart;
import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.users.dto.UserInfoDto;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.service.UsersService;

@RestController
@RequestMapping("/v1")
public class UsersApiController {
	
	@Autowired
	private UsersService usersService;

	@Autowired
	private CartService cartService;
	
	// 아이디 중복 확인 api
	@GetMapping(value = "/users/signup") // user-id/{loginId}
	public boolean isAvailableId(@RequestParam("loginId") String loginId) {
		
		return usersService.isExistId(loginId);
	}
	
	// 유저 회원 등록 api
	@PostMapping(value = "/users/signup") // user
	public Users insertUser(@RequestBody Users dto) {
		
		return usersService.addUser(dto);
	}
	
	
	// 로그인 처리 api
	@PostMapping(value = "/users/login") 
	public Users doLogin(HttpServletRequest request, HttpServletResponse response, @RequestBody LoginDto loginDto) {

		return usersService.loginLogic(request, response, loginDto);
	}

	// 유저 정보 조회 api
	@GetMapping(value = "/users/{id}") // user/{id}
	public UserInfoDto getUserinfo(@PathVariable Long id, Pageable pageable) {
		UserInfoDto userinfo = new UserInfoDto();
		usersService.getInfo(id);
		usersService.getMyReview(id, pageable);
		usersService.getMyCart(id, pageable);
		usersService.getMyReply(id, pageable);
		
		userinfo.setUser(usersService.getInfo(id));
		userinfo.setReview(usersService.getMyReview(id, pageable));
		userinfo.setReviewDtl(usersService.getMyReply(id, pageable));
		userinfo.setCart(usersService.getMyCart(id, pageable));
		
		return userinfo;
	}

	// 유저 리뷰 조회 api
	@GetMapping(value = "/users/review/{id}") // user/{id}/review
	public Page<Review> getUserReview(@PathVariable Long id, Pageable pageable) {
		
		return usersService.getMyReview(id, pageable);
	}

	// 유저 댓글 조회 api
	@GetMapping(value = "/users/reply/{id}") // user/{id}/reply
	public Page<ReviewDtl> getUserReply(@PathVariable Long id, Pageable pageable) {
		
		return usersService.getMyReply(id, pageable);
	}

	// 유저 장바구니 조회 api
	@GetMapping(value = "/users/cart/{id}") // user/{id}/cart
	public Page<Cart> getUserCart(@PathVariable Long id, Pageable pageable) {
		
		return usersService.getMyCart(id, pageable);
	}

	// 유저 최근 검색어 조회 api
	@GetMapping(value = "/users/search/{id}") // user/{id}/search
	public Page<Search> getUserSearch(@PathVariable Long id, Pageable pageable) {
		
		return usersService.getMySearch(id, pageable);
	}

	// 비밀번호 확인 api
	@GetMapping(value = "/users/pwdCheck/{id}") // user/{id}/pwd-check
	public boolean isSamePwd(@PathVariable Long id, String pwd) {
		
		return usersService.getPwd(id, pwd);
	}

	// 프로필 이미지 조회 api
	@GetMapping("/user/{id}/profile")
	public Users getProfile(@PathVariable Long id) {
		
		return usersService.getInfo(id);
	}

	// 프로필 이미지 삭제 api
	@DeleteMapping(value = "/users/{id}/profile") // user/{id}/profile
	public void deleteProfile(@PathVariable Long id) {
		
		usersService.deleteProfile(id);
	}

	// 최근 검색어 삭제 api
	@DeleteMapping(value = "/users/{id}/search/{searchId}") // users -> user
	public void deleteSearch(@PathVariable Long id, @PathVariable Long searchId) {
		
		usersService.deleteRecentSearch(searchId);
	}

	// 유저 장바구니 조회 api
	@GetMapping("/user/{id}/cart")
	public List<Cart> getCart(@PathVariable Long id) {
		
		return cartService.getCart(id);
	}
}
