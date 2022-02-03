package com.acorn5.booking.users.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.filter.LoginDto;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.UsersRepository;
import com.acorn5.booking.users.service.UsersService;

@Controller
public class UsersViewController {
	
	@Autowired
	private UsersService usersService;
	
	// by욱현. 개인 정보 수정 요청 처리_2021222
	@RequestMapping(value = "/users/private/update", method = RequestMethod.POST)
	public String update(Users dto, HttpSession session, ModelAndView mView) {
		usersService.updateUser(dto, session);
		
		return "users/private/update";
	}

	// by욱현.개인정보 수정폼 요청 처리_2021222
	@RequestMapping("/user/{id}/account")
	public ModelAndView updateform(ModelAndView mView, HttpServletRequest request, @PathVariable Long id) {
		Users userDetail = usersService.getInfo(id);

		mView.addObject("dto", userDetail);
		mView.addObject("care", userDetail.getCare());
		mView.setViewName("users/private/updateform.page");
		
		return mView;
	}

	// by욱현.프로필 이미지 업로드 요청 처리_2021222
	@RequestMapping("/users/private/profile_upload")
	public String profile_upload(MultipartFile image, HttpServletRequest request) {
		usersService.saveProfileImage(image, request);

		return "redirect:/users/private/updateform.do";
	}

	// by욱현.비밀번호 수정 요청 처리_2021222
	@RequestMapping("/users/private/pwd_update")
	public String pwd_update(ModelAndView mView, Users dto, HttpServletRequest request, HttpSession session) {
		usersService.updateUserPwd(mView, dto, request, session);
		
		return "users/private/pwd_update";
	}

	// by욱현.비밀번호 수정 폼 요청 처리_2021222
	@RequestMapping("/user/{id}/pwd")
	public ModelAndView pwd_updateform(ModelAndView mView, HttpServletRequest request, @PathVariable Long id) {
		Users dto = usersService.getInfo(id);
		
		mView.addObject("dto", dto);
		mView.setViewName("users/private/pwd_updateform.page");
		
		return mView;
	}

	// by욱현.회원 탈퇴 요청 처리_2021222
	@RequestMapping("/users/private/delete")
	public String delete(HttpSession session) {
		usersService.deleteUser(session);
		
		return "users/private/delete";
	}

	// by욱현.개인정보 보기 요청처리_2021222
	@RequestMapping("/user/{id}/info")
	public ModelAndView info(ModelAndView mView, HttpServletRequest request, Pageable pageable, @PathVariable Long id) {
		mView.addObject("reviewCount", usersService.getMyReview(id, pageable).getNumberOfElements());
		mView.setViewName("users/private/info.page");
		
		return mView;
	}

	// by욱현.로그 아웃 요청 처리_2021222
	@RequestMapping("/users/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("id"); // 세션에서 id 삭제
		session.removeAttribute("loginId"); // 세션에서 id 삭제
		
		return "users/logout";
	}

	@RequestMapping(value = "/user/login", method = RequestMethod.POST)
	public void login(HttpServletRequest request, HttpServletResponse response, LoginDto loginDto) throws IOException {
		usersService.loginLogic(request, response, loginDto);

		String url = request.getParameter("url");
		String query = request.getQueryString();
		String encodedUrl = null;
		if (query == null) {// 전송 파라미터가 없다면
			encodedUrl = URLEncoder.encode(url);
		} else {
			encodedUrl = URLEncoder.encode(url + "?" + query);
		}
		String cPath = request.getContextPath();

		response.sendRedirect(url);
	}

	// by욱현.로그인 폼 요청 처리_2021222
	@RequestMapping("/users/login_form")
		public ModelAndView loginform(HttpServletRequest request, ModelAndView mView) {
			usersService.loginformLogic(request, mView);
			
			mView.setViewName("users/login_form");
			
			return mView;
		}

	// by욱현.회원가입폼_2021222
	@RequestMapping("/signup")
	public String signupForm() {
		
		return "users/signup_form.page";
	}

	// by욱현.내가 쓴 리뷰 모아보기 페이지 요청 처리_2021309
	@RequestMapping("/user/{id}/review")
	public String myReview(@PathVariable Long id) {

		return "users/private/my_review.page";
	}

	// by욱현.내가 쓴 리뷰 모아보기 페이지 요청 처리_2021309
	@RequestMapping("/user/{id}/reply")
	public String myReply(@PathVariable Long id) {

		return "users/private/my_reply.page";
	}

	// by욱현.내가 쓴 리뷰 모아보기 페이지 요청 처리_2021309
	@RequestMapping("/user/{id}/search")
	public String myRecent(@PathVariable Long id) {

		return "users/private/recentSearch.page";
	}

}