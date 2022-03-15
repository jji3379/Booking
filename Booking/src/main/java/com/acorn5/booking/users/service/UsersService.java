package com.acorn5.booking.users.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.cart.entity.Cart;
import com.acorn5.booking.filter.LoginDto;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;

@Service
public interface UsersService {
	
	public Users addUser(Users users);

	public boolean isExistId(String signupId);

	public void loginformLogic(HttpServletRequest request,
			ModelAndView mView);

	public Users loginLogic(HttpServletRequest request,
			HttpServletResponse response, LoginDto loginDto);

	public Users getInfo(Long id);

	public void deleteUser(HttpSession session);

	public void updateUserPwd(ModelAndView mView, Users dto, HttpServletRequest request,
			HttpSession session);
	
	public boolean getPwd(Long id, String pwd);

	public void saveProfileImage(MultipartFile image, 
			HttpServletRequest request);

	public void updateUser(Users dto, HttpSession session);
	
	public Users getCareEmail(Long id);
	
	public void deleteProfile(Long id);
	
	public Page<Review> getMyReview(Long id, Pageable pageable);

	public Page<ReviewDtl> getMyReply(Long id, Pageable pageable);
	
	public Page<Cart> getMyCart(Long id, Pageable pageable);

	public Page<Search> getMySearch(Long id, Pageable pageable);
	
	public void deleteRecentSearch(Long id);
}
