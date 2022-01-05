package com.acorn5.booking.users.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.pay.repository.CartRepository;
import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.dto.ReviewDto;
import com.acorn5.booking.review.service.ReviewService;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UsersDto;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.service.UsersService;

@Controller
public class UsersViewController {
	
	@Autowired
	private UsersService usersService;
	
	//by우석, navbar cartitem count 보이기위한 cartservice 주입_20210315
	@Autowired
	private CartService cartservice;
	
	//@Autowired //by욱현.리뷰서비스를 사용하기 위해 di_2021309
	private ReviewService reviewService;
	
	//@Autowired //by욱현.비밀번호, 회원정보 수정 폼에서도 프로필이미지를 볼수있게 하기위해_2021315
	//UsersDao dao;
	
	//by욱현. 개인 정보 수정 요청 처리_2021222
	@RequestMapping(value = "/users/private/update", 
			method = RequestMethod.POST)
	public ModelAndView update(Users dto, HttpSession session,
			ModelAndView mView) {
		usersService.updateUser(dto, session);
		mView.setViewName("users/private/update");
		
		return mView;
	}
	
	//by욱현.개인정보 수정폼 요청 처리_2021222
	@RequestMapping("/users/private/updateform")
	public ModelAndView updateform(ModelAndView mView, 
			HttpSession session,HttpServletRequest request) {
		usersService.getInfo(mView, session);
		Long id=(Long)request.getSession().getAttribute("id");
    	if(id!=null) {
    		//by 우석, view page 에서 cartitem 불러오기_210315
        	cartservice.listCart(mView, request);
    	}
		//String id = (String)session.getAttribute("id");
		//UsersDto dto= dao.getData(id);
		//mView.addObject("dto", dto);
		mView.setViewName("users/private/updateform");
		return mView;
	}
	
	//by욱현.프로필 이미지 업로드 요청 처리_2021222
	@RequestMapping("/users/private/profile_upload")
	public String profile_upload(MultipartFile image, 
			HttpServletRequest request) {
		//서비스를 이용해서 업로드 이미지를 저장하고 
		usersService.saveProfileImage(image, request);
		//회원 수정페이지로 다시 리다일렉트 시키기 
		return "redirect:/users/private/updateform.do";
	}
	
	//by욱현.비밀번호 수정 요청 처리_2021222
	@RequestMapping("/users/private/pwd_update")
	public ModelAndView pwd_update(ModelAndView mView, Users dto, HttpServletRequest request,
			HttpSession session) {
		//UsersDto 에는 폼전송된 구비밀번호, 새비밀번호가 담겨 있다.
		usersService.updateUserPwd(mView, dto, request, session);
		mView.setViewName("users/private/pwd_update");
		return mView;
	}
	
	//by욱현.비밀번호 수정 폼 요청 처리_2021222
	@RequestMapping("/users/private/pwd_updateform")
	public ModelAndView pwd_updateform(HttpSession session, ModelAndView mView
			,HttpServletRequest request) {
		Long id=(Long)request.getSession().getAttribute("id");
    	if(id!=null) {
    		//by 우석, view page 에서 cartitem 불러오기_210315
        	cartservice.listCart(mView, request);
    	}
		
		//Users dto= dao.getData(id);
    	Users dto = usersService.getInfo(mView, session);
		mView.addObject("dto", dto);
	
		mView.setViewName("users/private/pwd_updateform");
		return mView;
	}
	
	//by욱현.회원 탈퇴 요청 처리_2021222
	@RequestMapping("/users/private/delete")
	public String delete(HttpSession session) {
		usersService.deleteUser(session);
		return "users/private/delete";
	}
	
	//by욱현.개인정보 보기 요청처리_2021222
	@RequestMapping("/users/private/info")
	public ModelAndView info(ModelAndView mView, HttpSession session
			,HttpServletRequest request) {
		
		usersService.getInfo(mView, session);
		Long id=(Long)request.getSession().getAttribute("id");
    	if(id!=null) {
    		//by 우석, view page 에서 cartitem 불러오기_210315
        	cartservice.listCart(mView, request);
    	}
		mView.setViewName("users/private/info.page");
		return mView;
	}
	
	
	//by욱현.로그 아웃 요청 처리_2021222
	@RequestMapping("/users/logout")
	public String logout(HttpSession session) {
		// session.invalidate(); //세션 초기화 
		session.removeAttribute("id"); //세션에서 id 삭제
		
		return "users/logout";
	}
	
	//by욱현.로그인 폼 요청 처리_2021222
	@RequestMapping("/users/login_form")
	public ModelAndView loginform(HttpServletRequest request, 
			ModelAndView mView) {
		//로그인 폼에 관련된 로직을 서비스를 통해서 처리한다.
		usersService.loginformLogic(request, mView);
		//view page 정보도 담는다.
		mView.setViewName("users/login_form.page");
		//리턴
		return mView;
	}
	
	//by욱현.회원 가입 요청처리_2021222
		/*form 전송은 보통 post 방식 요청인데 post 방식 요청만 받아들이도록 
		컨트롤러에 설정하는게 일반적이다.*/ 
	/*
	@RequestMapping(value = "/users/signup", method = RequestMethod.POST)
	public String signup(@ModelAttribute("dto") Users dto) {
		usersService.addUser(dto);
		return "users/signup";
	}
	*/
	//by욱현.회원가입폼_2021222
	@RequestMapping("/signup_form")
	public String signupForm() {
		return "users/signup_form.page";
	}
	
	//by욱현.중복아이디 검사를 위한 ajax 요청 처리_2021222 
	@RequestMapping("/users/checkid")
	@ResponseBody
	public Map<String, Object> checkid(@RequestParam String loginId,
			ModelAndView mView) {
		//서비스를 이용해서 해당 아이디가 존재하는지 여부를 알아낸다.
		//String isExist=usersService.isExistId(loginId);
		// {"isExist":true} or {"isExist":false} 를 응답하기 위한 Map 구성
		Map<String, Object> map=new HashMap<String, Object>();
		//map.put("isExist", isExist);
		return map;
	}
	
	
	//by욱현.내가 쓴 리뷰 모아보기 페이지 요청 처리_2021309
	@RequestMapping("/users/private/my_review.do")
	public ModelAndView myReview(HttpSession session, ModelAndView mView, HttpServletRequest request) {
		Long id=(Long)request.getSession().getAttribute("id");
    	if(id!=null) {
    		//by 우석, view page 에서 cartitem 불러오기_210315
        	cartservice.listCart(mView, request);
    	}
		List<ReviewDto> list = reviewService.getMyReview(session, mView, request); // 내가 쓴 리뷰를 셀렉트하기 위한 비즈니스 로직 메소드 실행
		mView.addObject("list", list);
		mView.setViewName("users/private/my_review");
				
		return mView;
	}
	
	//by욱현. 가입정보수정폼에서 db에있는 이메일, 관심사 와 수정내용 비교하기 위_2021323
	@RequestMapping("/users/private/check_update.do")
	@ResponseBody
	public Map<String, String> checkUpdate(@RequestParam Long id){
		Users dto = usersService.getCareEmail(id);
		String care = dto.getCare();
		String email = dto.getEmail();
		String image = dto.getProfile();
		Map<String, String> data = new HashMap<String, String>();
		data.put("care", care);
		data.put("email", email);
		data.put("image", image);
		return data;
	}
	
	
	//by욱현. 프로필이미지경로 db에서 삭제_2021323
	@RequestMapping("/users/private/delete_profile.do")
	@ResponseBody
	public void deleteProfile(@RequestParam Users inputId) {
		usersService.deleteProfile(inputId);
	}
		
}