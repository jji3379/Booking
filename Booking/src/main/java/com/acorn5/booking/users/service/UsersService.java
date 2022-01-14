package com.acorn5.booking.users.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.filter.LoginDto;
import com.acorn5.booking.pay.entity.Cart;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.users.dto.UserInfoDto;
import com.acorn5.booking.users.dto.UsersDto;
import com.acorn5.booking.users.entity.Search;
import com.acorn5.booking.users.entity.Users;

@Service
public interface UsersService {
	
	//회원 가입 처리를 하는 메소드 
	public Users addUser(Users users);
	//아이디가 존재하는지 여부를 리턴하는 메소드
	public boolean isExistId(String signupId);
	//로그인폼에 관련된 처리를 하는 메소드
	public void loginformLogic(HttpServletRequest request,
			ModelAndView mView);
	//로그인 관련 처리를 하는 메소드
	public Users loginLogic(HttpServletRequest request,
			HttpServletResponse response, LoginDto loginDto);
	//개인정보를 ModelAndView  객체에 담아주는 메소드
	public Users getInfo(Long id);
	//개인정보를 삭제하는 처리를 하는 메소드
	public void deleteUser(HttpSession session);
	//비밀번호를 수정하는 처리를 하고 성공 여부를 ModelAndView 객체에 담는 메소드
	public void updateUserPwd(ModelAndView mView, Users dto, HttpServletRequest request,
			HttpSession session);
	public String getPwd(Long id);
	//프로필 이미지를 upload 폴더에 저장하고 저장된 파일명을 DB 에 저장하는 메소드
	public void saveProfileImage(MultipartFile image, 
			HttpServletRequest request);
	//개인정보를 수정하는 메소드(여기에서는 이메일 주소만)
	public void updateUser(Users dto, HttpSession session);
	
	//관심사와 이메일정보 얻기
	public Users getCareEmail(Long id);
	
	public void deleteProfile(Users inputId);
	
	public Page<Review> getMyReview(Long id, Pageable pageable);

	public Page<ReviewDtl> getMyReply(Long id, Pageable pageable);
	
	public Page<Cart> getMyCart(Long id, Pageable pageable);

	public Page<Search> getMySearch(Long id, Pageable pageable);
}
