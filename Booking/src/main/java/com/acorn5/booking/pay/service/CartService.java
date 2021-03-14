package com.acorn5.booking.pay.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.pay.dto.CartDto;

public interface CartService {
	//책의 정보를 DB에 저장하는 메소드
	public void insertCart(CartDto dto,HttpServletRequest request);
	//장바구니 리스트 메소드
	public void listCart(ModelAndView mView,HttpServletRequest request);
	//장바구니에서 삭제하는 메소드
	public void deleteCart(int c_id);
	//체크 삭제 메소드
	public void deleteChk(String[] ajaxMsg);
	//책 수량 변경하는 메소드
	public void update(CartDto dto);
	//결제완료시 삭제
	public void deletPay(String id);
	
}
