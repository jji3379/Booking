package com.acorn5.booking.users.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.filter.LoginDto;
import com.acorn5.booking.pay.repository.CartRepository;
import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.dto.ReviewDto;
import com.acorn5.booking.review.service.ReviewService;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UserInfoDto;
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
	public ModelAndView update(Users dto, HttpSession session, ModelAndView mView) {
		usersService.updateUser(dto, session);
		mView.setViewName("users/private/update");
		
		return mView;
	}
	
	//by욱현.개인정보 수정폼 요청 처리_2021222
	@RequestMapping("/users/private/updateform")
	public ModelAndView updateform(ModelAndView mView, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("id");
		Users userDetail = usersService.getInfo(id);
		
		if (id != null) {
			// by 우석, view page 에서 cartitem 불러오기_210315
			cartservice.listCart(mView, request);
		}
		//String id = (String)session.getAttribute("id");
		//UsersDto dto= dao.getData(id);
		mView.addObject("dto", userDetail);
		mView.addObject("care", userDetail.getCare());
		mView.setViewName("users/private/updateform.page");
		return mView;
	}
	
	//by욱현.프로필 이미지 업로드 요청 처리_2021222
	@RequestMapping("/users/private/profile_upload")
	public String profile_upload(MultipartFile image, HttpServletRequest request) {
		//서비스를 이용해서 업로드 이미지를 저장하고 
		usersService.saveProfileImage(image, request);
		//회원 수정페이지로 다시 리다일렉트 시키기 
		return "redirect:/users/private/updateform.do";
	}
	
	//by욱현.비밀번호 수정 요청 처리_2021222
	@RequestMapping("/users/private/pwd_update")
	public ModelAndView pwd_update(ModelAndView mView, Users dto, 
			HttpServletRequest request, HttpSession session) {
		//UsersDto 에는 폼전송된 구비밀번호, 새비밀번호가 담겨 있다.
		usersService.updateUserPwd(mView, dto, request, session);
		mView.setViewName("users/private/pwd_update");
		return mView;
	}
	
	//by욱현.비밀번호 수정 폼 요청 처리_2021222
	@RequestMapping("/users/private/pwd_updateform")
	public ModelAndView pwd_updateform(ModelAndView mView ,HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("id");
		if (id != null) {
			// by 우석, view page 에서 cartitem 불러오기_210315
			cartservice.listCart(mView, request);
		}
		
		//Users dto= dao.getData(id);
    	Users dto = usersService.getInfo(id);
		mView.addObject("dto", dto);
	
		mView.setViewName("users/private/pwd_updateform.page");
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
	public ModelAndView info(ModelAndView mView, HttpServletRequest request, Pageable pageable) {
		
		Long id = (Long) request.getSession().getAttribute("id");
		if (id != null) {
			// by 우석, view page 에서 cartitem 불러오기_210315
			cartservice.listCart(mView, request);
		}
		//Users userDetail = usersService.getInfo(id);
		
		mView.addObject("reviewCount", usersService.getMyReview(id, pageable).getNumberOfElements());
		//mView.addObject("dto", userDetail);
		//mView.addObject("care", userDetail.getCare());
		mView.setViewName("users/private/info.page");
		return mView;
	}
	
	
	//by욱현.로그 아웃 요청 처리_2021222
	@RequestMapping("/users/logout")
	public String logout(HttpSession session) {
		// session.invalidate(); //세션 초기화 
		session.removeAttribute("id"); //세션에서 id 삭제
		session.removeAttribute("loginId"); //세션에서 id 삭제
		return "users/logout";
	}
	
	@RequestMapping(value = "/users/login", method = RequestMethod.POST)
	public void login(HttpServletRequest request, HttpServletResponse response, LoginDto loginDto) throws IOException {
		//로그인에 관련된 로직을 서비스를 통해서 처리한다.
		usersService.loginLogic(request, response, loginDto);

		String url = request.getParameter("url");
		// GET 방식 전송 파라미터를 query 문자열로 읽어오기 ( a=xxx&b=xxx&c=xxx )
		String query = request.getQueryString();
		// 특수 문자는 인코딩을 해야한다.
		String encodedUrl = null;
		if (query == null) {// 전송 파라미터가 없다면
			encodedUrl = URLEncoder.encode(url);
		} else {
			// 원래 목적지가 /test/xxx.jsp 라고 가정하면 아래와 같은 형식의 문자열을 만든다.
			// "/test/xxx.jsp?a=xxx&b=xxx ..."
			encodedUrl = URLEncoder.encode(url + "?" + query);
		}
		// 3. 로그인을 하지 않았으면 로그인 폼으로 이동할수 있도록 리다일렉트 응답을 준다.
		String cPath = request.getContextPath();
		// ServletResponse type 을 HttpServletResponse type 으로 casting
		// 리다일렉트 시킬때 원래 목적지 정보를 url 라는 파라미터 명으로 같이 보낸다.
		response.sendRedirect(url);
	}
	
	//by욱현.로그인 폼 요청 처리_2021222
	@RequestMapping("/users/login_form")
	public ModelAndView loginform(HttpServletRequest request, ModelAndView mView) {
		//로그인 폼에 관련된 로직을 서비스를 통해서 처리한다.
		usersService.loginformLogic(request, mView);
		//view page 정보도 담는다.
		mView.setViewName("users/login_form");
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
	public ModelAndView myReview(ModelAndView mView, HttpServletRequest request, Pageable pageable) {
		Long id = (Long) request.getSession().getAttribute("id");
		if (id != null) {
			// by 우석, view page 에서 cartitem 불러오기_210315
			cartservice.listCart(mView, request);
		}
		usersService.getMyReview(id, pageable);
		mView.setViewName("users/private/my_review.page");
				
		return mView;
	}
	//by욱현.내가 쓴 리뷰 모아보기 페이지 요청 처리_2021309
	@RequestMapping("/users/private/my_reply.do")
	public ModelAndView myReply(HttpSession session, ModelAndView mView, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("id");
		if (id != null) {
			// by 우석, view page 에서 cartitem 불러오기_210315
			cartservice.listCart(mView, request);
		}
		
		mView.setViewName("users/private/my_reply.page");
				
		return mView;
	}
	//by욱현.내가 쓴 리뷰 모아보기 페이지 요청 처리_2021309
		@RequestMapping("/users/private/recentSearch.do")
		public ModelAndView myRecent(HttpSession session, ModelAndView mView, HttpServletRequest request) {
			Long id = (Long) request.getSession().getAttribute("id");
			if (id != null) {
				// by 우석, view page 에서 cartitem 불러오기_210315
				cartservice.listCart(mView, request);
			}
			
			mView.setViewName("users/private/recentSearch.page");
					
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
	public void deleteProfile(@RequestParam Long id) {
		usersService.deleteProfile(id);
	}
		
}