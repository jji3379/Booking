package com.acorn5.booking.pay.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.pay.dto.CartDto;
import com.acorn5.booking.pay.entity.Cart;

public interface CartService {
	//by준영, 장바구니 담기(저장) 처리_210308
	public void insertCart(Cart dto,HttpServletRequest request);
	//by준영, 북카트 리스트_210308
	public void listCart(ModelAndView mView,HttpServletRequest request);
	//by, 카트 개별 삭제 요청처리_210310
	public void deleteCart(Cart c_id);
	//by준영, 체크된 카트 삭제_210313
	public void deleteChk(Long ajaxMsg);
	//by준영, 북카트 내 도서 수량변경_210310
	public void update(Cart dto);
	//by준영, 결제완료시 해당상품 삭제_210314
	public void deletPay(Long id,HttpServletRequest request);
	
}
