package com.acorn5.booking.cart.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.cart.entity.Cart;

public interface CartService {
	// by준영, 장바구니 담기(저장) 처리_210308
	public void insertCart(Cart dto, HttpServletRequest request);

	// by준영, 북카트 리스트_210308
	public void listCart(ModelAndView mView, HttpServletRequest request);

	// by, 카트 개별 삭제 요청처리_210310
	public void deleteCart(Long id);

	// by준영, 체크된 카트 삭제_210313
	public void deleteChk(Long ajaxMsg);

	// by준영, 북카트 내 도서 수량변경_210310
	public void update(Cart dto);

	// by준영, 결제완료시 해당상품 삭제_210314
	public void deletPay(Long id, HttpServletRequest request);

	public List<Cart> getCart(Long id);
}
